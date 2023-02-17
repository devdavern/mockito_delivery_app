import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/get.dart';
import '../login_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/dialogs.dart';
import '../../../../data/models/user.dart';
import '../../../../utils/font_styles.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  void _submit(BuildContext context) async {
    final controller = context.read<LoginController>();
    ProgressDialog.show(context);

    final User? user = await controller.submit();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    if (user == null) {
      // ignore: use_build_context_synchronously
      Dialogs.alert(
        context,
        title: 'ERROR',
        description: 'Invalid Email or Password, please confirm',
      );
    } else {
      Get.i.put<User>(user);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Flexible(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Column(
                children: [
                  InputText(
                    label: "E-mail",
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (text) {
                      return (text.contains("@") && text.endsWith(".com"))
                          ? null
                          : 'Invalid E-mail';
                    },
                    onChanged: controller.onEmailChanged,
                  ),
                  InputText(
                    label: "Password",
                    obscureText: true,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (text) => _submit(context),
                    onChanged: controller.onPasswordChanged,
                    prefixIcon: const Icon(Icons.lock_open_outlined),
                    validator: (text) {
                      return (text.trim().length > 3)
                          ? null
                          : 'Invalid Password';
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoButton(
                      child: Text(
                        "Forgot your password",
                        style: MyFontStyles.subtitleColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.forgotPassword);
                      },
                    ),
                  ),
                ],
              ),
            ),
            RoundedButton(
              label: "Login",
              fullWidth: false,
              padding: const EdgeInsets.symmetric(horizontal: 50).copyWith(
                top: 8,
                bottom: 8,
              ),
              onPressed: () {
                _submit(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
