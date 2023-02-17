// ignore_for_file: file_names

import '../models/user.dart';
import '../providers/remote/acoount_provider.dart';
import '../repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountProvider _provider;

  AccountRepositoryImpl(this._provider);

  @override
  Future<User?> get userInformation => _provider.userInformation;
}
