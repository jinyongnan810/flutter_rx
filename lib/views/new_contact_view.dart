import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rx/type_definition.dart';
import 'package:flutter_rx/helpers/is_debugging.dart';

class NewContactView extends HookWidget {
  final CreateContactCallback createContact;
  final GoBackCallback goBack;
  const NewContactView({
    Key? key,
    required this.createContact,
    required this.goBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController(
      text: 'Yuunan'.isDebugging,
    );
    final lastNameController = useTextEditingController(
      text: 'Kin'.isDebugging,
    );
    final phoneController = useTextEditingController(
      text: '012-3456-7890'.isDebugging,
    );
    return Scaffold(
      appBar: AppBar(
          title: const Text('New Contact'),
          leading: IconButton(
              onPressed: () {
                goBack.call();
              },
              icon: const Icon(Icons.close))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  label: Text('First Name'),
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(label: Text('Last Name')),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(label: Text('Phone Number')),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              TextButton(
                  onPressed: () {
                    createContact(firstNameController.text,
                        lastNameController.text, phoneController.text);
                    goBack.call();
                  },
                  child: const Text('Create Contact'))
            ],
          ),
        ),
      ),
    );
  }
}
