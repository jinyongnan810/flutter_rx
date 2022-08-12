import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => print(toString());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

Future<void> testIt() async {
  final stream1 = Stream.periodic(
      const Duration(seconds: 1), (count) => 'Stream 1, count:$count');
  final stream2 = Stream.periodic(
      const Duration(seconds: 3), (count) => 'Stream 2, count:$count');
  final concated = Rx.merge([stream1, stream2]);
  concated.listen((event) {
    event.log();
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    testIt();
    'hello'.log();
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
    );
  }
}

// Stream 1, count:0
// Stream 1, count:1
// Stream 1, count:2
// Stream 2, count:0
// Stream 1, count:3
// Stream 1, count:4
// Stream 1, count:5
// Stream 2, count:1
// Stream 1, count:6
// Stream 1, count:7
// Stream 1, count:8
// Stream 2, count:2
// Stream 1, count:9
