import 'package:flutter/cupertino.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../../../helpers/get.dart';

class ForgotPasswordController extends ChangeNotifier {
  String _email = '...';

  String get email => _email;

  final _repository = Get.i.find<AuthenticationRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  Future<bool> submit() async => (_email.contains('@') && _email.endsWith('.com'))
          ? await _repository.sendResetToken(_email)
          : false;
}
