import 'package:flutter/foundation.dart';
import 'package:flutter_rx/models/thing.dart';

enum AnimalType { dog, cat, rabbit, unknown }

@immutable
class Animal extends Thing {
  final AnimalType type;
  const Animal({required this.type, required String name}) : super(name: name);
  @override
  String toString() {
    return 'Animal (type:$type, name:$name)';
  }

  factory Animal.fromJson(Map<String, dynamic> json) {
    final AnimalType type;
    switch ((json['type'] as String).toLowerCase().trim()) {
      case 'dog':
        type = AnimalType.dog;
        break;
      case 'cat':
        type = AnimalType.cat;
        break;
      case 'rabbit':
        type = AnimalType.rabbit;
        break;
      default:
        type = AnimalType.unknown;
        break;
    }
    return Animal(type: type, name: json['name'] as String);
  }
}
