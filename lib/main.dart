import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rx/bloc/app_bloc.dart';
import 'package:flutter_rx/bloc/auth_bloc/auth_error.dart';
import 'package:flutter_rx/bloc/views_bloc/current_view.dart';
import 'package:flutter_rx/dialogs/auth_error_dialog.dart';
import 'package:flutter_rx/loading/loading_screen.dart';
import 'package:flutter_rx/views/contacts_list_view.dart';
import 'package:flutter_rx/views/login_view.dart';
import 'package:flutter_rx/views/new_contact_view.dart';
import 'package:flutter_rx/views/register_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapter 13 Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppBloc appBloc;
  StreamSubscription<AuthError?>? _authErrorSubscription;
  StreamSubscription<bool>? _isLoadingSubscription;
  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
    handleAuthErrors();
    handleIsLoading();
  }

  @override
  void dispose() {
    _authErrorSubscription?.cancel();
    _isLoadingSubscription?.cancel();
    appBloc.dispose();
    super.dispose();
  }

  void handleAuthErrors() async {
    await _authErrorSubscription?.cancel();
    _authErrorSubscription = appBloc.authError.listen((error) {
      if (error == null) return;
      showAuthErrorDialog(context: context, error: error);
    });
  }

  void handleIsLoading() async {
    await _isLoadingSubscription?.cancel();
    _isLoadingSubscription = appBloc.isLoading.listen((isLoading) {
      print(isLoading);
      if (isLoading) {
        LoadingScreen.instance().show(context: context, text: 'Loading...');
      } else {
        LoadingScreen.instance().hide();
      }
    });
  }

  Widget getHomePage(BuildContext context) {
    return StreamBuilder<CurrentView>(
      stream: appBloc.currentView,
      builder: (ctx, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            final viewType = snapshot.requireData;
            switch (viewType) {
              case CurrentView.login:
                return LoginView(
                    goToSignUp: appBloc.goToSignUpView, login: appBloc.logIn);
              case CurrentView.register:
                return RegisterView(
                    goToLogIn: appBloc.goToLogInView, signUp: appBloc.signUp);
              case CurrentView.contactList:
                return ContactsListView(
                    contacts: appBloc.contacts,
                    deleteContact: appBloc.deleteContact,
                    logout: appBloc.logOut,
                    deleteAccount: appBloc.deleteAccount,
                    goToCreateContactView: appBloc.goToCreateContactView);
              case CurrentView.createContact:
                return NewContactView(
                    createContact: appBloc.createContact,
                    goBack: appBloc.goToContactListView);
            }
          case ConnectionState.done:
            return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getHomePage(context);
  }
}
