// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../data/repositories/preferences_repository.dart';
import '../../../helpers/get.dart';
import '../../../routes/routes.dart';
// import '../../../utils/colors.dart';
import '../../../utils/app/app_utils.dart';
import '../../../utils/font_styles.dart';
import '../../global_widgets/circle_button.dart';
import '../../global_widgets/rounded_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  Future<void> _setReady() {
    return Get.i.find<PreferencesRepository>().setOnboardAndWelcomeReady(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppUtils.isHtml
                      ? Image.network(
                          "assets/svg/special_event.svg",
                          width: 44 * 8,
                        )
                      : SvgPicture.asset(
                          "assets/svg/special_event.svg",
                          width: 44 * 8,
                        ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Welcome",
                          style: MyFontStyles.title.copyWith(fontSize: 40),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Flexible(
                        child: Text(
                          "Es un hecho establecido hace demasiado "
                          "tiempo que un lector se distraerá con el "
                          "contenido del texto de un sitio mientras "
                          "que mira su diseño.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: RoundedButton(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20).copyWith(
                          top: 6,
                          bottom: 8,
                        ),
                        label: "Login",
                        fullWidth: false,
                        // ignore: duplicate_ignore
                        onPressed: () async {
                          await _setReady();
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                      ),
                    ),
                    Flexible(
                      child: RoundedButton(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20).copyWith(
                          top: 6,
                          bottom: 8,
                        ),
                        label: "Sign Up",
                        fullWidth: false,
                        onPressed: () async {
                          await _setReady();
                          Navigator.pushNamed(context, Routes.register);
                        },
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Or via social media",
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleButton(
                          onPressed: () {},
                          iconPath: "assets/svg/google_2.svg",
                          // backgroundColor: Colors.black,
                          // iconColor: primaryColor,
                          size: 44,
                        ),
                        const SizedBox(width: 10),
                        CircleButton(
                          onPressed: () {},
                          iconPath: "assets/svg/facebook_4.svg",
                        ),
                        const SizedBox(width: 14),
                        CircleButton(
                          onPressed: () {},
                          iconPath: "assets/svg/instagram_2.svg",
                          size: 40,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
