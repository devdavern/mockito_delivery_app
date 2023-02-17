import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/dish.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/app/app_utils.dart';
import '../../../global_controllers/my_cart_controller.dart';

class FloatingMyCartButton extends StatelessWidget {
  const FloatingMyCartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasItems =
        context.select<MyCartController, bool>((_) => _.hasItems);

    if (!hasItems) {
      return Container(
        color: Colors.transparent,
        width: 1,
        height: 1,
      );
    }

    final cart =
        context.select<MyCartController, Map<int, Dish>>((_) => _.cart);
    return Padding(
      padding: const EdgeInsets.only(left: 22),
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Container(
          width: 77,
          height: 77,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              FloatingActionButton(
                child: AppUtils.isHtml
                    ? Image.network(
                        'assets/svg/cart.svg',
                        width: 33,
                        color: Colors.white,
                      )
                    : SvgPicture.asset(
                        'assets/svg/cart.svg',
                        width: 33,
                        color: Colors.white,
                      ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.myCart);
                },
              ),
              Positioned(
                top: -2,
                right: 4,
                child: Container(
                  width: 5 * 5,
                  height: 5 * 6,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.2,
                    ),
                  ),
                  child: Text(
                    "${cart.length}",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
