import 'package:flutter/widgets.dart';

import '../../../../../data/models/category.dart';
import '../../../../../data/models/dish.dart';
import '../../../../../data/repositories/food_menu_repository.dart';
import '../../../../../helpers/get.dart';

class HomeTabController extends ChangeNotifier {
  final FoodMenuRepository _foodMenuRepository = Get.i.find<FoodMenuRepository>();

  final List<Category> categories = [
    Category(
      iconPath: "assets/svg/home_tab_svg/breakfast.svg",
      label: "Breakfast",
    ),
    Category(
      iconPath: "assets/svg/home_tab_svg/fries.svg",
      label: "Fast food",
    ),
    Category(
      iconPath: "assets/svg/home_tab_svg/dinner.svg",
      label: "Dinner",
    ),
    Category(
      iconPath: "assets/svg/home_tab_svg/dessert.svg",
      label: "Desserts",
    ),
  ];

  List<Dish> _popularMenu = [];
  List<Dish> get popularMenu => _popularMenu;

  void afterFirstLayout() {
    _init();
  }

  void _init() async {
    _popularMenu = await _foodMenuRepository.getPopularMenu();
    notifyListeners();
  }
}
