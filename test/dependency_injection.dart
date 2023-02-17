import 'package:mockito_delivery_app/src/data/providers/local/preferences_provider.dart';
import 'package:mockito_delivery_app/src/data/repositories/account_repository.dart';
import 'package:mockito_delivery_app/src/data/repositories/authentication_repository.dart';
import 'package:mockito_delivery_app/src/data/repositories/food_menu_repository.dart';
import 'package:mockito_delivery_app/src/data/repositories/preferences_repository.dart';
import 'package:mockito_delivery_app/src/data/repositories/websocket_repository.dart';
import 'package:mockito_delivery_app/src/data/repositories_implements/account_repository%20_impl.dart';
import 'package:mockito_delivery_app/src/data/repositories_implements/authentication_repository_impl.dart';
import 'package:mockito_delivery_app/src/data/repositories_implements/food_menu_repository_impl.dart';
import 'package:mockito_delivery_app/src/data/repositories_implements/preferences_repository_impl.dart';
import 'package:mockito_delivery_app/src/data/repositories_implements/websocket_repository_impl.dart';
import 'package:mockito_delivery_app/src/helpers/get.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mock/mock_account_provider.dart';
import 'mock/mock_authentication_client.dart';
import 'mock/mock_authentication_provider.dart';
import 'mock/mock_food_menu_provider.dart';
import 'mock/mock_websocket_provider.dart';

abstract class TestDependencyInjection {
  static Future<void> initialize() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    final preferences = await SharedPreferences.getInstance();
    final PreferencesProvider preferencesProvider =
        PreferencesProvider(preferences);

    Get.i.put<PreferencesRepository>(
      PreferencesRepositoryImpl(preferencesProvider),
    );

    final authenticationProvider = MockAuthenticationProvider();
    final authenticationClient = MockAuthenticationClient(preferences);

    Get.i.put<AuthenticationRepository>(
      AuthenticationRepositoryImpl(
          authenticationProvider, authenticationClient),
    );

    final accountProvider = MockAccountProvider(authenticationClient);

    Get.i.put<AccountRepository>(AccountRepositoryImpl(accountProvider));
    Get.i.put<WebsocketRepository>(
      WebsocketRepositoryImpl(MockWebsocketProvider()),
    );
    Get.i.put<FoodMenuRepository>(
      FoodMenuRepositoryImpl(MockFoodMenuProvider()),
    );
  }

  static clear() {
    Get.i.clear();
    Get.i.lazyClear();
  }
}

// abstract class TestDependencyInjection {
//   static Future<void> initialize() async {
//     TestWidgetsFlutterBinding.ensureInitialized();
//     SharedPreferences.setMockInitialValues({});
//     final preferences = await SharedPreferences.getInstance();
//     final preferencesProvider = PreferencesProvider(preferences);
//     Get.i.put<PreferencesRepository>(
//       PreferencesRepositoryImpl(preferencesProvider),
//     );
//     final authenticationProvider = AuthenticationProvider();
//     final authenticationClient = AuthenticationClient(preferences);
//     Get.i.put<AuthenticationRepository>(
//       AuthenticationRepositoryImpl(
//           authenticationProvider, authenticationClient),
//     );
//     final accountProvider = AccountProvider(authenticationClient);
//     Get.i.put<AccountRepository>(
//       (AccountRepositoryImpl(accountProvider)),
//     );
//   }
//   static clear() {
//     Get.i.clear();
//     Get.i.lazyClear();
//   }
// }
