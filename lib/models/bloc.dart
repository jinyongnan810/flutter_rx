import 'package:flutter_rx/models/thing.dart';
import 'package:flutter_rx/models/type.dart';
import 'package:rxdart/rxdart.dart';

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
