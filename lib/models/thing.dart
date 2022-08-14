import 'package:flutter_rx/models/type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'thing.freezed.dart';
part 'thing.g.dart';

@freezed
class Thing with _$Thing {
  const factory Thing({
    required TypeOfThings type,
    required String name,
  }) = _Thing;
  factory Thing.fromJson(Map<String, Object?> json) => _$ThingFromJson(json);
}
