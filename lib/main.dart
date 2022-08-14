import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subject = useMemoized(() => BehaviorSubject<DateTime>());
    final stream = useMemoized(() => subject.switchMap((dateTime) =>
        Stream.periodic(const Duration(seconds: 1),
            (count) => 'Stream count($count), DateTime:$dateTime')));
    useEffect(() => subject.close, [key]);
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        StreamBuilder<String>(
            stream: stream,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                final str = snapshot.requireData;
                return Text(str);
              } else {
                return const Text('Waiting stream');
              }
            }),
        TextButton(
            onPressed: () => subject.add(DateTime.now()),
            child: const Text('Start the stream'))
      ]),
    );
  }
}
