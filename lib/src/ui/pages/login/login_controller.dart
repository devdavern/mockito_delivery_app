import 'package:mockito_delivery_app/src/helpers/get.dart';
import 'package:flutter/widgets.dart';

import '../../../data/models/user.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../data/repositories/authentication_repository.dart';

class LoginController extends ChangeNotifier {
  String _email = '@.com', _password = '';
  final _authenticationRepository = Get.i.find<AuthenticationRepository>();
  final _accountRepository = Get.i.find<AccountRepository>();

  String get email => _email;
  String get password => _password;

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<User?> submit() async {
    final String? token =
        await _authenticationRepository.login(_email, _password);
    if (token != null) {
      await _authenticationRepository.saveToken(token);
      return _accountRepository.userInformation;
    }
    return null;
  }
}

// class LoginController extends ChangeNotifier {
//   String _email = '', _password = '';
//   final _repository = Get.i.find<AuthenticationRepository>();
//   void onEmailChanged(String text) {
//     _email = text;
//   }
//   void onPasswordChanged(String text) {
//     _password = text;
//   }
//   Future<User?> submit() async {
//     return _repository.login(_email, _password);
//   }
// }
