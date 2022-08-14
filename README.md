From: https://www.youtube.com/watch?v=xBFWMYmm9ro

## Rx operators

check out https://rxmarbles.com/#from

## switchMap

switchMap is basically asyncly mapping a stream to another, however if the source emits a new event, previous mapped stream will disapear.
![image](https://firebasestorage.googleapis.com/v0/b/mymemo-98f76.appspot.com/o/uploads%2FSIvHI3wJfEPSACxfj6WH1l53vZx1%2F8e113b29-cc81-46b3-82e3-71053bcfc6c5.gif?alt=media&token=d3d15113-f34d-4511-a809-7dc57535f2c4)

```dart
final subject = useMemoized(() => BehaviorSubject<DateTime>());
final stream = useMemoized(() => subject.switchMap((dateTime) =>
    Stream.periodic(const Duration(seconds: 1),
        (count) => 'Stream count($count), DateTime:$dateTime')));
useEffect(() => subject.close, [key]);
return Scaffold(
  appBar: AppBar(title: const Text('Home Page')),
  body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    StreamBuilder<String>(
        stream: stream,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final str = snapshot.requireData;
            return Text(str);
          } else {
            return const Text('Waiting stream');
          }
        }),
    TextButton(
        onPressed: () => subject.add(DateTime.now()),
        child: const Text('Start the stream'))
  ]),
);
```

## zip

```dart
final stream1 = Stream.periodic(
    const Duration(seconds: 1), (count) => 'Stream 1, count:$count');
final stream2 = Stream.periodic(
    const Duration(seconds: 3), (count) => 'Stream 2, count:$count');
final zipped = Rx.zip([stream1, stream2], ((values) => values.join(' & ')));
zipped.listen((event) {
  event.log();
});
// machanism just like the real zipper
// maybe useful when dealing with parallel actions
// Stream 1, count:0 & Stream 2, count:0
// Stream 1, count:1 & Stream 2, count:1
// Stream 1, count:2 & Stream 2, count:2
// Stream 1, count:3 & Stream 2, count:3
// Stream 1, count:4 & Stream 2, count:4
```

## merge

```dart
final stream1 = Stream.periodic(
    const Duration(seconds: 1), (count) => 'Stream 1, count:$count');
final stream2 = Stream.periodic(
    const Duration(seconds: 3), (count) => 'Stream 2, count:$count');
final concated = Rx.merge([stream1, stream2]);
concated.listen((event) {
  event.log();
});
// useful when making immediate ui changes
// Stream 1, count:0
// Stream 1, count:1
// Stream 1, count:2
// Stream 2, count:0
// Stream 1, count:3
// Stream 1, count:4
// Stream 1, count:5
// Stream 2, count:1
// Stream 1, count:6
// Stream 1, count:7
// Stream 1, count:8
// Stream 2, count:2
// Stream 1, count:9
```

## concat

```dart
final stream1 = Stream.periodic(
    const Duration(seconds: 1), (count) => 'Stream 1, count:$count').take(3);
final stream2 = Stream.periodic(
    const Duration(seconds: 3), (count) => 'Stream 2, count:$count');
final concated =
    stream1.concatWith([stream2]); // Rx.concat([stream1, stream2]);
concated.listen((event) {
  event.log();
});
// concated stream will hold on emits until the stream before closes
// useful when making transaction-like actions, that each of actions must be successful to continue to next actions
// Stream 1, count:0
// Stream 1, count:1
// Stream 1, count:2
// Stream 2, count:0
// Stream 2, count:1
// Stream 2, count:2
```

## conbimeLatest

```dart
final stream1 = Stream.periodic(
      const Duration(seconds: 1), (count) => 'Stream 1, count:$count');
final stream2 = Stream.periodic(
      const Duration(seconds: 3), (count) => 'Stream 2, count:$count');
final combined =
      Rx.combineLatest([stream1, stream2], (values) => values.join(' & '));
combined.listen((event) {
    event.log();
});
// all the stream must have had emitted value to be combined
// useful when there are several ui widget-states, and make some api calls considering all the states combined
// flutter: Stream 1, count:2 & Stream 2, count:0
// flutter: Stream 1, count:3 & Stream 2, count:0
// flutter: Stream 1, count:4 & Stream 2, count:0
// flutter: Stream 1, count:5 & Stream 2, count:0
// flutter: Stream 1, count:5 & Stream 2, count:1
// flutter: Stream 1, count:6 & Stream 2, count:1
// flutter: Stream 1, count:7 & Stream 2, count:1
// flutter: Stream 1, count:8 & Stream 2, count:1
// flutter: Stream 1, count:8 & Stream 2, count:2
// flutter: Stream 1, count:9 & Stream 2, count:2
// flutter: Stream 1, count:10 & Stream 2, count:2
// flutter: Stream 1, count:11 & Stream 2, count:2
// flutter: Stream 1, count:11 & Stream 2, count:3
```

## make api calls when user input changes

### [demo](https://github.com/jinyongnan810/flutter_rx/compare/1418b65ab397e6f37aca8d6e459ee1a9c1ba1631...0fbfe211441d2e79f39653e8313ae8a000366e5a)

![image](https://firebasestorage.googleapis.com/v0/b/mymemo-98f76.appspot.com/o/uploads%2FSIvHI3wJfEPSACxfj6WH1l53vZx1%2F7090b2c6-d7b3-492f-9a1b-e3b685fe9da5.gif?alt=media&token=aefd30ab-93ca-4803-ba43-63c43af092af)

core rx logic

```dart
    final textChanges = BehaviorSubject<String>();
    final results = textChanges
        .distinct()
        // wait until user stops typing
        .debounceTime(const Duration(milliseconds: 300))
        // often use switchMap to handle async actions
        .switchMap<SearchResult?>((text) {
          // create null stream
          if (text.isEmpty) return Stream<SearchResult?>.value(null);
          // do async action with Rx.fromCallable
          return Rx.fromCallable(() => api.search(text))
            // only for demonstration
            .delay(const Duration(seconds: 1))
            // collect api response
            .map((things) {
              return things.isEmpty
                ? const SearchResultNoResult()
                : SearchResultWithResults(things);
            })
            // manually stream a starter event(in this case for showing loading indicator)
            .startWith(const SearchResultLoading())
            // handle error cases by emit a special event
            .onErrorReturnWith(
              (error, stackTrace) => SearchResultHasError(error));
    });
```

## use hooks instead of making StatefulWidget

### useMemoized

Maintain an instance , and create a new instance when dependency changes.

```dart
final subject = useMemoized(() => BehaviorSubject<String>(), [key]);
```

### useEffect

Make an operation when dependency changes

```dart
useEffect(() => subject.close, [subject]);
```

## BehaviorSubject

New listeners will get last event.

## debounceTime

The stream will not emit events when continuesly getting new events, until had rest of a time period after last event.

```dart
subject.stream.distinct().debounceTime(const Duration(seconds: 1)),
```
