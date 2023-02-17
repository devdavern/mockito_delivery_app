import '../../models/user.dart';

class AuthenticationProvider {
  Future<String?> login(String email, String password) async {
    // await Future.delayed(const Duration(milliseconds: 2000));

    if (email == "@.com" && password == "") {
      final String token = DateTime.now().millisecondsSinceEpoch.toString();
      return token;
    }
    return null;
  }

  Future<bool> register(User user) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return true;
  }

  Future<bool> sendResetToken(String email) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return true;
  }
}
