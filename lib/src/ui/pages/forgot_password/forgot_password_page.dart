import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/app/app_utils.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_styles.dart';
import 'forgot_passwprd_controller.dart';
import 'widgets/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordController>(
        create: (_) => ForgotPasswordController(),
        builder: (_, __) {
          final MediaQueryData data = MediaQuery.of(_);
          final Size size = data.size;
          final padding = data.padding;
          final AppBar appBar = AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              color: primaryColor,
              icon: const Icon(Icons.arrow_back, size: 4 * 8),
              onPressed: () {
                (context);
              },
            ),
          );
          return Scaffold(
            appBar: appBar,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: size.height -
                          padding.top -
                          padding.bottom -
                          (appBar.preferredSize.height),
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "Forgot your password!",
                              style: MyFontStyles.title.copyWith(
                                fontSize: 33,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Fill the details & created your account",
                            style: MyFontStyles.subSubtitle,
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: AppUtils.isHtml
                                ? Image.network(
                                    "assets/svg/mobile_app.svg",
                                    width: 55 * 5,
                                  )
                                : SvgPicture.asset(
                                    "assets/svg/mobile_app.svg",
                                    width: 55 * 5,
                                  ),
                          ),
                          const SizedBox(height: 20),
                          const ForgotPasswordForm(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
