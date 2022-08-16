import 'package:flutter/material.dart';
import 'package:flutter_rx/dialogs/delete_account_dialog.dart';
import 'package:flutter_rx/dialogs/logout_dialog.dart';
import 'package:flutter_rx/type_definition.dart';

enum MenuAction { logout, deleteAccount }

class MainPopupButton extends StatelessWidget {
  final LogoutCallback logout;
  final DeleteAccountCallback deleteAccount;
  const MainPopupButton(
      {Key? key, required this.logout, required this.deleteAccount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: MenuAction.logout,
            child: Text('Log Out'),
          ),
          const PopupMenuItem(
            value: MenuAction.deleteAccount,
            child: Text('Delete Account'),
          ),
        ];
      },
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final res = await showLogoutDialog(context);
            if (res) {
              logout.call();
            }
            break;
          case MenuAction.deleteAccount:
            final res = await showDeleteAccountDialog(context);
            if (res) {
              deleteAccount.call();
            }
            break;
        }
      },
    );
  }
}
