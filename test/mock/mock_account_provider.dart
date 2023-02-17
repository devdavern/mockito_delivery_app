import 'package:mockito_delivery_app/src/data/models/user.dart';
import 'package:mockito_delivery_app/src/data/providers/local/authentication_client.dart';
import 'package:mockito_delivery_app/src/data/providers/remote/acoount_provider.dart';

class MockAccountProvider implements AccountProvider {
  final AuthenticationClient authenticationClient;

  MockAccountProvider(this.authenticationClient);
  @override
  Future<User?> get userInformation async {
    final token = authenticationClient.token;

    assert(token != null, 'token is null');

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
