import 'package:mockito_delivery_app/src/data/providers/local/authentication_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

const key = 'token';

class MockAuthenticationClient implements AuthenticationClient {
  final SharedPreferences preferences;

  MockAuthenticationClient(this.preferences);

  @override
  Future<void> saveToken(String token) async {
    await preferences.setString(key, token);
  }

  @override
  Future<void> signOut() async {
    await preferences.remove(key);
  }

  @override
  String? get token => preferences.getString(key);
}
