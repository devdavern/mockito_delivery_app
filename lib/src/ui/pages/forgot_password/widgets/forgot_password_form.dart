import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/dialogs.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';
import '../forgot_passwprd_controller.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  void _submit(BuildContext context) async {
    final controller = context.read<ForgotPasswordController>();
    ProgressDialog.show(context);
    final sent = await controller.submit();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    if (sent) {
      // ignore: use_build_context_synchronously
      await Dialogs.alert(
        context,
        title: "GOOD",
        dismissible: false,
        description: "We have sent an email ${controller.email}",
        okText: 'Go To Login',
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      // ignore: use_build_context_synchronously
      Dialogs.alert(
        context,
        title: "ERROR",
        key: const Key('Invalid Email'),
        description: "${controller.email} not found, please rewrite the Email",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ForgotPasswordController>();
    return Flexible(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 333),
        child: Column(
          children: [
            InputText(
              label: "E-mail",
              textInputAction: TextInputAction.send,
              onSubmitted: (text) => _submit(context),
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
              validator: (text) {
                return (text.contains("@") && text.endsWith(".com"))
                    ? null
                    : 'Invalid E-mail';
              },
              onChanged: controller.onEmailChanged,
            ),
            const SizedBox(height: 22),
            Flexible(
              child: Align(
                alignment: Alignment.centerRight,
                child: RoundedButton(
                  fullWidth: false,
                  label: "Recover",
                  padding: const EdgeInsets.symmetric(horizontal: 33).copyWith(
                    top: 6,
                    bottom: 6,
                  ),
                  onPressed: () {
                    _submit(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
