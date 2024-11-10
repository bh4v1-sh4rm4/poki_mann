import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poki_mann/data/models/pokemon.dart';
import 'package:poki_mann/repos/hive_repo.dart';
import 'package:poki_mann/ui/screens/widgets/rotating_image_widget.dart';
import 'package:poki_mann/ui/screens/widgets/shake_animation_widget.dart';
import 'package:poki_mann/utils/extensions/buildcontext_extension.dart';
import 'package:poki_mann/utils/helpers/helpers.dart';

class PokemonDetailScreen extends ConsumerStatefulWidget {
  const PokemonDetailScreen({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  ConsumerState<PokemonDetailScreen> createState() =>
      _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.getPokemonCardColour(
          pokemonType: widget.pokemon.typeofpokemon!.first.toString()),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.pokemon.name!),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(hiveRepoProvider).addPokemonToHive(widget.pokemon);
              },
              icon: const Icon(Icons.favorite_border_rounded))
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: context.getWidth(percentage: 0.5) - 125,
              child: RotatingImageWidget()),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20)),
                height: context.getHeight(percentage: 0.5) + 10,
                width: context.getWidth(),
                child: Column(children: [
                  Text(
                    "${widget.pokemon.xdescription}",
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PokemonDetailRow(
                          title: "Name",
                          data: widget.pokemon.name!,
                        ),
                        PokemonDetailRow(
                          title: "Type",
                          data: widget.pokemon.typeofpokemon!.join(', '),
                        ),
                        PokemonDetailRow(
                          title: "Height",
                          data: widget.pokemon.height!,
                        ),
                        PokemonDetailRow(
                          title: "weight",
                          data: widget.pokemon.weight!,
                        ),
                        PokemonDetailRow(
                          title: "Speed",
                          data: widget.pokemon.speed!.toString(),
                        ),
                        PokemonDetailRow(
                          title: "Attack",
                          data: widget.pokemon.attack!.toString(),
                        ),
                        PokemonDetailRow(
                          title: "Defense",
                          data: widget.pokemon.defense!.toString(),
                        ),
                        PokemonDetailRow(
                          title: "Weakness",
                          data: widget.pokemon.weaknesses!.join(', '),
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
          Positioned(
            top: 25,
            left: context.getWidth(percentage: 0.5) - 150,
            child: Hero(
              tag: widget.pokemon.id!,
              child: ShakeWidget(
                child: CachedNetworkImage(
                  imageUrl: widget.pokemon.imageurl!,
                  width: 300,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonDetailRow extends StatelessWidget {
  const PokemonDetailRow({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Expanded(
            child: Text(
              data,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
