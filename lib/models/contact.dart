import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
part 'contact.freezed.dart';

@freezed
class Contact with _$Contact {
  const factory Contact({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
  }) = _Contact;
  factory Contact.fromJson(Map<String, Object?> json, {required String id}) {
    final firstName = json['firstName'] as String;
    final lastName = json['lastName'] as String;
    final phone = json['phone'] as String;
    return Contact(
        id: id, firstName: firstName, lastName: lastName, phone: phone);
  }
  factory Contact.withoutId({
    required String firstName,
    required String lastName,
    required String phone,
  }) =>
      Contact(
          id: const Uuid().v4(),
          firstName: firstName,
          lastName: lastName,
          phone: phone);
}

extension Data on Contact {
  Map<String, dynamic> get data =>
      {'firstName': firstName, 'lastName': lastName, 'phone': phone};
}
