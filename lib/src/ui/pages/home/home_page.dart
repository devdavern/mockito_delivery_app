import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/get.dart';
import '../../global_controllers/notifications_controller.dart';
import 'home_controller.dart';
import 'tabs/favorites_tab/favorites_tab.dart';
import 'tabs/home_tab/home_tab.dart';
import 'tabs/notifications_tab/notifications_tab.dart';
import 'tabs/profile_tab.dart';
import 'widgets/home_bottom_bar.dart';
import 'widgets/my_cart_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotificationsController>(
            create: (_) => NotificationsController()),
      ],
      builder: (contex, __) {
        return ChangeNotifierProvider<HomeController>(
          create: (_) {
            final controller =
                HomeController(contex.read<NotificationsController>());
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                controller.afterFirstLayout();
              },
            );
            Get.i.put<HomeController>(controller);
            controller.onDispose = () => Get.i.remove<HomeController>();
            return controller;
          },
          builder: (_, __) {
            final controller = Provider.of<HomeController>(_, listen: false);
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: const HomeBottomBar(),
              floatingActionButton: const FloatingMyCartButton(),
              body: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: const [
                      HomeTab(),
                      FavoritesTab(),
                      NotificationsTab(),
                      ProfileTab(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
