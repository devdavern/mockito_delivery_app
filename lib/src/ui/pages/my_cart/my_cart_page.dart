import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/font_styles.dart';
import '../../global_controllers/my_cart_controller.dart';
import '../../global_widgets/circular_animation.dart';
import 'widgets/check_out_preview.dart';
import 'widgets/my_cart_item.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<MyCartController>().cart.values.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: MyFontStyles.subtitleColor,
        ),
        elevation: 0,
        leading: IconButton(
          hoverColor: primaryColor,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: cart.isEmpty ? 122 : 40,
              left: cart.isEmpty ? 2 : 10,
              right: cart.isEmpty ? 2 : 10,
              bottom: cart.isEmpty ? 122 : 40,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  color: Colors.orange.shade100,
                  child: Center(
                    child: CircularAnimation(
                      grados: 90,
                    ),
                  ),
                ),
              ),
            ),
            cart.isEmpty
                ? const Center(
                    child: Text("No elements"),
                  )
                : ListView.builder(
                    itemBuilder: (_, index) {
                      final dish = cart[index];
                      return MyCartItem(dish: dish);
                    },
                    itemCount: cart.length,
                  ),
          ],
        ),
      ),
      bottomNavigationBar: const CheckOutPreview(),
    );
  }
}
