// ignore_for_file: sort_child_properties_last

import 'package:flutter/cupertino.dart';

import '../../../../../../data/models/dish.dart';
import '../../../../../../utils/font_styles.dart';
import 'dish_item.dart';

class HorizontalDishes extends StatelessWidget {
  final List<Dish> dishes;
  final String title;
  final VoidCallback? onViewAll;
  const HorizontalDishes({
    Key? key,
    this.onViewAll,
    required this.dishes,
    required this.title,
  }) : //assert(dishes.length >= 0),
        //assert(dishes != null),
        //assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width * 0.6;
    return SizedBox(
      height: 222,
      child: Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: MyFontStyles.title
                        .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.all(10),
                    minSize: 55,
                    child: Text(
                      "View All",
                      style: MyFontStyles.subtitleColor,
                    ),
                    onPressed: onViewAll,
                  )
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final item = dishes[index];
                  return DishHomeItem(
                    key: UniqueKey(),
                    item: item,
                    isFirst: index == 0,
                  );
                },
                itemCount: dishes.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
