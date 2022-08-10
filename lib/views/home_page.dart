import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rx/bloc/api.dart';
import 'package:flutter_rx/bloc/search_bloc.dart';
import 'package:flutter_rx/views/search_result.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(() => SearchBloc(api: Api()), [key]);
    useEffect(() => bloc.dispose, [bloc]);
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: bloc.search.add,
          ),
          const SizedBox(
            height: 20,
          ),
          SearchResultView(searchResult: bloc.results)
        ],
      ),
    );
  }
}
