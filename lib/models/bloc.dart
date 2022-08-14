import 'package:rxdart/rxdart.dart';

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
