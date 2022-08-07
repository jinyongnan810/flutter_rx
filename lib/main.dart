import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
      title: 'Flutter Rx',
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
    // maintain an instance of BehaviorSubject<String>
    // when key changes, create a new instance
    final subject = useMemoized(() => BehaviorSubject<String>(), [key]);
    // when subjects changes(in this case rebuilds), run subject.close
    useEffect(() => subject.close, [subject]);
    return Scaffold(
      appBar: AppBar(
          title: StreamBuilder(
        stream:
            // distinct to get distinct stream data
            // debounceTime to limit stream emit to once a time period
            subject.stream.distinct().debounceTime(const Duration(seconds: 1)),
        initialData: 'Please enter text...',
        builder: (ctx, snapshot) => Text(snapshot.requireData.toString()),
      )),
      body: Center(
          child: TextField(
        // sink is write only stream
        // while stream is read only stream
        onChanged: subject.sink.add,
      )),
    );
  }
}
