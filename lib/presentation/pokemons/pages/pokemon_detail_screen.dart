import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokemon/data/mapper/pokemon_mapper.dart';
import 'package:pokemon/datasource/dto/location_dto.dart';
import 'package:pokemon/domain/entity/pokemon_detail.dart';
import 'package:pokemon/presentation/pokemons/controller/pokemon_detail.dart';
import 'package:pokemon/presentation/pokemons/controller/pokemon_encounters.dart';
import 'package:pokemon/presentation/pokemons/controller/pokemon_list.dart';
import 'package:pokemon/presentation/pokemons/widgets/chip_widget.dart';
import 'package:pokemon/presentation/pokemons/widgets/tab_view_body_container.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/utils/extension.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:collection/collection.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class PokemonDetailScreen extends ConsumerStatefulWidget {
  PokemonDetailScreen({Key? key}) : super(key: key);

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen>
    with SingleTickerProviderStateMixin {
  late PanelController _panelController;
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabsName.length, vsync: this);
    _panelController = PanelController();
  }

  double panelHeightExtent = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.black38, Colors.greenAccent],
        ),
      ),
      child: Consumer(builder: (context, ref, child) {
        final state = ref.watch(kPokemonDetailStateProvider);
        return state.when(data: (data) {
          if (data.isLeft) {
            return Center(
              child: Text(
                data.left.message,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                ),
              ),
            );
          }
          final pokemon = data.right;
          return Scaffold(
            body: SlidingUpPanel(
              controller: _panelController,
              backdropOpacity: 1,
              color: Colors.transparent,
              renderPanelSheet: false,
              parallaxEnabled: false,
              minHeight: 100,
              maxHeight: 690.h,
              onPanelSlide: (value) {
                setState(() {
                  panelHeightExtent = value;
                });
              },
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0)),
              collapsed: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTabBar(),
                    GestureDetector(
                      onTap: () {
                        _panelController.animatePanelToPosition(1);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Scroll Down  ",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const Icon(
                            Icons.keyboard_double_arrow_down_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              panel: _buildStatsInfoColumn(context, pokemon),
              body: GestureDetector(
                onTap: () {
                  _panelController.animatePanelToPosition(0);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Colors.black38, Colors.greenAccent])),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                panelHeightExtent < 0.5
                                    ? "#00${pokemon.id}"
                                    : "${pokemon.name}",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              IconButton(
                                  padding: const EdgeInsets.only(right: 35),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    size: 40,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 1 - panelHeightExtent,
                          child: Transform.translate(
                            offset: Offset(0, -200 * (panelHeightExtent)),
                            child: Transform.scale(
                              scale: 1 - panelHeightExtent,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 300 * (1 - panelHeightExtent),
                                    child: Transform.scale(
                                      scale: 1,
                                      child: Image.network(
                                        "${pokemon.sprites?.other?.home?.frontDefault}",
                                        fit: BoxFit.fitHeight,
                                        errorBuilder: (_, error, trace) {
                                          return const Text(
                                            "Image Not Found",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${pokemon.name?.capitalizeFirst()}",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: Text(
                                      "Seed Pokemon",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return ChipWidget(
                                            text:
                                                "${pokemon.types?[index].type?.name}",
                                            textColor: index % 2 == 0
                                                ? Colors.green
                                                : Colors.blue,
                                            borderColor: index % 2 == 0
                                                ? Colors.green
                                                : Colors.blue);
                                      },
                                      separatorBuilder: (ctx, index) {
                                        return const SizedBox(
                                          width: 20,
                                        );
                                      },
                                      itemCount: pokemon.types?.length ?? 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }, error: (error, stackTrace) {
          return Center(
            child: Text(
              "$error",
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w200,
                fontSize: 16,
              ),
            ),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
      }),
    );
  }

  Widget _buildStatsInfoColumn(
      BuildContext context, PokemonDetail pokemonDetail) {
    return Container(
      padding: const EdgeInsets.only(top: 200),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                    top: -300,
                    child: Transform.scale(
                      scale: 1 * (panelHeightExtent * 0.8),
                      child: Image.network(
                        "${pokemonDetail.sprites?.other?.home?.frontDefault}",
                        errorBuilder: (_, error, trace) {
                          return const Text(
                            "Image Not Found",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                    )),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
            _buildTabBar(),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                TabViewBodyContainer(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: _buildAboutBody(pokemonDetail: pokemonDetail),
                )),
                _buildStatTabViewBody(pokemonDetail: pokemonDetail),
                _buildMovesTabBody(context, pokemonDetail: pokemonDetail),
                _buildAbilitiesTabBody(context, pokemonDetail: pokemonDetail),
                _buildEncountersTabBody(context),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEncountersTabBody(BuildContext context) {
    final _data = ref.watch(kGetPokemonEncounterLocationFutureProvider(1));
    return SingleChildScrollView(
      child: TabViewBodyContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                "Encounter Locations",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
            _data.when(data: (data) {
              return data.fold((left) {
                return Text(
                  left.message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                );
              }, (right) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white12,
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        final location = right[index];
                        return Text(
                          "${location.locationArea!.name}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white70),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider(
                          height: 30,
                          thickness: 2,
                          color: Colors.black,
                        );
                      },
                      itemCount: right.length),
                );
              });
            }, error: (error, stackTrace) {
              return Text(
                "$error",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildAbilitiesTabBody(BuildContext context,
      {required PokemonDetail pokemonDetail}) {
    return SingleChildScrollView(
      child: TabViewBodyContainer(
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Ability",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  Text(
                    "Hidden ?",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              color: Colors.white12,
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final ability = pokemonDetail.abilities![index];
                    return _buildAbilityRow(
                        text: "${ability.ability?.name}",
                        isAbilityHidden: ability.isHidden ?? true);
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      height: 40,
                      thickness: 0,
                      color: Colors.black,
                    );
                  },
                  itemCount: pokemonDetail.abilities!.length),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAbilityRow(
      {required String text, required bool isAbilityHidden}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$text",
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
        Text(
          "$isAbilityHidden",
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        )
      ],
    );
  }

  Widget _buildMovesTabBody(BuildContext context,
      {required PokemonDetail pokemonDetail}) {
    return SingleChildScrollView(
      child: TabViewBodyContainer(
        child: DataTable(
          columns: _buildDataTableColumnTitle(),
          rows: _buildMovesDataRow(pokemonDetail: pokemonDetail),
        ),
      ),
    );
  }

  List<DataRow> _buildMovesDataRow({required PokemonDetail pokemonDetail}) {
    List<DataRow> dataRows = [];
    for (final move in pokemonDetail.moves!) {
      dataRows.add(DataRow(
        color: MaterialStateProperty.all<Color>(Colors.white12),
        cells: <DataCell>[
          DataCell(Text(
            "${move.move!.name}",
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          )),
          DataCell(
            Text(
              "${move.versionGroupDetails!.first.levelLearnedAt}",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          DataCell(
            Text(
              "${move.versionGroupDetails!.first.moveLearnMethod!.name}",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ));
    }
    return dataRows;
  }

  List<DataColumn> _buildDataTableColumnTitle() {
    return const <DataColumn>[
      DataColumn(
        label: Text(
          "Move",
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          "Level",
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          "Method",
          style: TextStyle(color: Colors.white),
        ),
      )
    ];
  }

  TabViewBodyContainer _buildStatTabViewBody(
      {required PokemonDetail pokemonDetail}) {
    return TabViewBodyContainer(
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            if (index == pokemonDetail.stats!.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  lorem(paragraphs: 2, words: 200),
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ),
              );
            }
            return _buildStatIndicatorRow(
                name: pokemonDetail.stats![index].stat!.name!.toUpperCase(),
                strength: pokemonDetail.stats![index].baseStat ?? 0);
          },
          separatorBuilder: (ctx, index) {
            return const Divider(
              height: 10,
              thickness: 0,
            );
          },
          itemCount: pokemonDetail.stats!.length + 1),
    );
  }

  Widget _buildStatIndicatorRow({required String name, required int strength}) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            "$strength",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        _buildProgressIndicator(percentage: strength / 100),
      ],
    );
  }

  Widget _buildProgressIndicator({double percentage = 0.45}) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: LinearPercentIndicator(
          padding: EdgeInsets.zero,
          barRadius: const Radius.circular(10),
          percent: percentage > 1 ? 1 : percentage,
          animationDuration: 10000,
          progressColor: percentage > 0.5 ? Colors.green : Colors.white70,
          fillColor: Colors.white12,
          backgroundColor: Colors.white12,
          lineHeight: 9,
        ),
      ),
    );
  }

  Widget _buildAboutBody({required PokemonDetail pokemonDetail}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            lorem(paragraphs: 1, words: 70),
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  _buildAboutCardInfoColumn(
                      iconData: Icons.note_alt_outlined,
                      title:
                          "${pokemonDetail.weight?.toStringAsFixed(1) ?? "00"} kg",
                      subTitle: 'Weight'),
                  const SizedBox(
                    width: 20,
                  ),
                  _buildAboutCardInfoColumn(
                      iconData: Icons.note_alt_outlined,
                      title:
                          "${pokemonDetail.height?.toStringAsFixed(1) ?? "00"} m",
                      subTitle: 'Height'),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildAboutCardInfoColumn(
      {required String title,
      required String subTitle,
      required IconData iconData}) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: Colors.green,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subTitle,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Container _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.greenAccent.shade100.withOpacity(0.03),
            Colors.black38
          ])),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: TabBar(
                onTap: (index) {
                  setState(() {});
                },
                indicatorColor: Colors.white,
                isScrollable: true,
                controller: _tabController,
                tabs: tabsName
                    .mapIndexed((index, e) => Tab(
                          child: Text(
                            e,
                            style: TextStyle(
                                color: index == _tabController.index
                                    ? Colors.white
                                    : Colors.white30),
                          ),
                        ))
                    .toList()),
          )
        ],
      ),
    );
  }
}
