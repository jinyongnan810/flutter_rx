import 'package:rxdart/rxdart.dart';

extension Loading<E> on Stream<E> {
  Stream<E> setLoadingTo(
    bool isLoading, {
    required Sink<bool> sink,
  }) =>
      doOnEach((_) {
        sink.add(isLoading);
      });
}

class AuthBloc {}
