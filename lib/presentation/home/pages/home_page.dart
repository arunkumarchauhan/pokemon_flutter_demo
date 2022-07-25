import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/utils/app_router.dart';
import 'package:pokemon/utils/colors.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "What pokemon are you looking for?",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    height: 65,
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 25, right: 20),
                            child: Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Search Pokemon",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // _buildSelectionRow(context: context),
                  _buildPokeOptionsGrid(context),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Watch",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 30),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                    thickness: 2,
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: -90,
            top: 30,
            child: Image.asset(
              "assets/images/pokeball.png",
              color: kWhite30Color,
              height: 300,
              width: 300,
            ),
          ),
          const Positioned(
              top: 50,
              left: 20,
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
    );
  }

  Padding _buildPokeOptionsGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.5),
        children: [
          _buildPokeOptionsWidget(
              context: context,
              fromGradientColor: Color.fromRGBO(255, 51, 51, 1),
              toGradientColor: Color.fromRGBO(204, 0, 0, 1),
              name: "Pokedox",
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.pokemon_list);
              }),
          _buildPokeOptionsWidget(
            context: context,
            fromGradientColor: Color.fromRGBO(204, 204, 0, 1),
            toGradientColor: Color.fromRGBO(102, 204, 0, 1),
            name: "Moves",
            onPressed: () {},
          ),
          _buildPokeOptionsWidget(
              context: context,
              fromGradientColor: Color.fromRGBO(102, 204, 0, 1),
              toGradientColor: Color.fromRGBO(0, 102, 0, 1),
              name: "Evolutions",
              onPressed: () {}),
          _buildPokeOptionsWidget(
            context: context,
            fromGradientColor: Color.fromRGBO(153, 204, 255, 1),
            toGradientColor: Color.fromRGBO(102, 0, 204, 1),
            name: "Locations",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPokeOptionsWidget(
      {required BuildContext context,
      required Color fromGradientColor,
      required Color toGradientColor,
      required Function onPressed,
      required String name}) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: SizedBox(
        height: 70,
        width: 150.w,
        child: Stack(
          children: [
            Container(
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomRight,
                  colors: [fromGradientColor, toGradientColor],
                ),
                color: Colors.red,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(
                name,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Positioned(
              right: -20,
              top: -20,
              child: Image.asset(
                "assets/images/pokeball.png",
                color: kWhite30Color,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
