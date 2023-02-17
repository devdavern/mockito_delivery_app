

import '../providers/local/preferences_provider.dart';
import '../repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final PreferencesProvider _provider;
  PreferencesRepositoryImpl(this._provider);

  @override
  bool get onboardAndWelcomeReady => _provider.onboardAndWelcomeReady;

  @override
  Future<void> setOnboardAndWelcomeReady(bool ready) {
    return _provider.setOnboardAndWelcomeReady(ready);
  }
}