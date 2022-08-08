import 'dart:convert';
import 'dart:io';

import 'package:flutter_rx/models/animal.dart';
import 'package:flutter_rx/models/person.dart';
import 'package:flutter_rx/models/thing.dart';

typedef SearchTerm = String;

class Api {
  List<Animal>? animals;
  List<Person>? persons;

  Future<List<Thing>> search(SearchTerm term) async {
    final inCache = _searchInCache(term);
    if (inCache != null) {
      return inCache;
    }
    final personsRemote = await _getJson('http://127.0.0.1:5555/persons.json')
        .then((json) => json.map((e) => Person.fromJson(e)).toList());
    final animalsRemote = await _getJson('http://127.0.0.1:5555/animals.json')
        .then((json) => json.map((e) => Animal.fromJson(e)).toList());
    persons = personsRemote;
    animals = animalsRemote;
    return _searchInCache(term) ?? [];
  }

  List<Thing>? _searchInCache(SearchTerm term) {
    if (animals != null && persons != null) {
      List<Thing> res = [];
      for (final animal in animals!) {
        if (animal.type.name.trimmedContains(term) ||
            animal.name.trimmedContains(term)) {
          res.add(animal);
        }
      }
      for (final person in persons!) {
        if (person.age.toString().trimmedContains(term) ||
            person.name.trimmedContains(term)) {
          res.add(person);
        }
      }
      return res;
    }
    return null;
  }

  Future<List<dynamic>> _getJson(String url) => HttpClient()
      .getUrl(Uri.parse(url))
      .then((req) => req.close())
      .then((res) => res.transform(utf8.decoder).join())
      .then((jsonString) => json.decode(jsonString) as List<dynamic>);
}

extension TrimmedCaseInsensitiveContain on String {
  bool trimmedContains(String other) =>
      trim().toLowerCase().contains(other.trim().toLowerCase());
}
