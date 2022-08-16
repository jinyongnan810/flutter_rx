import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_command.freezed.dart';

@freezed
abstract class AuthCommand with _$AuthCommand {
  const factory AuthCommand.signUp(
      {required String email, required String password}) = _AuthCommandSignUp;
  const factory AuthCommand.logIn(
      {required String email, required String password}) = _AuthCommandLogIn;
}
