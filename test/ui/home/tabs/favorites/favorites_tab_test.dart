import 'package:mockito_delivery_app/src/data/models/dish.dart';
import 'package:mockito_delivery_app/src/ui/pages/home/home_controller.dart';
import 'package:mockito_delivery_app/src/ui/pages/home/tabs/favorites_tab/favorites_item.dart';
import 'package:mockito_delivery_app/src/ui/pages/home/widgets/home_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../dependency_injection.dart';
import '../../../../utils/mock_pages.dart';

void main() {
  setUpAll(() async {
    await TestDependencyInjection.initialize();
  });

  tearDownAll(() {
    TestDependencyInjection.clear();
  });

  testWidgets('favorites tab', (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(mockPages());
      final tabsFinder = find.descendant(
        of: find.byType(HomeBottomBar),
        matching: find.byType(Tab),
      );
      await tester.tap(tabsFinder.at(1));
      await tester.pumpAndSettle(const Duration(milliseconds: 3000));
      expect(find.byType(FavoriteItem), findsNothing);
      final scaffoldContext = tester.state(find.byType(Scaffold)).context;
      final homeController = scaffoldContext.read<HomeController>();
      final dish = Dish(
        id: 1,
        name: "",
        photo: "",
        price: 9.99,
        rate: null,
        description: "",
      );
      homeController.toggleFavorite(dish);
      await tester.pump();
      expect(find.byType(FavoriteItem), findsWidgets);
      final firstFavorite = find.byType(FavoriteItem).first;

      final width = tester.getSize(find.byType(Scaffold)).width * 0.25;
      await tester.drag(firstFavorite, Offset(-width, 0));
      await tester.pumpAndSettle();
      expect(find.byType(SlidableAction), findsWidgets);

      await tester.tap(find.byType(SlidableAction).first);
      await tester.pump();
      expect(find.byType(FavoriteItem), findsNothing);
      expect(homeController.favorites.length, 0);
    });
  });
}
