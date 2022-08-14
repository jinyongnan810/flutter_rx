import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rx/async_snapshot_builder.dart';
import 'package:flutter_rx/models/bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapter 8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        AsyncSnapshotBuilder<String>(
            stream: bloc.full,
            onActive: (ctx, snapShot) {
              final fullName = snapShot ?? '';
              return Center(
                child: Text(fullName),
              );
            }),
      ]),
    );
  }
}
