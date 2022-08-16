import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_status.freezed.dart';

@freezed
abstract class AuthStatus with _$AuthStatus {
  const factory AuthStatus.loggedOut() = _AuthStatusLoggedOut;
  const factory AuthStatus.loggedIn({required String userId}) =
      _AuthStatusLoggedIn;
}
