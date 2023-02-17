import 'package:mockito_delivery_app/src/data/models/user.dart';
import 'package:mockito_delivery_app/src/data/providers/remote/authentication_provider.dart';

class MockAuthenticationProvider implements AuthenticationProvider {
  @override
  Future<String?> login(String email, String password) async {
    if (email == "@.com" && password == "") {
      final String token = DateTime.now().millisecondsSinceEpoch.toString();
      return token;
    }
    return null;
  }

  @override
  Future<bool> register(User user) async {
    return true;
  }

  @override
  Future<bool> sendResetToken(String email) async {
    return true;
  }
}
