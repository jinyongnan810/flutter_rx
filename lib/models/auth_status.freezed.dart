// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function(String userId) loggedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function(String userId)? loggedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function(String userId)? loggedIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStatusLoggedOut value) loggedOut,
    required TResult Function(_AuthStatusLoggedIn value) loggedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStatusLoggedOut value)? loggedOut,
    TResult Function(_AuthStatusLoggedIn value)? loggedIn,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStatusLoggedOut value)? loggedOut,
    TResult Function(_AuthStatusLoggedIn value)? loggedIn,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStatusCopyWith<$Res> {
  factory $AuthStatusCopyWith(
          AuthStatus value, $Res Function(AuthStatus) then) =
      _$AuthStatusCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStatusCopyWithImpl<$Res> implements $AuthStatusCopyWith<$Res> {
  _$AuthStatusCopyWithImpl(this._value, this._then);

  final AuthStatus _value;
  // ignore: unused_field
  final $Res Function(AuthStatus) _then;
}

/// @nodoc
abstract class _$$_AuthStatusLoggedOutCopyWith<$Res> {
  factory _$$_AuthStatusLoggedOutCopyWith(_$_AuthStatusLoggedOut value,
          $Res Function(_$_AuthStatusLoggedOut) then) =
      __$$_AuthStatusLoggedOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthStatusLoggedOutCopyWithImpl<$Res>
    extends _$AuthStatusCopyWithImpl<$Res>
    implements _$$_AuthStatusLoggedOutCopyWith<$Res> {
  __$$_AuthStatusLoggedOutCopyWithImpl(_$_AuthStatusLoggedOut _value,
      $Res Function(_$_AuthStatusLoggedOut) _then)
      : super(_value, (v) => _then(v as _$_AuthStatusLoggedOut));

  @override
  _$_AuthStatusLoggedOut get _value => super._value as _$_AuthStatusLoggedOut;
}

/// @nodoc

class _$_AuthStatusLoggedOut implements _AuthStatusLoggedOut {
  const _$_AuthStatusLoggedOut();

  @override
  String toString() {
    return 'AuthStatus.loggedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthStatusLoggedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function(String userId) loggedIn,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function(String userId)? loggedIn,
  }) {
    return loggedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function(String userId)? loggedIn,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStatusLoggedOut value) loggedOut,
    required TResult Function(_AuthStatusLoggedIn value) loggedIn,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStatusLoggedOut value)? loggedOut,
    TResult Function(_AuthStatusLoggedIn value)? loggedIn,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStatusLoggedOut value)? loggedOut,
    TResult Function(_AuthStatusLoggedIn value)? loggedIn,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class _AuthStatusLoggedOut implements AuthStatus {
  const factory _AuthStatusLoggedOut() = _$_AuthStatusLoggedOut;
}

/// @nodoc
abstract class _$$_AuthStatusLoggedInCopyWith<$Res> {
  factory _$$_AuthStatusLoggedInCopyWith(_$_AuthStatusLoggedIn value,
          $Res Function(_$_AuthStatusLoggedIn) then) =
      __$$_AuthStatusLoggedInCopyWithImpl<$Res>;
  $Res call({String userId});
}

/// @nodoc
class __$$_AuthStatusLoggedInCopyWithImpl<$Res>
    extends _$AuthStatusCopyWithImpl<$Res>
    implements _$$_AuthStatusLoggedInCopyWith<$Res> {
  __$$_AuthStatusLoggedInCopyWithImpl(
      _$_AuthStatusLoggedIn _value, $Res Function(_$_AuthStatusLoggedIn) _then)
      : super(_value, (v) => _then(v as _$_AuthStatusLoggedIn));

  @override
  _$_AuthStatusLoggedIn get _value => super._value as _$_AuthStatusLoggedIn;

  @override
  $Res call({
    Object? userId = freezed,
  }) {
    return _then(_$_AuthStatusLoggedIn(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AuthStatusLoggedIn implements _AuthStatusLoggedIn {
  const _$_AuthStatusLoggedIn({required this.userId});

  @override
  final String userId;

  @override
  String toString() {
    return 'AuthStatus.loggedIn(userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthStatusLoggedIn &&
            const DeepCollectionEquality().equals(other.userId, userId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(userId));

  @JsonKey(ignore: true)
  @override
  _$$_AuthStatusLoggedInCopyWith<_$_AuthStatusLoggedIn> get copyWith =>
      __$$_AuthStatusLoggedInCopyWithImpl<_$_AuthStatusLoggedIn>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function(String userId) loggedIn,
  }) {
    return loggedIn(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function(String userId)? loggedIn,
  }) {
    return loggedIn?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function(String userId)? loggedIn,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthStatusLoggedOut value) loggedOut,
    required TResult Function(_AuthStatusLoggedIn value) loggedIn,
  }) {
    return loggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthStatusLoggedOut value)? loggedOut,
    TResult Function(_AuthStatusLoggedIn value)? loggedIn,
  }) {
    return loggedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthStatusLoggedOut value)? loggedOut,
    TResult Function(_AuthStatusLoggedIn value)? loggedIn,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(this);
    }
    return orElse();
  }
}

abstract class _AuthStatusLoggedIn implements AuthStatus {
  const factory _AuthStatusLoggedIn({required final String userId}) =
      _$_AuthStatusLoggedIn;

  String get userId;
  @JsonKey(ignore: true)
  _$$_AuthStatusLoggedInCopyWith<_$_AuthStatusLoggedIn> get copyWith =>
      throw _privateConstructorUsedError;
}
