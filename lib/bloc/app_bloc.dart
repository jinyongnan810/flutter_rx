import 'dart:async';

import 'package:flutter_rx/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_rx/bloc/auth_bloc/auth_error.dart';
import 'package:flutter_rx/bloc/contacts_bloc.dart';
import 'package:flutter_rx/bloc/views_bloc/current_view.dart';
import 'package:flutter_rx/bloc/views_bloc/views_bloc.dart';
import 'package:flutter_rx/models/auth_command.dart';
import 'package:flutter_rx/models/auth_status.dart';
import 'package:flutter_rx/models/contact.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc {
  final AuthBloc _authBloc;
  final ViewsBloc _viewsBloc;
  final ContactsBloc _contactsBloc;

  final Stream<CurrentView> currentView;
  final Stream<bool> isLoading;
  final Stream<AuthError?> authError;
  final StreamSubscription<AuthStatus?> _userIdChanges;

  void dispose() {
    _authBloc.dispose();
    _viewsBloc.dispose();
    _contactsBloc.dispose();
    _userIdChanges.cancel();
  }

  // public functions
  // contacts
  void deleteContact({required Contact contact}) {
    _contactsBloc.deleteContact.add(contact);
  }

  void createContact({
    required String firstName,
    required String lastName,
    required String phone,
  }) {
    _contactsBloc.createContact.add(Contact.withoutId(
        firstName: firstName, lastName: lastName, phone: phone));
  }

  Stream<Iterable<Contact>> get contacts => _contactsBloc.contacts;

  // auth
  void logIn({
    required String email,
    required String password,
  }) {
    _authBloc.authActions
        .add(AuthCommand.logIn(email: email, password: password));
  }

  void signUp({
    required String email,
    required String password,
  }) {
    _authBloc.authActions
        .add(AuthCommand.signUp(email: email, password: password));
  }

  void logOut() {
    _authBloc.authActions.add(const AuthCommand.logOut());
  }

  void deleteAccount() {
    // TODO: not implemented yet
  }

  // views
  void goToContactListView() {
    _viewsBloc.goToView.add(CurrentView.contactList);
  }

  void goToCreateContactView() {
    _viewsBloc.goToView.add(CurrentView.createContact);
  }

  void goToSignUpView() {
    _viewsBloc.goToView.add(CurrentView.register);
  }

  void goToLogInView() {
    _viewsBloc.goToView.add(CurrentView.login);
  }

  // end of public functions

  AppBloc._({
    required AuthBloc authBloc,
    required ViewsBloc viewsBloc,
    required ContactsBloc contactsBloc,
    required this.currentView,
    required this.isLoading,
    required this.authError,
    required StreamSubscription<AuthStatus?> userIdChanges,
  })  : _authBloc = authBloc,
        _viewsBloc = viewsBloc,
        _contactsBloc = contactsBloc,
        _userIdChanges = userIdChanges;
  factory AppBloc() {
    final authBloc = AuthBloc();
    final viewsBloc = ViewsBloc();
    final contactsBloc = ContactsBloc();

    // pass userId changes from auth to contacts bloc
    final userIdChanges = authBloc.status.listen((status) {
      status.when(loggedOut: () {
        contactsBloc.userId.add(null);
      }, loggedIn: (userId) {
        contactsBloc.userId.add(userId);
      });
    });

    // calculate current view
    final currentViewByAuthStatus = authBloc.status.map<CurrentView>((status) {
      return status.when(
          loggedOut: () => CurrentView.login,
          loggedIn: (_) => CurrentView.contactList);
    });
    final currentView =
        Rx.merge<CurrentView>([currentViewByAuthStatus, viewsBloc.currentView]);

    // is loading(currently only auth uses isLoading, but it can be more)
    final isLoading = Rx.merge([authBloc.isLoading]);

    // error
    final authError = authBloc.error;

    return AppBloc._(
        authBloc: authBloc,
        viewsBloc: viewsBloc,
        contactsBloc: contactsBloc,
        currentView: currentView,
        // using asBroadcastStream to enable multiple subscriptions
        isLoading: isLoading.asBroadcastStream(),
        authError: authError.asBroadcastStream(),
        userIdChanges: userIdChanges);
  }
}
