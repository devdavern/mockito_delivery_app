import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/dialogs.dart';
import '../../../global_widgets/custom_form.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';
import '../register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  void _submit(BuildContext context) async {
    final controller = context.read<RegisterController>();
    final isFormOk = controller.formKey.currentState!.validate();

    if (isFormOk!) {
      ProgressDialog.show(context);
      final isOk = await controller.submit();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      if (!isOk!) {
        // ignore: use_build_context_synchronously
        Dialogs.alert(
          context,
          title: 'ERROR',
          description: 'Register Failed',
        );
      } else {
        // ignore: use_build_context_synchronously
        await Dialogs.alert(
          context,
          title: 'GOOD',
          dismissible: false,
          description: 'Register Successful',
        );
        // ignore: use_build_context_synchronously
        Navigator.popUntil(
            context,
            ((R) =>
                R.settings.name == Routes.welcome ||
                R.settings.name == Routes.login));
      }
    } else {
      Dialogs.alert(
        context,
        title: 'ERROR',
        description: 'Invalid Inputs, please confirm',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();
    return CustomForm(
      key: controller.formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 44 * 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputText(
              label: "Name",
              key: const Key('register-name'),
              onChanged: controller.onNameChanged,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.person_outline),
              validator: (text) {
                return (text.trim().length > 1) ? null : "Invalid Name";
              },
            ),
            InputText(
              label: "Last Name",
              key: const Key('register-lastName'),
              textInputAction: TextInputAction.next,
              onChanged: controller.onLastNameChanged,
              prefixIcon: const Icon(Icons.person_add_alt_1_outlined),
              validator: (text) {
                return (text.trim().length > 1) ? null : "Invalid Last Name";
              },
            ),
            InputText(
              label: "E-mail",
              key: const Key('register-email'),
              onChanged: controller.onEmailChanged,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                return (text.contains("@") && text.endsWith(".com"))
                    ? null
                    : "Invalid E-mail";
              },
            ),
            InputText(
              label: "Password",
              obscureText: true,
              key: const Key('register-password'),
              textInputAction: TextInputAction.send,
              onChanged: controller.onPasswordChanged,
              onSubmitted: (text) => _submit(context),
              prefixIcon: const Icon(Icons.lock_open_outlined),
              validator: (text) {
                return (text.trim().length > 3) ? null : "Invalid Password";
              },
            ),
            const SizedBox(height: 33),
            Align(
              alignment: Alignment.centerRight,
              child: RoundedButton(
                label: "Sing Up",
                fullWidth: false,
                onPressed: () {
                  _submit(context);
                },
                padding: const EdgeInsets.symmetric(horizontal: 44).copyWith(
                  top: 8,
                  bottom: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
