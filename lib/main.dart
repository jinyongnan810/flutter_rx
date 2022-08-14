import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rx/models/bloc.dart';
import 'package:flutter_rx/models/type.dart';

import 'models/thing.dart';

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

const things = [
  Thing(name: 'Foo', type: TypeOfThings.person),
  Thing(name: 'Bar', type: TypeOfThings.person),
  Thing(name: 'Baz', type: TypeOfThings.person),
  Thing(name: 'Bunz', type: TypeOfThings.animal),
  Thing(name: 'Fluffers', type: TypeOfThings.animal),
  Thing(name: 'Woofz', type: TypeOfThings.animal),
];

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(() => Bloc(things: things));
    useEffect(() => bloc.dispose, [key]);
    return Scaffold(
      appBar: AppBar(title: const Text('Chapter 8 FilterChip')),
      body: Column(children: [
        StreamBuilder<TypeOfThings?>(
            stream: bloc.currentTypeOfThing,
            builder: (ctx, snapShot) {
              final selectedType = snapShot.data;
              return Wrap(
                children: TypeOfThings.values.map((type) {
                  return FilterChip(
                      selectedColor: Colors.blueAccent[100],
                      label: Text(type.name),
                      selected: selectedType == type,
                      onSelected: (selected) {
                        final typeToSelect = selected ? type : null;
                        bloc.setTypeOfThing.add(typeToSelect);
                      });
                }).toList(),
              );
            }),
        StreamBuilder<Iterable<Thing>>(
          stream: bloc.things,
          builder: (ctx, snapShot) {
            final things = snapShot.data ?? [];
            return Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(
                      '(${things.elementAt(index).type.name})${things.elementAt(index).name}'),
                );
              },
              itemCount: things.length,
            ));
          },
        )
      ]),
    );
  }
}
