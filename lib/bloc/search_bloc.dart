import 'package:flutter_rx/bloc/api.dart';
import 'package:flutter_rx/bloc/search_result.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final Sink<String> search;
  final Stream<SearchResult?> results;
  void dispose() {
    search.close();
  }

  factory SearchBloc({required Api api}) {
    final textChanges = BehaviorSubject<String>();
    final results = textChanges
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap<SearchResult?>((text) {
      if (text.isEmpty) return Stream<SearchResult?>.value(null);
      return Rx.fromCallable(() => api.search(text))
          .map((things) {
            return things.isEmpty
                ? const SearchResultNoResult()
                : SearchResultWithResults(things);
          })
          .startWith(const SearchResultLoading())
          .onErrorReturnWith(
              (error, stackTrace) => SearchResultHasError(error));
    });
    return SearchBloc._(search: textChanges.sink, results: results);
  }
  SearchBloc._({required this.search, required this.results});
}
