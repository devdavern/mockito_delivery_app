import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../data/models/dish.dart';
import '../../../../../helpers/get.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/font_styles.dart';
import '../../home_controller.dart';

class FavoriteItem extends StatelessWidget {
  final Dish dish;
  const FavoriteItem({
    Key? key,
    required this.dish,
  }) : //assert(dish != null),
        super(key: key);

  void _deleteItem() {
    final homeController = Get.i.find<HomeController>();
    homeController.deleteFavorite(dish);
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
              _deleteItem();
            }),
            backgroundColor: primaryColor,
            foregroundColor: Colors.black,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      // child: Slidable(
      //   actionPane: SlidableDrawerActionPane(),
      //   secondaryActions: [
      //     Padding(
      //       padding:
      //           const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 5),
      //       child: IconSlideAction(
      //         caption: 'Delete',
      //         color: Colors.red,
      //         icon: Icons.delete,
      //         onTap: _deleteItem,
      //       ),
      //     ),
      //   ],
      child: Container(
        margin: const EdgeInsets.all(10).copyWith(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
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
              // ignore: sort_child_properties_last
              child: ClipRRect(
                // ignore: prefer_const_constructors
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
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dish.name,
                          style: MyFontStyles.subtitleColor.copyWith(
                            color: const Color(0xffa1887f),
                          ),
                        ),
                        const SizedBox(width: 22),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                "${dish.rate}",
                                style: MyFontStyles.subSubtitle.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      maxLines: 2,
                      dish.description,
                      overflow: TextOverflow.ellipsis,
                      style: MyFontStyles.subSubtitle.copyWith(
                        color: Colors.grey.shade600, //Color(0xffbcaaa4),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
