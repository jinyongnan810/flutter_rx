import 'package:flutter_rx/bloc/views_bloc/current_view.dart';
import 'package:rxdart/rxdart.dart';

class ViewsBloc {
  final Sink<CurrentView> goToView;
  final Stream<CurrentView> currentView;

  ViewsBloc._({
    required this.goToView,
    required this.currentView,
  });

  void dispose() {
    goToView.close();
  }

  factory ViewsBloc() {
    final subject = BehaviorSubject<CurrentView>();
    return ViewsBloc._(
        goToView: subject.sink,
        currentView: subject.stream.startWith(CurrentView.login));
  }
}
