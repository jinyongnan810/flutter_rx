// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthCommand {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) signUp,
    required TResult Function(String email, String password) logIn,
    required TResult Function() logOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String email, String password)? signUp,
    TResult Function(String email, String password)? logIn,
    TResult Function()? logOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? signUp,
    TResult Function(String email, String password)? logIn,
    TResult Function()? logOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCommandSignUp value) signUp,
    required TResult Function(_AuthCommandLogIn value) logIn,
    required TResult Function(_AuthCommandLogOut value) logOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthCommandSignUp value)? signUp,
    TResult Function(_AuthCommandLogIn value)? logIn,
    TResult Function(_AuthCommandLogOut value)? logOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCommandSignUp value)? signUp,
    TResult Function(_AuthCommandLogIn value)? logIn,
    TResult Function(_AuthCommandLogOut value)? logOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthCommandCopyWith<$Res> {
  factory $AuthCommandCopyWith(
          AuthCommand value, $Res Function(AuthCommand) then) =
      _$AuthCommandCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthCommandCopyWithImpl<$Res> implements $AuthCommandCopyWith<$Res> {
  _$AuthCommandCopyWithImpl(this._value, this._then);

  final AuthCommand _value;
  // ignore: unused_field
  final $Res Function(AuthCommand) _then;
}

/// @nodoc
abstract class _$$_AuthCommandSignUpCopyWith<$Res> {
  factory _$$_AuthCommandSignUpCopyWith(_$_AuthCommandSignUp value,
          $Res Function(_$_AuthCommandSignUp) then) =
      __$$_AuthCommandSignUpCopyWithImpl<$Res>;
  $Res call({String email, String password});
}

/// @nodoc
class __$$_AuthCommandSignUpCopyWithImpl<$Res>
    extends _$AuthCommandCopyWithImpl<$Res>
    implements _$$_AuthCommandSignUpCopyWith<$Res> {
  __$$_AuthCommandSignUpCopyWithImpl(
      _$_AuthCommandSignUp _value, $Res Function(_$_AuthCommandSignUp) _then)
      : super(_value, (v) => _then(v as _$_AuthCommandSignUp));

  @override
  _$_AuthCommandSignUp get _value => super._value as _$_AuthCommandSignUp;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_$_AuthCommandSignUp(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AuthCommandSignUp implements _AuthCommandSignUp {
  const _$_AuthCommandSignUp({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthCommand.signUp(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthCommandSignUp &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$$_AuthCommandSignUpCopyWith<_$_AuthCommandSignUp> get copyWith =>
      __$$_AuthCommandSignUpCopyWithImpl<_$_AuthCommandSignUp>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) signUp,
    required TResult Function(String email, String password) logIn,
    required TResult Function() logOut,
  }) {
    return signUp(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String email, String password)? signUp,
    TResult Function(String email, String password)? logIn,
    TResult Function()? logOut,
  }) {
    return signUp?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? signUp,
    TResult Function(String email, String password)? logIn,
    TResult Function()? logOut,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCommandSignUp value) signUp,
    required TResult Function(_AuthCommandLogIn value) logIn,
    required TResult Function(_AuthCommandLogOut value) logOut,
  }) {
    return signUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthCommandSignUp value)? signUp,
    TResult Function(_AuthCommandLogIn value)? logIn,
    TResult Function(_AuthCommandLogOut value)? logOut,
  }) {
    return signUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCommandSignUp value)? signUp,
    TResult Function(_AuthCommandLogIn value)? logIn,
    TResult Function(_AuthCommandLogOut value)? logOut,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(this);
    }
    return orElse();
  }
}

