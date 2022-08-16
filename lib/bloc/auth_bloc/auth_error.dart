import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

abstract class AuthError {
  final String title;
  final String text;

  const AuthError({
    required this.title,
    required this.text,
  });

  factory AuthError.from(FirebaseAuthException exception) {
    final code = exception.code.toLowerCase().trim();
    return authErrorMapping[code] ?? const AuthErrorUnknown();
  }
}

class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
            title: 'Authentication Error',
            text: 'Unknown Authentication Error ');
}

// auth/no-current-user

class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          title: 'No current user!',
          text: 'No current user with this information was found',
        );
}

// auth/requires-recent-login

class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          title: 'Requires recent login',
          text:
              'You need to log out and log back in again in order to perform this operation',
        );
}

// auth/operation-not-allowed

class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          title: 'Operation not allowed',
          text: 'You cannot register using this method at this moment!',
        );
}

// auth/user-not-found

class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          title: 'User not found',
          text: 'The given user was not found on the server!',
        );
}

// auth/weak-password

class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          title: 'Weak password',
          text:
              'Please choose a stronger password consisting of more characters!',
        );
}

// auth/invalid-email

class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          title: 'Invalid email',
          text: 'Please double check your email and try again!',
        );
}

// auth/email-already-in-use

class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          title: 'Email already in use',
          text: 'Please choose another email to register with!',
        );
}

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
};
