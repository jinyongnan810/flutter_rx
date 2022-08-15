import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapter 10 concat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

Stream<String> getNames({required String path}) {
  final names = rootBundle.loadString(path);
  return Stream.fromFuture(names).transform(const LineSplitter());
}

Stream<String> getAllNames() => getNames(path: 'assets/cats.txt').concatWith(
    [getNames(path: 'assets/dogs.txt')]).delay(const Duration(seconds: 2));

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
