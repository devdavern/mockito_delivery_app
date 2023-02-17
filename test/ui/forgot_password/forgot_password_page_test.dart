import 'package:mockito_delivery_app/src/ui/global_widgets/input_text.dart';
import 'package:mockito_delivery_app/src/ui/pages/forgot_password/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';

void main() {
  setUpAll(() async {
    await TestDependencyInjection.initialize();
  });

  tearDownAll(() {
    TestDependencyInjection.clear();
  });

  testWidgets('ForgotPasswordPage', (WidgetTester tester) async {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey();

    await tester.pumpWidget(MaterialApp(
      home: const ForgotPasswordPage(),
      navigatorKey: navigatorKey,
    ));

    final router = navigatorKey.currentState!;
    final buttonFinder = find.text("Send");

    /// TODO invalid email dialog
    await tester.tap(buttonFinder);
    await tester.pump();
    expect(find.text('ERROR'), findsOneWidget);
    router.pop();

    /// TODO dismiss invalid email dialog
    await tester.pump();
    expect(find.text('ERROR'), findsNothing);

    await tester.enterText(find.byType(InputText), "test@test.com");
    await tester.pump();
    expect(find.text("test@test.com"), findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump(const Duration(milliseconds: 3000));
    expect(find.text("GOOD"), findsOneWidget);
  });
}
