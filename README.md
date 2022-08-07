From: https://www.youtube.com/watch?v=xBFWMYmm9ro

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
