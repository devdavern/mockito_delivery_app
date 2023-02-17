import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/app/app_utils.dart';
import '../../../utils/font_styles.dart';
import 'login_controller.dart';
import 'widgets/login_form.dart';
import 'widgets/social_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
        create: (_) => LoginController(),
        builder: (_, __) {
          final MediaQueryData data = MediaQuery.of(_);
          final Size size = data.size;
          final padding = data.padding;
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    width: double.infinity,
                    height: size.height - padding.top - padding.bottom,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "Welcome Back!",
                                  style:
                                      MyFontStyles.title.copyWith(fontSize: 40),
                                ),
                              ),
                              Expanded(
                                child: AppUtils.isHtml
                                    ? Image.network(
                                        "assets/svg/breakfast.svg",
                                        width: 40 * 8,
                                      )
                                    : SvgPicture.asset(
                                        "assets/svg/breakfast.svg",
                                        width: 40 * 8,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const LoginForm(),
                        const SocialLogin(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
