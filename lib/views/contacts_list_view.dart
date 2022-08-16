import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rx/async_snapshot_builder.dart';
import 'package:flutter_rx/dialogs/delete_contact_dialog.dart';
import 'package:flutter_rx/models/contact.dart';
import 'package:flutter_rx/type_definition.dart';
import 'package:flutter_rx/helpers/is_debugging.dart';
import 'package:flutter_rx/views/main_popup_button.dart';

class ContactsListView extends StatelessWidget {
  final Stream<Iterable<Contact>> contacts;
  final DeleteContactCallback deleteContact;
  final LogoutCallback logout;
  final DeleteAccountCallback deleteAccount;
  final VoidCallback goToCreateContactView;
  const ContactsListView(
      {Key? key,
      required this.contacts,
      required this.deleteContact,
      required this.logout,
      required this.deleteAccount,
      required this.goToCreateContactView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          MainPopupButton(logout: logout, deleteAccount: deleteAccount)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToCreateContactView,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AsyncSnapshotBuilder<Iterable<Contact>>(
          stream: contacts,
          onWaiting: (
            _,
            __,
          ) =>
              const Center(
            child: CircularProgressIndicator(),
          ),
          onNone: (
            _,
            __,
          ) =>
              const Center(
            child: CircularProgressIndicator(),
          ),
          onActive: (
            _,
            data,
          ) {
            final contacts = data ?? [];
            return ListView.builder(
              itemBuilder: ((context, index) => ContactListTile(
                  contact: contacts.elementAt(index),
                  deleteContact: deleteContact)),
              itemCount: contacts.length,
            );
          },
        ),
      ),
    );
  }
}

class ContactListTile extends StatelessWidget {
  final Contact contact;
  final DeleteContactCallback deleteContact;
  const ContactListTile(
      {Key? key, required this.contact, required this.deleteContact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullName = '${contact.firstName} ${contact.lastName}';
    return ListTile(
      title: Text(fullName),
      subtitle: Text(contact.phone),
      trailing: IconButton(
        onPressed: () async {
          final res = await showDeleteContactDialog(context);
          if (res) {
            deleteContact.call(contact);
          }
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
