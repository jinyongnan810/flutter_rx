import 'package:flutter/material.dart';
import 'package:flutter_rx/bloc/search_result.dart';
import 'package:flutter_rx/models/animal.dart';
import 'package:flutter_rx/models/person.dart';

class SearchResultView extends StatelessWidget {
  final Stream<SearchResult?> searchResult;
  const SearchResultView({Key? key, required this.searchResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchResult?>(
        stream: searchResult,
        builder: (ctx, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final result = snapshot.data;
            if (result is SearchResultHasError) {
              return Text('Getting error: ${result.error}');
            }
            if (result is SearchResultLoading) {
              return const CircularProgressIndicator();
            }
            if (result is SearchResultNoResult) {
              return const Text('No results found...');
            }
            if (result is SearchResultWithResults) {
              final things = result.results;
              print(things);
              return Expanded(
                child: ListView.separated(
                    itemBuilder: ((context, index) {
                      final thing = things[index];
                      final type = (thing is Animal)
                          ? 'Animal'
                          : (thing is Person)
                              ? 'Person'
                              : 'Unknown';
                      return ListTile(
                        title: Text(type),
                        subtitle: Text(thing.toString()),
                      );
                    }),
                    separatorBuilder: (ctx, index) => const Divider(),
                    itemCount: things.length),
              );
            } else {
              return const Text('Unexpected response');
            }
          } else {
            return const Text('Waiting input...');
          }
        });
  }
}
