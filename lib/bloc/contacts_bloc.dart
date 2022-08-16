import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rx/models/contact.dart';
import 'package:rxdart/rxdart.dart';

typedef _Snapshots = QuerySnapshot<Map<String, dynamic>>;
typedef _Document = DocumentReference<Map<String, dynamic>>;

extension Unwrap<T> on Stream<T?> {
  Stream<T> unwrap() => switchMap((value) async* {
        if (value != null) {
          yield value;
        }
      });
}

class ContactsBloc {
  final Sink<String?> userId;
  final Sink<Contact> createContact;
  final Sink<Contact> deleteContact;
  final Stream<Iterable<Contact>> contacts;
  final StreamSubscription<void> _createContactSubscription;
  final StreamSubscription<void> _deleteContactSubscription;

  void dispose() {
    userId.close();
    createContact.close();
    deleteContact.close();
    _createContactSubscription.cancel();
    _deleteContactSubscription.cancel();
  }

  ContactsBloc._({
    required this.userId,
    required this.createContact,
    required this.deleteContact,
    required this.contacts,
    required StreamSubscription<void> createContactSubscription,
    required StreamSubscription<void> deleteContactSubscription,
  })  : _createContactSubscription = createContactSubscription,
        _deleteContactSubscription = deleteContactSubscription;

  factory ContactsBloc() {
    final backend = FirebaseFirestore.instance;

    final userId = BehaviorSubject<String?>();

    // when userId changes, grab contacts
    final Stream<Iterable<Contact>> contacts =
        userId.switchMap<_Snapshots>((userId) {
      if (userId == null) return const Stream<_Snapshots>.empty();
      return backend.collection(userId).snapshots();
    }).map<Iterable<Contact>>((snapshots) sync* {
      for (final doc in snapshots.docs) {
        yield Contact.fromJson(doc.data(), id: doc.id);
      }
    });

    final createContact = BehaviorSubject<Contact>();
    final createContactSubscription = createContact.switchMap((contact) {
      return userId
          .take(1)
          .unwrap()
          .asyncMap((userId) => backend.collection(userId).add(contact.data));
    })
        // hot stream(observe)
        .listen((event) {});

    final deleteContact = BehaviorSubject<Contact>();
    final deleteContactSubscription = deleteContact.switchMap((contact) {
      return userId.take(1).unwrap().asyncMap(
          (userId) => backend.collection(userId).doc(contact.id).delete());
    })
        // hot stream(observe)
        .listen((event) {});

    return ContactsBloc._(
      userId: userId,
      createContact: createContact,
      deleteContact: deleteContact,
      contacts: contacts,
      createContactSubscription: createContactSubscription,
      deleteContactSubscription: deleteContactSubscription,
    );
  }
}
