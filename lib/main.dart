import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/presentation/home/pages/home_page.dart';
import 'package:pokemon/presentation/pokemons/pages/pokemon_detail_screen.dart';
import 'package:pokemon/presentation/pokemons/pages/pokemons_screen.dart';
import 'package:pokemon/utils/app_router.dart';
import 'package:pokemon/utils/build_theme.dart';
import 'package:pokemon/utils/colors.dart';
import 'package:pokemon/utils/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MaterialApp(
            title: 'Pokemon',
            debugShowCheckedModeBanner: false,
            theme: buildThemeData(),
            initialRoute: AppRouter.home,
            routes: {
              AppRouter.home: (_) => const MyHomePage(),
              AppRouter.pokemon_list: (_) => const PokemonListScreen(),
              AppRouter.pokemon_detail: (_) => PokemonDetailScreen(),
            },
          );
        });
  }
}
