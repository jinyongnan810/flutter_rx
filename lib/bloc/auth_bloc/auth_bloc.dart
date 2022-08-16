import 'package:flutter_rx/bloc/auth_bloc/auth_error.dart';
import 'package:flutter_rx/models/auth_command.dart';
import 'package:flutter_rx/models/auth_status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension Loading<E> on Stream<E> {
  Stream<E> setLoadingTo(
    bool isLoading, {
    required Sink<bool> sink,
  }) =>
      doOnEach((_) {
        sink.add(isLoading);
      });
}

class AuthBloc {
  final Stream<AuthStatus> status;
  final Stream<AuthError?> error;
  final Stream<bool> isLoading;

  final Sink<AuthCommand> authActions;

  void dispose() {
    authActions.close();
  }

  const AuthBloc._({
    required this.status,
    required this.error,
    required this.isLoading,
    required this.authActions,
  });

  factory AuthBloc() {
    final BehaviorSubject<bool> isLoading = BehaviorSubject<bool>();

    final Stream<String?> authStatusChanges =
        FirebaseAuth.instance.authStateChanges().map((user) => user?.uid);
    final status = authStatusChanges.map((userId) => userId != null
        ? AuthStatus.loggedIn(userId: userId)
        : const AuthStatus.loggedOut());

    final BehaviorSubject<AuthCommand> authActions =
        BehaviorSubject<AuthCommand>();

    final Stream<AuthError?> error = authActions
        .setLoadingTo(true, sink: isLoading)
        .asyncMap<AuthError?>((command) async {
      return command.when(signUp: ((email, password) async {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          return null;
        } on FirebaseAuthException catch (e) {
          return AuthError.from(e);
        } catch (_) {
          return const AuthErrorUnknown();
        }
      }), logIn: (email, password) async {
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          return null;
        } on FirebaseAuthException catch (e) {
          return AuthError.from(e);
        } catch (_) {
          return const AuthErrorUnknown();
        }
      }, logOut: () async {
        try {
          await FirebaseAuth.instance.signOut();
          return null;
        } on FirebaseAuthException catch (e) {
          return AuthError.from(e);
        } catch (_) {
          return const AuthErrorUnknown();
        }
      });
    }).setLoadingTo(false, sink: isLoading);

    return AuthBloc._(
        status: status,
        error: error,
        isLoading: isLoading,
        authActions: authActions);
  }
}
