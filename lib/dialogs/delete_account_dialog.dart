import 'package:flutter/material.dart';
import 'package:flutter_rx/dialogs/generic_dialog.dart';

Future<bool> showDeleteAccountDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete account',
    content:
        'Are you sure you want to delete your account? You cannot undo this operation!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete account': true,
    },
  ).then(
    // handle tapping outside or tapping back button
    (value) => value ?? false,
  );
}
