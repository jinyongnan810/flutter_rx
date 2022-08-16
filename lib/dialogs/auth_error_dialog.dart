import 'package:flutter/material.dart';
import 'package:flutter_rx/bloc/auth_bloc/auth_error.dart';
import 'package:flutter_rx/dialogs/generic_dialog.dart';

Future<void> showAuthErrorDialog(
        {required BuildContext context, required AuthError error}) =>
    showGenericDialog(
        context: context,
        title: error.title,
        content: error.text,
        optionsBuilder: () => {
              'OK': true,
            });
