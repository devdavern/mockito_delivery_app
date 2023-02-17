import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/get.dart';
import '../../../../utils/app/app_utils.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';
import '../../../global_widgets/dish_counter.dart';
import '../../home/home_controller.dart';
import '../dish_controller.dart';

class DishDetail extends StatelessWidget {
  const DishDetail({
    Key? key,
  }) : super(key: key);

  void _toggleFavorite(BuildContext context) {
    final homeController = Get.i.find<HomeController>();
    final controller = context.read<DishController>();
    if (!controller.isFavorite) {
      // ignore: prefer_const_declarations
      final SnackBar snackBar = const SnackBar(
        content: Text(
          "Added to favorites",
          textAlign: TextAlign.center,
        ),
        backgroundColor: primaryColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    controller.toggleFavorite();
    homeController.toggleFavorite(controller.dish);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DishController>(context);
    final dish = controller.dish;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: MyFontStyles.title,
                    ),
                    Text(
                      "\$ ${dish.price}",
                      style: MyFontStyles.title.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 33,
                      ),
                    ),
                  ],
                ),
                CupertinoButton(
                  padding: const EdgeInsets.all(10),
                  child: AppUtils.isHtml
                      ? Image.network(
                          'assets/svg/favorite.svg',
                          width: 40,
                          height: 40,
                          color: controller.isFavorite
                              ? primaryColor
                              : const Color(0xffbcaaa4),
                        )
                      : SvgPicture.asset(
                          'assets/svg/favorite.svg',
                          width: 40,
                          height: 40,
                          color: controller.isFavorite
                              ? primaryColor
                              : const Color(0xffbcaaa4),
                        ),
                  onPressed: () => _toggleFavorite(context),
                ),
              ],
            ),
            const SizedBox(height: 5),
            DishCounter(
              initialValue: controller.dish.counter,
              onChanged: controller.onCounterChanged,
            ),
            const SizedBox(height: 30),
            Text(
              dish.description,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
