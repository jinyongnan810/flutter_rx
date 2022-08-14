// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Thing _$$_ThingFromJson(Map<String, dynamic> json) => _$_Thing(
      type: $enumDecode(_$TypeOfThingsEnumMap, json['type']),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_ThingToJson(_$_Thing instance) => <String, dynamic>{
      'type': _$TypeOfThingsEnumMap[instance.type]!,
      'name': instance.name,
    };

const _$TypeOfThingsEnumMap = {
  TypeOfThings.animal: 'animal',
  TypeOfThings.person: 'person',
};
