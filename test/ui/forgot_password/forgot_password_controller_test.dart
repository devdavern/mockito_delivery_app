import 'package:mockito_delivery_app/src/ui/pages/forgot_password/forgot_passwprd_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';

void main() {
  setUpAll(() async {
    await TestDependencyInjection.initialize();
  });

  tearDownAll(() {
    TestDependencyInjection.clear();
  });

  group("ForgotPasswordController", () {
    // Test's > ", () {
    late ForgotPasswordController controller;
    setUp(() {
      controller = ForgotPasswordController();
    });

    test('email == "..."', () {
      expect(controller.email == '...', true);
    });

    test('onEmailChanged', () {
      controller.onEmailChanged("@.com");
      expect(controller.email, "@.com");
    });

    test('submit invalid email', () async {
      bool? catchCalled = true;
      controller.onEmailChanged('');
      if (controller.email.contains('@') && controller.email.endsWith('.com')) {
        controller.submit();
      } else {
        catchCalled = false;
      }
      expect(catchCalled, false);
    });

    test('submit success', () async {
      controller.onEmailChanged("@.com");
      final result = await controller.submit();
      expect(result, true);
    });
  });
}
