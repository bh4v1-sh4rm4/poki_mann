import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poki_mann/data/models/pokemon.dart';
import 'package:poki_mann/repos/hive_repo.dart';
import 'package:poki_mann/repos/pokemon_repo.dart';
import 'package:poki_mann/utils/extensions/buildcontext_extension.dart';
import 'package:poki_mann/utils/helpers/helpers.dart';

class FavouritePokemonScreen extends ConsumerStatefulWidget {
  const FavouritePokemonScreen({super.key});

  @override
  ConsumerState<FavouritePokemonScreen> createState() =>
      _FavouritePokemonScreenState();
}

class _FavouritePokemonScreenState
    extends ConsumerState<FavouritePokemonScreen> {
  List<Pokemon> favPokemonList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async {
      await ref
          .read(hiveRepoProvider)
          .getAllPokemonFromHive()
          .then((pokemonList) {
        log('fav poke list ${pokemonList.first.name}');
        setState(() {
          favPokemonList = pokemonList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Helpers.getPokemonCardColour(
                        pokemonType: favPokemonList[index]
                            .typeofpokemon!
                            .first
                            .toString())!
                    .withAlpha(200)),
            margin: EdgeInsets.all(10),
            width: context.getWidth(percentage: 1),
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(favPokemonList[index].imageurl!),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      favPokemonList[index].name!,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Text(
                      favPokemonList[index].typeofpokemon!.join(','),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    ref
                        .read(hiveRepoProvider)
                        .deletePokemonFromHive(favPokemonList[index].id!);
                    setState(() {
                      favPokemonList.removeAt(index);
                    });
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                )
              ],
            ),
          );
        },
        itemCount: favPokemonList.length,
      ),
    );
  }
}
