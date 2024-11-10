import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poki_mann/data/models/pokemon.dart';
import 'package:poki_mann/network/dio_client.dart';
import 'package:poki_mann/utils/helpers/constants.dart';

class PokemomRepo {
  final Ref ref;
  PokemomRepo(this.ref);

  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final response = await ref.read(dioProvider).get(POKEMON_API_URL);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final List<Pokemon> pokemonList = decodedJson
            .map<Pokemon>((pokemon) => Pokemon.fromJson(pokemon))
            .toList();
        return pokemonList;
      } else {
        throw Exception("NULL");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}

final pokemonRepoProvider = Provider<PokemomRepo>((ref) => PokemomRepo(ref));
