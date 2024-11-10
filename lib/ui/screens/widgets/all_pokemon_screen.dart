import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poki_mann/data/models/pokemon.dart';
import 'package:poki_mann/providers/pokemon_future_provider.dart';
import 'package:poki_mann/providers/theme_provider.dart';
import 'package:poki_mann/repos/pokemon_repo.dart';
import 'package:poki_mann/ui/screens/widgets/fav_pokemon_screen.dart';
import 'package:poki_mann/ui/screens/widgets/pokemon_detail_screen.dart';
import 'package:poki_mann/utils/extensions/buildcontext_extension.dart';
import 'package:poki_mann/utils/helpers/helpers.dart';

class AllPokemonScreen extends ConsumerWidget {
  const AllPokemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> pokemonList =
        ref.watch(pokemonFutureProvider);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("PokeDex",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25)),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.go(const FavouritePokemonScreen());
                    },
                    icon: const Icon(Icons.favorite_border_sharp),
                    color: Colors.red,
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                    icon: const Icon(Icons.lightbulb_outline_sharp),
                    color: Colors.yellow,
                  )
                ],
              ),
            ],
          ),
          backgroundColor: Color(0xFF376D6E),
        ),
        body: pokemonList.when(data: (data) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.go(PokemonDetailScreen(pokemon: data[index]));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Helpers.getPokemonCardColour(
                        pokemonType: data[index].typeofpokemon!.first),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 15,
                            left: 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].name!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(125),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      data[index]
                                          .typeofpokemon!
                                          .first
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Positioned(
                          bottom: -5,
                          right: -10,
                          child: Image.asset(
                            'images/pokeball.png',
                            height: 140,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Hero(
                            tag: data[index].id!,
                            child: CachedNetworkImage(
                              imageUrl: data[index].imageurl!,
                              height: 140,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }, error: (error, stk) {
          return Center(child: (Text(error.toString())));
        }, loading: () {
          return CircularProgressIndicator();
        }));
  }
}
