From: https://www.youtube.com/watch?v=xBFWMYmm9ro

## Rx operators

check out https://rxmarbles.com/#from

## log in/out & curd data

- authentications & save contacts in firebase firestore([repo](https://github.com/jinyongnan810/flutter_rx))

![image](https://firebasestorage.googleapis.com/v0/b/mymemo-98f76.appspot.com/o/uploads%2FSIvHI3wJfEPSACxfj6WH1l53vZx1%2Fc0fbf908-1f22-46c5-8d64-8990cc72790b.gif?alt=media&token=ecea1324-6ced-4b30-b8a7-5eac7e8c32be)

## make async actions & concat

```dart
// read from file, make stream from future, and transfrom to a new stream
Stream<String> getNames({required String path}) {
  final names = rootBundle.loadString(path);
  return Stream.fromFuture(names).transform(const LineSplitter());
}
// concat streams
Stream<String> getAllNames() => getNames(path: 'assets/cats.txt').concatWith(
    [getNames(path: 'assets/dogs.txt')]).delay(const Duration(seconds: 2));
// await for the stream to finish and show future result as a list
return Scaffold(
      appBar: AppBar(title: const Text('Chapter 10 concat')),
      // to string makes a stream to become a future that waits for all the events and return list
      body: FutureBuilder<List<String>>(
        future: getAllNames().toList(),
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              final names = snapshot.data ?? [];
              return ListView.builder(
                itemBuilder: ((context, index) => ListTile(
                      title: Text(names[index]),
                    )),
                itemCount: names.length,
              );
          }
        },
      ),
    );
```

## using combineLatest to build up full name

![image](https://firebasestorage.googleapis.com/v0/b/mymemo-98f76.appspot.com/o/uploads%2FSIvHI3wJfEPSACxfj6WH1l53vZx1%2F8b334993-e705-4d1a-b782-ed0c3f0ee063.gif?alt=media&token=ff9f5c96-4aeb-4184-a828-61ae9ea15883)

```dart
// 1. define bloc
class Bloc {
  final Sink<String?> setFirst;
  final Sink<String?> setLast;
  final Stream<String> full;
  const Bloc._({
    required this.setFirst,
    required this.setLast,
    required this.full,
  });

  void dispose() {
    setFirst.close();
    setLast.close();
  }

  factory Bloc() {
    final firstSubject = BehaviorSubject<String?>();
    final lastSubject = BehaviorSubject<String?>();
    final full = Rx.combineLatest2<String?, String?, String>(
        firstSubject, lastSubject, (first, last) {
      if (first == null || last == null || first.isEmpty || last.isEmpty) {
        return 'First and last name must be provided';
      }
      return '$first $last';
    }).startWith('First and last name must be provided');

    return Bloc._(
        setFirst: firstSubject.sink, setLast: lastSubject.sink, full: full);
  }
}
// 2. use bloc
final bloc = useMemoized(() => Bloc());
useEffect(() => bloc.dispose, [key]);
return Scaffold(
  appBar: AppBar(title: const Text('Chapter 9 Full Name')),
  body: Column(children: [
    TextField(
      decoration: const InputDecoration(label: Text('First Name')),
      onChanged: (first) => bloc.setFirst.add(first),
    ),
    TextField(
      decoration: const InputDecoration(label: Text('Last Name')),
      onChanged: (last) => bloc.setLast.add(last),
    ),
    StreamBuilder<String>(
        stream: bloc.full,
        builder: (ctx, snapShot) {
          final fullName = snapShot.data ?? '';
          return Center(
            child: Text(fullName),
          );
        })
  ]),
);
```

## using map bloc to filter by user choices (inlcudes FilterChip)

![image](https://firebasestorage.googleapis.com/v0/b/mymemo-98f76.appspot.com/o/uploads%2FSIvHI3wJfEPSACxfj6WH1l53vZx1%2Fb0613aba-d1da-4b9e-a629-7e0429b7bc52.gif?alt=media&token=7cdc49bb-8d08-4e64-8d1c-3f3c9af062a6)

```dart
// step 1. define filtering bloc
class Bloc {
  final Sink<TypeOfThings?> setTypeOfThing;
  final Stream<TypeOfThings?> currentTypeOfThing;
  final Stream<Iterable<Thing>> things;
  const Bloc._({
    required this.setTypeOfThing,
    required this.currentTypeOfThing,
    required this.things,
  });

  void dispose() {
    setTypeOfThing.close();
  }

  factory Bloc({
    required Iterable<Thing> things,
  }) {
    final subject = BehaviorSubject<TypeOfThings?>();
    final filteredThings = subject
        .debounceTime(const Duration(milliseconds: 300))
        .map<Iterable<Thing>>((type) =>
            type != null ? things.where((thing) => thing.type == type) : things)
        .startWith(things);
    return Bloc._(
        setTypeOfThing: subject.sink,
        currentTypeOfThing: subject.stream,
        things: filteredThings);
  }
}
// step 2. using bloc
final bloc = useMemoized(() => Bloc(things: things));
useEffect(() => bloc.dispose, [key]);
return Scaffold(
  appBar: AppBar(title: const Text('Chapter 8 FilterChip')),
  body: Column(children: [
    StreamBuilder<TypeOfThings?>(
        stream: bloc.currentTypeOfThing,
        builder: (ctx, snapShot) {
          final selectedType = snapShot.data;
          return Wrap(
            children: TypeOfThings.values.map((type) {
              return FilterChip(
                  selectedColor: Colors.blueAccent[100],
                  label: Text(type.name),
                  selected: selectedType == type,
                  onSelected: (selected) {
                    final typeToSelect = selected ? type : null;
                    bloc.setTypeOfThing.add(typeToSelect);
                  });
            }).toList(),
          );
        }),
    StreamBuilder<Iterable<Thing>>(
      stream: bloc.things,
      builder: (ctx, snapShot) {
        final things = snapShot.data ?? [];
        return Expanded(
            child: ListView.builder(
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text(
                  '(${things.elementAt(index).type.name})${things.elementAt(index).name}'),
            );
          },
          itemCount: things.length,
        ));
      },
    )
  ]),
);
```

## switchMap

switchMap is basically asyncly mapping a stream to another, however if the source emits a new event, previous mapped stream will disapear.(while flatMap won't dispose the previous mapped streams)

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
