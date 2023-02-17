import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/dish.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';
import '../../../global_controllers/my_cart_controller.dart';
import '../../../global_widgets/dish_counter.dart';

class MyCartItem extends StatelessWidget {
  final Dish dish;
  const MyCartItem({Key? key, required this.dish})
      : // assert(dish != null),
        super(key: key);

  void _deleteItem(BuildContext context) {
    final myCartController = context.read<MyCartController>();
    myCartController.deleteFromCart(dish);
  }

  void _onCounterChanged(BuildContext context, int counter) {
    final updatedDish = dish.updateCounter(counter);
    final myCartController = context.read<MyCartController>();
    myCartController.addToCart(updatedDish);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            spacing: 4,
            onPressed: ((context) {
              _deleteItem(context);
            }),
            backgroundColor: primaryColor,
            foregroundColor: Colors.black,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      // return Slidable(
      //   actionPane: SlidableDrawerActionPane(),
      //   secondaryActions: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 5),
      //       child: IconSlideAction(
      //         caption: 'Delete',
      //         color: Colors.red,
      //         icon: Icons.delete,
      //         onTap: () => _deleteItem(context),
      //       ),
      //     ),
      //   ],
      child: Container(
        margin: const EdgeInsets.all(10).copyWith(bottom: 5),
        decoration: BoxDecoration(
          color: const Color(0xfffafafa),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffd7ccc8),
              blurRadius: 0,
              offset: Offset(
                5,
                5,
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: dish.photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dish.name,
                    style: MyFontStyles.subtitleColor.copyWith(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "\$",
                          style: MyFontStyles.subtitleColor.copyWith(
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: " ${dish.price}",
                              style: MyFontStyles.title.copyWith(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DishCounter(
                        size: DishCounterSize.mini,
                        initialValue: dish.counter,
                        onChanged: (counter) =>
                            _onCounterChanged(context, counter),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
