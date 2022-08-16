import 'package:flutter/material.dart';
import 'package:flutter_rx/models/contact.dart';

typedef LogoutCallback = VoidCallback;

typedef DeleteAccountCallback = VoidCallback;

typedef GoBackCallback = VoidCallback;

typedef LoginFunction = void Function({
  required String email,
  required String password,
});

typedef RegisterFunction = void Function({
  required String email,
  required String password,
});

typedef CreateContactCallback = void Function({
  required String firstName,
  required String lastName,
  required String phone,
});

typedef DeleteContactCallback = void Function({
  required Contact contact,
});
