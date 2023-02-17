import 'package:mockito_delivery_app/src/ui/pages/dish/dish_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../helpers/get.dart';
import '../home/home_controller.dart';
import 'widgets/add_to_cart_button.dart';
import 'widgets/dish_detail.dart';
import 'widgets/dish_header.dart';

class DishPage extends StatelessWidget {
  const DishPage({Key? key}) : super(key: key);

  void _setStatusBar(bool light) {
    SystemChrome.setSystemUIOverlayStyle(
        light ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DishController>(
      create: (_) {
        final homeController = Get.i.find<HomeController>();
        final DishPageArguments? args =
            ModalRoute.of(context)?.settings.arguments as DishPageArguments?;
        final isFavorite = homeController.isFavorite(args!.dish);
        final controller = DishController(args, isFavorite);
        _setStatusBar(true);
        controller.onDispose = () => _setStatusBar(false);
        return controller;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: const Padding(
          padding: EdgeInsets.all(8),
          child: AddToCartButton(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: const [
                    DishHeader(),
                    DishDetail(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
