import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/dish.dart';
import '../../../../../utils/font_styles.dart';
import '../../../../global_widgets/circular_animation.dart';
import 'home_tab_controller.dart';
import 'widgets/categories_menu.dart';
import 'widgets/horizontal_dishes.dart';
import 'widgets/search_buttom.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<HomeTabController>(
      create: (_) {
        final controller = HomeTabController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFirstLayout();
        });
        return controller;
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Hello, David",
                        style: MyFontStyles.subtitleColor,
                      ),
                    ),
                    Text(
                      "Make your own food, stay at home",
                      style: MyFontStyles.title.copyWith(
                        fontSize: 22,
                      ),
                    ),
                    const SearchButton(),
                  ],
                ),
              ),
              const CategoriesMenu(),
              Builder(
                builder: (context) {
                  final List<Dish> popularMenu =
                      context.select<HomeTabController, List<Dish>>(
                    (_) => _.popularMenu,
                  );
                  return HorizontalDishes(
                    dishes: popularMenu,
                    title: "New Menu",
                    onViewAll: () {},
                  );
                },
              ),
              Builder(
                builder: (context) {
                  final List<Dish> popularMenu =
                      context.select<HomeTabController, List<Dish>>(
                    (_) => _.popularMenu,
                  );
                  final reversedList = List<Dish>.from(popularMenu.reversed);
                  return HorizontalDishes(
                    dishes: reversedList,
                    title: "Popular Dishes",
                    onViewAll: () {},
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularAnimation(
                      grados: 240,
                      begin: -280.0,
                      end: 120.0,
                      img:
                          'https://www.nicepng.com/png/detail/945-9450660_italian-pizzeria-just-for-kids-margarita-pizza-png.png',
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularAnimation(
                      grados: 200,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularAnimation(
                      grados: 240,
                      begin: -120.0,
                      end: 240.0,
                      img:
                          'https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbGlmZW9mcGl4MDAwMTMtaW1hZ2Utam9iNjE5LWt6dzVidGE4LnBuZw.png?s=Aprg1jjsnoUZuf5tyCS8Et4S-8qGqSqABSL-TdwJAdU',
                    ),
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  final List<Dish> popularMenu =
                      context.select<HomeTabController, List<Dish>>(
                    (_) => _.popularMenu,
                  );
                  return HorizontalDishes(
                    dishes: popularMenu,
                    title: "Most Sold",
                    onViewAll: () {},
                  );
                },
              ),
              Builder(
                builder: (context) {
                  final List<Dish> popularMenu =
                      context.select<HomeTabController, List<Dish>>(
                    (_) => _.popularMenu,
                  );
                  final reversedList = List<Dish>.from(popularMenu.reversed);
                  return HorizontalDishes(
                    dishes: reversedList,
                    title: "Popular Menu",
                    onViewAll: () {},
                  );
                },
                //   ),
                // ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
