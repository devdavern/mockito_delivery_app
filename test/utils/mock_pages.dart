import 'package:mockito_delivery_app/src/ui/global_controllers/my_cart_controller.dart';
import 'package:mockito_delivery_app/src/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget mockPages({
  Widget? home,
  Map<String, Widget Function(BuildContext)>? routes,
}) {
  return ChangeNotifierProvider<MyCartController>(
    create: (_) => MyCartController(),
    builder: (_, __) => const MaterialApp(
      home: HomePage(),
      routes: {},
    ),
  );
}
