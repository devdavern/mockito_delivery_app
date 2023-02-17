import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global_widgets/circle_button.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Or via social media",
          style: MyFontStyles.subSubtitle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleButton(
              onPressed: () {},
              iconPath: "assets/svg/google_2.svg",
              backgroundColor: Colors.black,
              iconColor: primaryColor,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text("Dont have an account?"),
                CupertinoButton(
                  child: Text(
                    "Sing Up",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.register);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
