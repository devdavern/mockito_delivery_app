import 'package:mockito_delivery_app/src/data/models/user.dart';
import 'package:mockito_delivery_app/src/data/repositories/authentication_repository.dart';
import 'package:mockito_delivery_app/src/helpers/get.dart';
import 'package:mockito_delivery_app/src/ui/pages/login/login_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';

void main() {
  late LoginController loginController;
  setUpAll(() async {
    await TestDependencyInjection.initialize();
    loginController = LoginController();
  });
  tearDownAll(() {
    TestDependencyInjection.clear();
  });
  group("loginController Test's > ", () {
    test('onEmailChanged', () {
      expect(loginController.email, '@.com');
      loginController.onEmailChanged("davern1999@test.com");
      expect(loginController.email, 'davern1999@test.com');
    });

    test('onPasswordChanged', () {
      expect(loginController.password, '');
      loginController.onPasswordChanged("0000");
      expect(loginController.password, '0000');
    });

    test('submit failed', () async {
      loginController.onEmailChanged("dsdfsdfsf.sdsdsdfsd");
      loginController.onPasswordChanged("IIIIIIIIIIIIIIII");
      final user = await loginController.submit();
      expect(user == null, true);
    });

    test('submit success', () async {
      loginController.onEmailChanged("@.com");
      loginController.onPasswordChanged("");
      final user = await loginController.submit();
      // print(
      //     'EMAIL::::${loginController.email} \nPASSW::::${loginController.password} \nSUBMIT::::$user');
      expect(user != null, true);
      expect(user, isA<User>());
      final token = Get.i.find<AuthenticationRepository>().token;
      expect(token != null, true);
    });
  });
}
