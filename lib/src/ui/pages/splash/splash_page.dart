import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/user.dart';
import '../../../helpers/get.dart';
import '../../../routes/routes.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashController>(
      lazy: false,
      create: (_) {
        final controller = SplashController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFirstLayout();
        });
        controller.onAfterFirstLayout = (user, isReady) {
          String routeName = isReady ? Routes.login : Routes.onboard;

          Get.i.put<bool>(true, tag: 'after-splash');

          if (user != null) {
            routeName = Routes.home;
            Get.i.put<User>(user);
          }
          Navigator.pushReplacementNamed(context, routeName);
        };
        return controller;
      },
      builder: (_, __) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
