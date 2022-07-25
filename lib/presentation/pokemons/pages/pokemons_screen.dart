import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/di/injection.dart';
import 'package:pokemon/presentation/pokemons/controller/pokemon_detail.dart';
import 'package:pokemon/presentation/pokemons/controller/pokemon_encounters.dart';
import 'package:pokemon/utils/app_router.dart';
import 'package:pokemon/utils/failure.dart';

class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({Key? key}) : super(key: key);

  @override
  PokemonListScreenState createState() => PokemonListScreenState();
}

class PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  PokemonListScreenState({Key? key}) : super();
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = ref.read(kPokemonListControllerProvider);
    provider.getPokemonList();
    _controller.addListener(() {
      var nextPageTrigger = 0.8 * _controller.position.maxScrollExtent;
      if (_controller.position.pixels > nextPageTrigger) {
        provider.getPokemonList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.black38, Colors.greenAccent])),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text(
              "Pokemons",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          body: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(kPokemonListControllerStateProvider);

              return state.when(
                  data: (data) {
                    if (data.isRight) {
                      final responseList = data.right;
                      return ListView.separated(
                        controller: _controller,
                        itemBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          final item = responseList[index];
                          return ListTile(
                            onTap: () {
                              List<String> arr = item.url!.split('/');
                              int id = int.tryParse(arr[arr.length - 2]) ?? 0;
                              ref
                                  .read(kPokemonDetailControllerProvider)
                                  .getPokemonDetail(id: id);
                              Navigator.pushNamed(
                                  context, AppRouter.pokemon_detail,
                                  arguments: {"id": id});
                            },
                            title: Text(
                              "${item.name}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          );
                        },
                        itemCount: responseList.length,
                      );
                    }
                    return const Center(
                      child: Text("No Data"),
                    );
                  },
                  error: (obj, stack) {
                    String message = "";
                    if (obj is Failure) {
                      message = obj.message;
                    } else {
                      message = "Exception";
                    }
                    return Center(
                      child: Text(message),
                    );
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ));
            },
          )),
    );
  }
}
