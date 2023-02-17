import 'package:mockito_delivery_app/src/routes/routes.dart';
import 'package:mockito_delivery_app/src/ui/global_widgets/rounded_button.dart';
import 'package:mockito_delivery_app/src/ui/pages/register/register_controller.dart';
import 'package:mockito_delivery_app/src/ui/pages/register/register_page.dart';
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

  group("RegisterController Test's > ", () {
    late RegisterController controller;
    setUp(() {
      controller = RegisterController();
    });

    test('email, name, lastName & password', () {
      expect(controller.email, '');
      expect(controller.name, '');
      expect(controller.lastName, '');
      expect(controller.password, '');

      controller.onEmailChanged("davern1999@test.com");
      controller.onNameChanged("David");
      controller.onLastNameChanged("Hernandez");
      controller.onPasswordChanged("0000");

      expect(controller.email, 'davern1999@test.com');
      expect(controller.name, 'David');
      expect(controller.lastName, 'Hernandez');
      expect(controller.password, '0000');
    });

    test('submit', () async {
      controller.onEmailChanged("davern1999@test.com");
      controller.onNameChanged("David");
      controller.onLastNameChanged("Hernandez");
      controller.onPasswordChanged("0000");
      final result = await controller.submit();
      expect(result, true);
    });
  });

  group("GlobalKey<CustomFormState> formKey Test's > ", () {
    testWidgets('RegisterForm', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        // home: RegisterPage(),
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              key: const Key('homeButton'),
              child: const Text("0000"),
              onPressed: () {
                Navigator.pushNamed(context, Routes.register);
              },
            ),
          ),
        ),
        routes: {
          '/register': (_) => const RegisterPage(),
        },
      ));

      await tester.tap(find.byKey(const Key('homeButton')));
      await tester.pumpAndSettle(const Duration(milliseconds: 3000));

      final buttonFinder = find.byType(RoundedButton);
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pump();
      expect(find.text("ERROR"), findsOneWidget);
      expect(find.text("Invalid Inputs, please confirm"), findsOneWidget);
      await tester.tap(find.text("OK"));
      await tester.pump();

      final inputNameFinder = find.byKey(const Key('register-name'));
      final inputlastNameFinder = find.byKey(const Key('register-lastName'));
      final inputEmailFinder = find.byKey(const Key('register-email'));
      final inputPasswordFinder = find.byKey(const Key('register-password'));

      await tester.enterText(inputNameFinder, "David");
      await tester.enterText(inputlastNameFinder, "Hernandez");
      await tester.enterText(inputEmailFinder, "test@test.com");
      await tester.enterText(inputPasswordFinder, "0000");
      await tester.pump();
      expect(find.text("David"), findsOneWidget);
      expect(find.text("Hernandez"), findsOneWidget);
      expect(find.text("test@test.com"), findsOneWidget);
      expect(find.text("0000"), findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pump(const Duration(milliseconds: 3000));
      expect(find.text("GOOD"), findsOneWidget);
      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle(const Duration(milliseconds: 3000));
      expect(find.text("Sign Up"), findsNothing);
    });
  });
}
