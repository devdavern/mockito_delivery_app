import 'package:flutter/widgets.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/repositories/preferences_repository.dart';
import '../../../helpers/get.dart';

class SplashController extends ChangeNotifier {
  final _preferencesRepository = Get.i.find<PreferencesRepository>();
  final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  final _accountRepository = Get.i.find<AccountRepository>();

  void Function(User? user, bool isReady)? onAfterFirstLayout;

  void afterFirstLayout() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    final token = _authenticationRepository.token;
    if (token != null) {
      final user = await _accountRepository.userInformation;
      if (user != null) {
        if (onAfterFirstLayout != null) {
          onAfterFirstLayout!(user, true);
          return;
        }
      }
    }
    final isReady = _preferencesRepository.onboardAndWelcomeReady;
    if (onAfterFirstLayout != null) {
      onAfterFirstLayout!(null, isReady);
    }
  }
}
