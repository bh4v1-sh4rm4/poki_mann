import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poki_mann/data/models/pokemon.dart';

class HiveRepo {
  final pokemonBoxName = 'pokemonBox';
  void registerAdapter() {
    Hive.registerAdapter(PokemonAdapter());
  }

  Future addPokemonToHive(Pokemon pokemon) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      await pokemonBox.put(pokemon.id, pokemon);
    } else {
      throw Exception('Box is not opened');
    }
  }

  Future deletePokemonFromHive(String id) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      pokemonBox.delete(id);
    } else {
      throw Exception('Box is not opened');
    }
  }

  Future<List<Pokemon>> getAllPokemonFromHive() async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      return pokemonBox.values.toList();
    } else {
      throw Exception('Box is not opened.');
    }
  }
}

final hiveRepoProvider = Provider<HiveRepo>((ref) => HiveRepo());
