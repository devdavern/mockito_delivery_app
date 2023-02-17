import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/models/dish.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';
import '../../../../../global_controllers/my_cart_controller.dart';
import '../../../../dish/dish_controller.dart';

class DishHomeItem extends StatelessWidget {
  const DishHomeItem({
    Key? key,
    required this.item,
    required this.isFirst,
  }) : //assert(item != null),
        //assert(isFirst != null),
        super(key: key);

  final bool isFirst;

  final Dish item;

  String get tag => "${key.toString()}-${item.id}";

  void _goToDetail(BuildContext context) {
    final int counter = context.read<MyCartController>().getDishCounter(item);
    final Dish dish = item.updateCounter(counter);

    Navigator.pushNamed(
      context,
      Routes.dish,
      arguments: DishPageArguments(tag: tag, dish: dish),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8)
            .copyWith(left: isFirst ? 10 : 8),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Hero(
                tag: tag,
                child: ClipRRect(
                  // ignore: sort_child_properties_last
                  child: CachedNetworkImage(
                    imageUrl: item.photo,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -1,
                child: Container(
                  padding: const EdgeInsets.all(10).copyWith(top: 66),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white.withOpacity(0.07),
                        Colors.white.withOpacity(0.25),
                        Colors.white.withOpacity(0.45),
                        Colors.white.withOpacity(0.65),
                        Colors.white.withOpacity(0.85),
                        Colors.white,
                      ],
                      stops: const [
                        0.05,
                        0.15,
                        0.25,
                        0.35,
                        0.45,
                        0.55,
                        1,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: MyFontStyles.subSubtitle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "\$",
                              style: MyFontStyles.subtitleColor.copyWith(
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: " ${item.price}",
                                  style: MyFontStyles.subtitleColor.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (item.rate != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4)
                                  .copyWith(right: 8),
                              // ignore: sort_child_properties_last
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    "${item.rate}",
                                    style: MyFontStyles.subSubtitle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => _goToDetail(context),
        ),
      ),
    );
  }
}
