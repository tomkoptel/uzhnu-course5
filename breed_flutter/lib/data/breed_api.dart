import 'dart:convert';

import 'package:breed_flutter/domain/breed.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BreedApi {
  Future<List<Breed>> fetchBreeds() async {
    final Uri url = Uri.parse('https://dog.ceo/api/breeds/list/all');
    final Response response = await http.get(url);
    final Map<String, dynamic> body = jsonDecode(response.body);
    final Map<String, dynamic> message = body['message'];

    if (response.statusCode == 200) {
      final List<Breed> breeds = message.keys.map((breedName) {
        final List<dynamic> rawRaces = message[breedName];
        final List<String> races =
            rawRaces.map((race) => race.toString()).toList();
        return Breed.make(name: breedName, races: races);
      }).toList();
      return breeds;
    } else {
      throw Exception('Failed to load breed items');
    }
  }
}
