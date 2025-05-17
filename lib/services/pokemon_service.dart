import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/pokemon.dart';

class PokemonService {
  static const int maxPokemonId = 1010;

  static Future<Pokemon> getRandomPokemon() async {
    final id = Random().nextInt(maxPokemonId) + 1;
    return fetchPokemonById(id);
  }

  static Future<List<Pokemon>> getRandomPokemons({
    required List<int> exclude,
    required int count,
  }) async {
    final List<Pokemon> result = [];

    while (result.length < count) {
      final id = Random().nextInt(maxPokemonId) + 1;
      if (exclude.contains(id) || result.any((p) => p.id == id)) continue;
      final pokemon = await fetchPokemonById(id);
      result.add(pokemon);
    }

    return result;
  }

  static Future<Pokemon> fetchPokemonById(int id) async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'),
    );
    final data = json.decode(response.body);

    return Pokemon(
      id: data['id'],
      name: data['name'],
      imageUrl: data['sprites']['other']['official-artwork']['front_default'],
      stats:
          (data['stats'] as List)
              .map((s) => {'name': s['stat']['name'], 'value': s['base_stat']})
              .toList(),
      types:
          (data['types'] as List)
              .map((t) => t['type']['name'] as String)
              .toList(),
    );
  }
}
