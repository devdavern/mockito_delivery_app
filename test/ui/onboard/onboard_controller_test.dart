import 'package:mockito_delivery_app/src/routes/routes.dart';
import 'package:mockito_delivery_app/src/ui/pages/onboard/onboard_controller.dart';
import 'package:mockito_delivery_app/src/ui/pages/onboard/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Onboard Controller Test's > ", () {
    final controller = OnboardController();

    test('IMAGES with .svg', () {
      for (final item in controller.items) {
        expect(item.image.endsWith('.svg'), true);
      }
    });

    test('currentPage initial value', () {
      expect(controller.currentPage, 0);
    });
  });

  group("Onboard page Test's > ", () {
    testWidgets('afterFirstLayout', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const OnboardPage(),
        routes: {
          Routes.welcome: (_) => Container(),
        },
      ));
      expect(find.text("Next"), findsOneWidget);

      await tester.tap(find.text("Next"));
      await tester.pumpAndSettle(const Duration(milliseconds: 3000));
      expect(find.text("Next"), findsOneWidget);

      await tester.tap(find.text("Next"));
      await tester.pumpAndSettle(const Duration(milliseconds: 3000));
      expect(find.text("Get Started"), findsOneWidget);

      await tester.tap(find.text("Get Started"));
      await tester.pumpAndSettle();
      expect(find.text("Get Started"), findsNothing);
    });

    testWidgets('afterFirstLayout 2', (WidgetTester tester) async {});
  });
}
