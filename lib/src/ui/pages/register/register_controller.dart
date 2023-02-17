import 'package:mockito_delivery_app/src/data/models/user.dart';
import 'package:mockito_delivery_app/src/helpers/get.dart';
import 'package:flutter/widgets.dart';

import '../../../data/repositories/authentication_repository.dart';
import '../../global_widgets/custom_form.dart';

class RegisterController extends ChangeNotifier {
  // ignore: unused_field
  String _email = '', _name = '', _lastName = '', _password = '';

  final _repository = Get.i.find<AuthenticationRepository>();

  GlobalKey<CustomFormState> formKey = GlobalKey();

  String get email => _email;
  String get name => _name;
  String get lastName => _lastName;
  String get password => _password;

  void onEmailChanged(String text) {
    _email = text;
  }

  void onNameChanged(String text) {
    _name = text;
  }

  void onLastNameChanged(String text) {
    _lastName = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<bool?> submit() async {
    return await _repository.register(
      User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: _email,
        name: _name,
        lastName: _lastName,
        password: _password,
        birthday: DateTime(0),
      ),
    );
  }
}
