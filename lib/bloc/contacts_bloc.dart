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
  final Sink<void> deleteAllContacts;
  final Stream<Iterable<Contact>> contacts;
  final StreamSubscription<void> _createContactSubscription;
  final StreamSubscription<void> _deleteContactSubscription;
  final StreamSubscription<void> _deleteAllContactsSubscription;

  void dispose() {
    userId.close();
    createContact.close();
    deleteContact.close();
    deleteAllContacts.close();
    _createContactSubscription.cancel();
    _deleteContactSubscription.cancel();
    _deleteAllContactsSubscription.cancel();
  }

  ContactsBloc._({
    required this.userId,
    required this.createContact,
    required this.deleteContact,
    required this.contacts,
    required this.deleteAllContacts,
    required StreamSubscription<void> createContactSubscription,
    required StreamSubscription<void> deleteContactSubscription,
    required StreamSubscription<void> deleteAllContactsSubscription,
  })  : _createContactSubscription = createContactSubscription,
        _deleteContactSubscription = deleteContactSubscription,
        _deleteAllContactsSubscription = deleteAllContactsSubscription;

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

    final deleteAllContacts = BehaviorSubject<void>();
    final deleteAllContactsSubscription = deleteAllContacts
        .switchMap((_) => userId.take(1).unwrap())
        .asyncMap((userId) => backend.collection(userId).get())
        .switchMap((collection) {
      final stream = Stream.fromFutures(
          collection.docs.map((doc) => doc.reference.delete()));
      return stream;
    })
        // hot stream(observe)
        .listen((event) {});

    return ContactsBloc._(
        userId: userId,
        createContact: createContact,
        deleteContact: deleteContact,
        deleteAllContacts: deleteAllContacts,
        contacts: contacts,
        createContactSubscription: createContactSubscription,
        deleteContactSubscription: deleteContactSubscription,
        deleteAllContactsSubscription: deleteAllContactsSubscription);
  }
}
