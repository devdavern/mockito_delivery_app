import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app/app_utils.dart';
import '../../../../utils/colors.dart';
import '../home_controller.dart';
import 'home_indicator.dart';
import 'package:badges/badges.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);
    final int currentPage = context.select<HomeController, int>(
      (_) => _.currentPage,
    );
    final menuItems = context.select<HomeController, List<BottomBarItem>>(
      (_) => _.menuItems,
    );
    return Container(
      color: Colors.transparent,
      height: 55,
      child: SafeArea(
        top: false,
        child: TabBar(
          controller: controller.tabController,
          indicator: const HomeTabBarIndicator(),
          tabs: List.generate(
            menuItems.length,
            (index) {
              final item = menuItems[index];
              return BottomBarTab(
                item: item,
                isActive: currentPage == index,
              );
            },
          ),
        ),
      ),
    );
  }
}

class BottomBarTab extends StatelessWidget {
  const BottomBarTab({
    Key? key,
    // ignore: library_private_types_in_public_api
    required this.item,
    required this.isActive,
  }) : super(key: key);

  // ignore: library_private_types_in_public_api
  final BottomBarItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? primaryColor : Colors.grey.shade600;
    final content = Padding(
      padding: const EdgeInsets.all(5),
      child: AppUtils.isHtml
          ? Image.network(
              item.icon,
              color: color,
              fit: BoxFit.contain,
            )
          : SvgPicture.asset(
              item.icon,
              color: color,
              fit: BoxFit.contain,
            ),
    );
    return Tab(
      key: Key(item.label),
      icon: item.badgeCount > 0
          ? Badge(
              badgeContent: Text(
                '${item.badgeCount}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              animationType: BadgeAnimationType.scale,
              badgeColor: Colors.redAccent,
              elevation: 4,
              child: content,
            )
          : content,
    );
  }
}
