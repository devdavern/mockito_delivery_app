import 'dart:convert';

import 'package:flutter/services.dart';

import '../../models/dish.dart';

class FoodMenuProvider {
  Future<List<Dish>> getPopularMenu() async {
    final jsonAsString = await rootBundle
        .loadString('assets/svg/home_tab_svg/json/popular_menu.json');

    final List list = jsonDecode(jsonAsString); //List<Map<String, dynamic>>

    List<Dish> dishes = [];

    for (final Map<String, dynamic> item in list) {
      final dish = Dish(
        id: item['id'],
        name: item['name'],
        photo: item['preview'],
        price: double.parse(
          item['price'].toString(),
        ),
       rate: item['rate'] != null
            ? double.parse(
                item['rate'].toString(),
              )
            : null,
        description: item['description'],
      );

      dishes.add(dish);
    }
    return dishes;
  }
}
