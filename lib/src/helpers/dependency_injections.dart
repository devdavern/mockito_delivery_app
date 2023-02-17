import 'package:shared_preferences/shared_preferences.dart';

import '../data/providers/local/authentication_client.dart';
import '../data/providers/local/preferences_provider.dart';
import '../data/providers/remote/acoount_provider.dart';
import '../data/providers/remote/authentication_provider.dart';
import '../data/providers/remote/food_menu_provider.dart';
import '../data/providers/remote/websocket_provider.dart';
import '../data/repositories/account_repository.dart';
import '../data/repositories/authentication_repository.dart';
import '../data/repositories/food_menu_repository.dart';
import '../data/repositories/preferences_repository.dart';
import '../data/repositories/websocket_repository.dart';
import '../data/repositories_implements/account_repository _impl.dart';
import '../data/repositories_implements/authentication_repository_impl.dart';
import '../data/repositories_implements/food_menu_repository_impl.dart';
import '../data/repositories_implements/preferences_repository_impl.dart';
import '../data/repositories_implements/websocket_repository_impl.dart';
import 'get.dart';

typedef VoidCallback = void Function();

abstract class DependencyInjections {
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final preferencesProvider = PreferencesProvider(prefs);
    final authenticationClient = AuthenticationClient(prefs);

    final authenticationRepository = AuthenticationRepositoryImpl(
      AuthenticationProvider(),
      AuthenticationClient(prefs),
    );

    final foodMenuRepository = FoodMenuRepositoryImpl(
      FoodMenuProvider(),
    );

    final preferencesRepository =
        PreferencesRepositoryImpl(preferencesProvider);

    final accountRepository = AccountRepositoryImpl(
      AccountProvider(authenticationClient),
    );

    // final wsProvider = WebsocketProvider();
    // final websocketRepository = WebsocketRepositoryImpl(
    //   wsProvider,
    // );

    Get.i.put<AuthenticationRepository>(authenticationRepository);
    Get.i.put<PreferencesRepository>(preferencesRepository);
    //Get.i.put<WebsocketRepository>(websocketRepository);
    Get.i.put<FoodMenuRepository>(foodMenuRepository);
    Get.i.put<AccountRepository>(accountRepository);
    Get.i.put<bool>(false, tag: 'after-splash');
    Get.i.put<String>("API_KEY", tag: "apiKey");
    Get.i.put<String>("SECRET", tag: "secret");

    Get.i.lazyPut<WebsocketRepository>(() {
      final wsProvider = WebsocketProvider();
      final websocketRepository = WebsocketRepositoryImpl(
        wsProvider,
      );

      return websocketRepository;
    });

    // ignore: prefer_function_declarations_over_variables
    final VoidCallback dispose = () {
      // wsProvider.dispose();
    };

    Get.i.put<VoidCallback>(dispose, tag: 'dispose');
  }

  static void dispose() {
    final dispose = Get.i.find<VoidCallback>(tag: 'dispose');
    dispose();
  }
}

// abstract class DependencyInjections {
//   static void initialize() {
//     final AuthenticationRepository autRep = AuthenticationRepositoryImpl(
//       AuthenticationProvider(),
//     );
//     final foodMenuRepository = FoodMenuRepositoryImpl(
//       FoodMenuProvider(),
//     );
//     final websocketRepository = WebsocketRepositoryImpl(
//       WebsocketProvider(),
//     );
//     Get.i.put<String>("----------");
//     Get.i.put<String>("xxxxxxxxxx");
//     Get.i.put<AuthenticationRepository>(autRep);
//     Get.i.put<FoodMenuRepository>(foodMenuRepository);
//     Get.i.put<WebsocketRepository>(websocketRepository);
//   }
// }