abstract class _AuthCommandSignUp implements AuthCommand {
  const factory _AuthCommandSignUp(
      {required final String email,
      required final String password}) = _$_AuthCommandSignUp;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$_AuthCommandSignUpCopyWith<_$_AuthCommandSignUp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AuthCommandLogInCopyWith<$Res> {
  factory _$$_AuthCommandLogInCopyWith(
          _$_AuthCommandLogIn value, $Res Function(_$_AuthCommandLogIn) then) =
      __$$_AuthCommandLogInCopyWithImpl<$Res>;
  $Res call({String email, String password});
}

/// @nodoc
class __$$_AuthCommandLogInCopyWithImpl<$Res>
    extends _$AuthCommandCopyWithImpl<$Res>
    implements _$$_AuthCommandLogInCopyWith<$Res> {
  __$$_AuthCommandLogInCopyWithImpl(
      _$_AuthCommandLogIn _value, $Res Function(_$_AuthCommandLogIn) _then)
      : super(_value, (v) => _then(v as _$_AuthCommandLogIn));

  @override
  _$_AuthCommandLogIn get _value => super._value as _$_AuthCommandLogIn;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_$_AuthCommandLogIn(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AuthCommandLogIn implements _AuthCommandLogIn {
  const _$_AuthCommandLogIn({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthCommand.logIn(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthCommandLogIn &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$$_AuthCommandLogInCopyWith<_$_AuthCommandLogIn> get copyWith =>
      __$$_AuthCommandLogInCopyWithImpl<_$_AuthCommandLogIn>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) signUp,
    required TResult Function(String email, String password) logIn,
    required TResult Function() logOut,
  }) {
    return logIn(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String email, String password)? signUp,
    TResult Function(String email, String password)? logIn,
    TResult Function()? logOut,
  }) {
    return logIn?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? signUp,
    TResult Function(String email, String password)? logIn,
    TResult Function()? logOut,
    required TResult orElse(),
  }) {
    if (logIn != null) {
      return logIn(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCommandSignUp value) signUp,
    required TResult Function(_AuthCommandLogIn value) logIn,
    required TResult Function(_AuthCommandLogOut value) logOut,
  }) {
    return logIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthCommandSignUp value)? signUp,
    TResult Function(_AuthCommandLogIn value)? logIn,
    TResult Function(_AuthCommandLogOut value)? logOut,
  }) {
    return logIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCommandSignUp value)? signUp,
    TResult Function(_AuthCommandLogIn value)? logIn,
    TResult Function(_AuthCommandLogOut value)? logOut,
    required TResult orElse(),
  }) {
    if (logIn != null) {
      return logIn(this);
    }
    return orElse();
  }
}

abstract class _AuthCommandLogIn implements AuthCommand {
  const factory _AuthCommandLogIn(
      {required final String email,
      required final String password}) = _$_AuthCommandLogIn;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$_AuthCommandLogInCopyWith<_$_AuthCommandLogIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AuthCommandLogOutCopyWith<$Res> {
  factory _$$_AuthCommandLogOutCopyWith(_$_AuthCommandLogOut value,
          $Res Function(_$_AuthCommandLogOut) then) =
      __$$_AuthCommandLogOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AuthCommandLogOutCopyWithImpl<$Res>
    extends _$AuthCommandCopyWithImpl<$Res>
    implements _$$_AuthCommandLogOutCopyWith<$Res> {
  __$$_AuthCommandLogOutCopyWithImpl(
      _$_AuthCommandLogOut _value, $Res Function(_$_AuthCommandLogOut) _then)
      : super(_value, (v) => _then(v as _$_AuthCommandLogOut));

  @override
  _$_AuthCommandLogOut get _value => super._value as _$_AuthCommandLogOut;
}

/// @nodoc

class _$_AuthCommandLogOut implements _AuthCommandLogOut {
  const _$_AuthCommandLogOut();

  @override
  String toString() {
    return 'AuthCommand.logOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AuthCommandLogOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String password) signUp,
    required TResult Function(String email, String password) logIn,
    required TResult Function() logOut,
  }) {
    return logOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String email, String password)? signUp,
    TResult Function(String email, String password)? logIn,
    TResult Function()? logOut,
  }) {
    return logOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String password)? signUp,
    TResult Function(String email, String password)? logIn,
    TResult Function()? logOut,
    required TResult orElse(),
  }) {
    if (logOut != null) {
      return logOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCommandSignUp value) signUp,
    required TResult Function(_AuthCommandLogIn value) logIn,
    required TResult Function(_AuthCommandLogOut value) logOut,
  }) {
    return logOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthCommandSignUp value)? signUp,
    TResult Function(_AuthCommandLogIn value)? logIn,
    TResult Function(_AuthCommandLogOut value)? logOut,
  }) {
    return logOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCommandSignUp value)? signUp,
    TResult Function(_AuthCommandLogIn value)? logIn,
    TResult Function(_AuthCommandLogOut value)? logOut,
    required TResult orElse(),
  }) {
    if (logOut != null) {
      return logOut(this);
    }
    return orElse();
  }
}

abstract class _AuthCommandLogOut implements AuthCommand {
  const factory _AuthCommandLogOut() = _$_AuthCommandLogOut;
}
