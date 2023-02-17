import '../../models/user.dart';
import '../local/authentication_client.dart';

class AccountProvider {
  final AuthenticationClient _authenticationClient;
  AccountProvider(this._authenticationClient);

  Future<User?> get userInformation async {
    final token = _authenticationClient.token;

    if (token == null) {
      throw Exception('token is null');
    }

    await Future.delayed(const Duration(milliseconds: 2000));

    return User(
      id: "1234",
      email: "davern1999@test.com",
      name: "David",
      lastName: "Hernandez",
      password: "0000",
      birthday: DateTime(1999, 8, 10),
    );
  }
}
