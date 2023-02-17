import 'package:mockito_delivery_app/src/routes/routes.dart';
import 'package:mockito_delivery_app/src/ui/pages/dish/dish_page.dart';
import 'package:mockito_delivery_app/src/ui/pages/home/tabs/home_tab/widgets/dish_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../dependency_injection.dart';
import '../../../../utils/mock_pages.dart';

void main() {
  setUpAll(() async {
    await TestDependencyInjection.initialize();
  });

  tearDownAll(() {
    TestDependencyInjection.clear();
  });

  testWidgets("homeTab > ", (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(
        mockPages(
          routes: {
            Routes.dish: (_) => const DishPage(),
          },
        ),
      );
      final itemsFinder = find.byType(DishHomeItem);
      expect(itemsFinder, findsNothing);
      await tester.pump(const Duration(milliseconds: 3000));
      expect(itemsFinder, findsWidgets);
      await tester.tap(itemsFinder.first);
      await tester.pumpAndSettle(const Duration(milliseconds: 29000));
      expect(find.text("Add to cart"), findsOneWidget);
    });
  });
}
