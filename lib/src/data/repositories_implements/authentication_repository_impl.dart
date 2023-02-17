import '../models/user.dart';
import '../providers/local/authentication_client.dart';
import '../providers/remote/authentication_provider.dart';
import '../repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider;
  final AuthenticationClient _authenticationClient;
  AuthenticationRepositoryImpl(
      this._authenticationProvider, this._authenticationClient);

  @override
  Future<String?> login(String email, String password) {
    return _authenticationProvider.login(email, password);
  }

  @override
  Future<bool> register(User user) {
    return _authenticationProvider.register(user);
  }

  @override
  Future<bool> sendResetToken(String email) {
    return _authenticationProvider.sendResetToken(email);
  }

  @override
  Future<void> saveToken(String token) {
    return _authenticationClient.saveToken(token);
  }

  @override
  String? get token => _authenticationClient.token;

  @override
  Future<void> signOut() {
    return _authenticationClient.signOut();
  }
}


// class AuthenticationRepositoryImpl implements AuthenticationRepository {
//   final AuthenticationProvider _authenticationProvider;
//   final AuthenticationClient _authenticationClient;
//   AuthenticationRepositoryImpl(
//       this._authenticationProvider, this._authenticationClient);
//   AuthenticationRepositoryImpl(this._authenticationProvider);
//   @override
//   Future<User?> login(String email, String password) {
//     return _authenticationProvider.login(email, password);
//   }
//   @override
//   Future<bool>? register(User user) {
//     return _authenticationProvider.register(user);
//   }
//   @override
//   Future<bool> sendResetToken(String email) {
//     return _authenticationProvider.sendResetToken(email);
//   }
//   // @override
//   // Future<void> saveToken(String token) {
//   //   return _authenticationClient.saveToken(token);
//   // }
//   // @override
//   // String? get token => _authenticationClient.token;
//   @override
//   Future<void> signOut() {
//     return _authenticationClient.signOut();
//   }
// }
