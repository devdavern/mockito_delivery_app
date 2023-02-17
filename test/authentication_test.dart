// import 'package:mockito_delivery_app/src/data/models/user.dart';
// import 'package:mockito_delivery_app/src/data/providers/local/authentication_client.dart';
// import 'package:mockito_delivery_app/src/data/providers/remote/authentication_provider.dart';
// import 'package:mockito_delivery_app/src/data/repositories/authentication_repository.dart';
// import 'package:mockito_delivery_app/src/data/repositories_implements/authentication_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mockito_delivery_app/src/data/models/user.dart';
// import 'package:mockito_delivery_app/src/data/providers/remote/acoount_provider.dart';

void main() {
  // test(
  //   'authentication',
  //   () async {
  //     TestWidgetsFlutterBinding.ensureInitialized();
  //     SharedPreferences.setMockInitialValues({});
  //     final prefs = await SharedPreferences.getInstance();
  //     final authenticationProvider = AuthenticationProvider();
  //     final authenticationClient = AuthenticationClient(prefs);
  //     final AuthenticationRepository repository = AuthenticationRepositoryImpl(
  //       authenticationProvider,
  //       authenticationClient,
  //     );
  //   },
  // );
}

// class MockAuthenticationRepositoryCopy implements AuthenticationRepository {
//   Map<String, Object> _data = {};
//   @override
//   Future<String?> login(String email, String password) async {
//     if (email == "@.com" && password == "") {
//       final String token = DateTime.now().millisecondsSinceEpoch.toString();
//       return token;
//     }
//     return null;
//   }
//   @override
//   Future<bool> register(User user) async {
//     return true;
//   }
//   @override
//   Future<void> saveToken(String token) async {
//     _data['token'] = token;
//   }
//   @override
//   Future<bool> sendResetToken(String email) async {
//     return true;
//   }
//   @override
//   Future<void> signOut() async {
//     _data.remove('token');
//   }
//   @override
//   String? get token => _data[token] as String;
// }

// class MockAuthenticationProviderCopy implements AuthenticationProvider {
//   @override
//   Future<String?> login(String email, String password) async {
//     if (email == "@.com" && password == "") {
//       final String token = DateTime.now().millisecondsSinceEpoch.toString();
//       return token;
//     }
//     return null;
//   }
//   @override
//   Future<bool> register(User user) async {
//     return true;
//   }
//   @override
//   Future<bool> sendResetToken(String email) async {
//     return true;
//   }
// }

// class MockAuthenticationClientCopy implements AuthenticationClient {
//   Map<String, Object> _data = {};
//   @override
//   Future<void> saveToken(String token) async {
//     _data['token'] = token;
//   }
//   @override
//   Future<void> signOut() async {
//     _data.remove('token');
//   }
//   @override
//   String? get token => _data['token'] as String?;
// }

// class MockAccountProviderCopy implements AccountProvider {
//   @override
//   Future<User?> get userInformation async {
//     return User(
//       id: "1234",
//       email: "davern1999@test.com",
//       name: "David",
//       lastName: "Hernandez",
//       password: "0000",
//       birthday: DateTime(1999, 8, 10),
//     );
//   }
// }
