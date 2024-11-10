import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poki_mann/data/models/pokemon.dart';
import 'package:poki_mann/repos/pokemon_repo.dart';

final pokemonFutureProvider = FutureProvider<List<Pokemon>>((ref) async {
  return await ref.watch(pokemonRepoProvider).getAllPokemons();
});
