import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poki_mann/providers/theme_provider.dart';
import 'package:poki_mann/repos/hive_repo.dart';
import 'package:poki_mann/theme/styles.dart';
import 'package:poki_mann/ui/screens/widgets/all_pokemon_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveRepo().registerAdapter();
  runApp(const ProviderScope(child: PokedexReverpod()));
}

class PokedexReverpod extends ConsumerWidget {
  const PokedexReverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    return MaterialApp(
      theme: Styles.themeData(isDarkTheme: isDarkTheme),
      home: AllPokemonScreen(),
    );
  }
}
