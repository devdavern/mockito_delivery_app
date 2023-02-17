import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global_controllers/my_cart_controller.dart';
import '../../../global_widgets/rounded_button.dart';
import '../dish_controller.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({Key? key}) : super(key: key);

  void _addToCart(BuildContext context) {
    final MyCartController myCartController = context.read<MyCartController>();

    final DishController controller = context.read<DishController>();

    final isInCart = myCartController.isInCart(controller.dish);

    myCartController.addToCart(controller.dish);
    final SnackBar snackBar = SnackBar(
      content: Text(
        isInCart ? "Order Updated" : "Added to cart",
        textAlign: TextAlign.center,
      ),
      backgroundColor: const Color(0xffff8f00),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final dishController = Provider.of<DishController>(context, listen: false);
    final bool isInCart = context.select<MyCartController, bool>(
      (_) => _.isInCart(dishController.dish),
    );
    return RoundedButton(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
        top: 8,
        bottom: 8,
      ),
      label: isInCart ? "Update Order" : "Add to cart",
      onPressed: () => _addToCart(context),
      fullWidth: false,
      fontSize: 22,
    );
  }
}
