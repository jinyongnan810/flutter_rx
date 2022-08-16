import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_rx/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then(
    // handle tapping outside or tapping back button
    (value) => value ?? false,
  );
}
