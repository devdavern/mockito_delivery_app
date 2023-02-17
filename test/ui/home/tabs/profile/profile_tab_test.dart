import 'package:mockito_delivery_app/src/data/models/user.dart';
import 'package:mockito_delivery_app/src/helpers/get.dart';
import 'package:mockito_delivery_app/src/routes/routes.dart';
import 'package:mockito_delivery_app/src/ui/pages/home/widgets/home_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../dependency_injection.dart';
import '../../../../utils/mock_pages.dart';

void main() {
  setUpAll(() async {
    await TestDependencyInjection.initialize();
    Get.i.put<User>(
      User(
        id: "1234",
        email: "davern1999@test.com",
        name: "David",
        lastName: "Hernandez",
        password: "0000",
        birthday: DateTime(2000, 1, 1),
      ),
    );
  });

  tearDownAll(() {
    TestDependencyInjection.clear();
  });

  testWidgets('profile tab > ', (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(
        mockPages(routes: {
          Routes.login: (_) => Container(),
        }),
      );

      final tabsFinder = find.descendant(
        of: find.byType(HomeBottomBar),
        matching: find.byType(Tab),
      );
      await tester.tap(tabsFinder.at(3));
      await tester.pumpAndSettle(const Duration(milliseconds: 3000));
      expect(find.text("Sign Out"), findsOneWidget);
      await tester.ensureVisible(find.text("Sign Out"));
      await tester.pump();
      await tester.tap(find.text("Sign Out"));
      await tester.pumpAndSettle();
      expect(find.text("ACTION REQUIRED"), findsOneWidget);
      Finder dialogButtonsFinder = find.descendant(
        of: find.byType(CupertinoActionSheet),
        matching: find.byType(CupertinoActionSheetAction),
      );

      await tester.tap(dialogButtonsFinder.last);
      await tester.pumpAndSettle();
      expect(find.text("ACTION REQUIRED"), findsNothing);
      await tester.tap(find.text("Sign Out"));
      await tester.pumpAndSettle();
      dialogButtonsFinder = find.descendant(
        of: find.byType(CupertinoActionSheet),
        matching: find.byType(CupertinoActionSheetAction),
      );
      await tester.tap(dialogButtonsFinder.first);
      await tester.pumpAndSettle(const Duration(milliseconds: 29000));
      expect(find.text("Sign Out"), findsNothing);
    });
  });
}
