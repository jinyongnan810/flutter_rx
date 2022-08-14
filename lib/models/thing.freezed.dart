// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'thing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Thing _$ThingFromJson(Map<String, dynamic> json) {
  return _Thing.fromJson(json);
}

/// @nodoc
mixin _$Thing {
  TypeOfThings get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThingCopyWith<Thing> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThingCopyWith<$Res> {
  factory $ThingCopyWith(Thing value, $Res Function(Thing) then) =
      _$ThingCopyWithImpl<$Res>;
  $Res call({TypeOfThings type, String name});
}

/// @nodoc
class _$ThingCopyWithImpl<$Res> implements $ThingCopyWith<$Res> {
  _$ThingCopyWithImpl(this._value, this._then);

  final Thing _value;
  // ignore: unused_field
  final $Res Function(Thing) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeOfThings,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ThingCopyWith<$Res> implements $ThingCopyWith<$Res> {
  factory _$$_ThingCopyWith(_$_Thing value, $Res Function(_$_Thing) then) =
      __$$_ThingCopyWithImpl<$Res>;
  @override
  $Res call({TypeOfThings type, String name});
}

/// @nodoc
class __$$_ThingCopyWithImpl<$Res> extends _$ThingCopyWithImpl<$Res>
    implements _$$_ThingCopyWith<$Res> {
  __$$_ThingCopyWithImpl(_$_Thing _value, $Res Function(_$_Thing) _then)
      : super(_value, (v) => _then(v as _$_Thing));

  @override
  _$_Thing get _value => super._value as _$_Thing;

  @override
  $Res call({
    Object? type = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_Thing(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeOfThings,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Thing with DiagnosticableTreeMixin implements _Thing {
  const _$_Thing({required this.type, required this.name});

  factory _$_Thing.fromJson(Map<String, dynamic> json) =>
      _$$_ThingFromJson(json);

  @override
  final TypeOfThings type;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Thing(type: $type, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Thing'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Thing &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_ThingCopyWith<_$_Thing> get copyWith =>
      __$$_ThingCopyWithImpl<_$_Thing>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ThingToJson(
      this,
    );
  }
}

abstract class _Thing implements Thing {
  const factory _Thing(
      {required final TypeOfThings type,
      required final String name}) = _$_Thing;

  factory _Thing.fromJson(Map<String, dynamic> json) = _$_Thing.fromJson;

  @override
  TypeOfThings get type;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ThingCopyWith<_$_Thing> get copyWith =>
      throw _privateConstructorUsedError;
}
