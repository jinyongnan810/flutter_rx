import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rx/type_definition.dart';
import 'package:flutter_rx/helpers/is_debugging.dart';

class LoginView extends HookWidget {
  final VoidCallback goToSignUp;
  final LoginFunction login;
  const LoginView({
    Key? key,
    required this.goToSignUp,
    required this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'yuunan.kin@gmail.com'.isDebugging,
    );
    final passwordController = useTextEditingController(
      text: 'kinyuunan'.isDebugging,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(label: Text('Password')),
              keyboardType: TextInputType.name,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            TextButton(
                onPressed: () {
                  login(
                      email: emailController.text,
                      password: passwordController.text);
                },
                child: const Text('Log in')),
            TextButton(
                onPressed: () {
                  goToSignUp.call();
                },
                child: const Text('Sign up instead')),
          ],
        )),
      ),
    );
  }
}
