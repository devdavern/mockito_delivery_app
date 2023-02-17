import 'dart:async';

import 'package:mockito_delivery_app/src/data/models/user.dart';
import 'package:mockito_delivery_app/src/data/repositories/authentication_repository.dart';
import 'package:mockito_delivery_app/src/data/repositories/preferences_repository.dart';
import 'package:mockito_delivery_app/src/helpers/get.dart';
import 'package:mockito_delivery_app/src/ui/pages/splash/splash_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';

void main() {
  setUpAll(() async {
    await TestDependencyInjection.initialize();
  });

  tearDownAll(() {
    TestDependencyInjection.clear();
  });

  group("afterFirstLayout Test's > ", () {
    test('Token == null && isReady False', () async {
      addTearDown(() async {
        await Get.i
            .find<PreferencesRepository>()
            .setOnboardAndWelcomeReady(true);
      });

      final controller = SplashController();
      final Completer<void> completer = Completer();

      controller.onAfterFirstLayout = (User? user, bool isReady) {
        expect(user == null, true);
        expect(isReady, false);
        completer.complete();
      };
      controller.afterFirstLayout();
      await completer.future;
    });

    test('Token == null && isReady True', () async {
      addTearDown(() async {
        await Get.i.find<AuthenticationRepository>().saveToken('TOKEN');
      });

      final controller = SplashController();
      final Completer<void> completer = Completer();

      controller.onAfterFirstLayout = (User? user, bool isReady) {
        expect(user == null, true);
        expect(isReady, true);
        completer.complete();
      };
      controller.afterFirstLayout();
      await completer.future;
    });

    test('Token != null', () async {
      final controller = SplashController();
      final Completer<void> completer = Completer();

      controller.onAfterFirstLayout = (User? user, bool isReady) {
        expect(user == null, false);
        completer.complete();
      };
      controller.afterFirstLayout();
      await completer.future;
    });
  });
}
