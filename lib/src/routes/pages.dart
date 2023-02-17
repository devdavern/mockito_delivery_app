import 'package:flutter/material.dart';

import '../ui/global_widgets/is_auth.dart';
import '../ui/pages/dish/dish_page.dart';
import '../ui/pages/forgot_password/forgot_password_page.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/login/login_page.dart';
import '../ui/pages/my_cart/my_cart_page.dart';
import '../ui/pages/onboard/onboard_page.dart';
import '../ui/pages/register/register_page.dart';
import '../ui/pages/splash/splash_page.dart';
import '../ui/pages/welcome/welcome_page.dart';
import 'routes.dart';

abstract class Pages {
  static const String initial = Routes.onboard;

  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.login: (_) => const LoginPage(),
    Routes.splash: (_) => const SplashPage(),
    Routes.onboard: (_) => const OnboardPage(),
    Routes.welcome: (_) => const WelcomePage(),
    Routes.register: (_) => const RegisterPage(),
    Routes.home: (_) => IsAuth(page: const HomePage()),
    Routes.dish: (_) => IsAuth(page: const DishPage()),
    Routes.myCart: (_) => IsAuth(page: const MyCartPage()),
    Routes.forgotPassword: (_) => const ForgotPasswordPage(),
  };
}
