import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/icons/proximity_icons.dart';
import 'package:proximity/widgets/buttons/primary_button.dart';
import 'package:proximity/widgets/forms/border_type.dart';
import 'package:proximity/widgets/forms/edit_text.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';
import 'package:proximity/widgets/forms/info_message.dart';
import 'package:proximity/widgets/top_bar.dart';
import 'package:proximity_commercant/domain/authentication/src/reset_password_validation.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordRecoveryValidation =
        Provider.of<ResetPasswordValidation>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
              const TopBar(title: 'Reset Password.'),
              const SizedBox(height: normal_100),
              const EditTextSpacer(),
              EditText(
                hintText: "Password.",
                prefixIcon: ProximityIcons.password,
                suffixIcon: passwordRecoveryValidation.password_visibility
                    ? ProximityIcons.eye_off
                    : ProximityIcons.eye_on,
                suffixOnPressed: () =>
                    passwordRecoveryValidation.changePasswordVisibility(),
                obscureText: !passwordRecoveryValidation.password_visibility,
                errorText: passwordRecoveryValidation.password.error,
                onChanged: (value) =>
                    passwordRecoveryValidation.changePassword(value),
                enabled: !passwordRecoveryValidation.loading,
                borderType: BorderType.middle,
              ),
              const EditTextSpacer(),
              EditText(
                hintText: "Password.",
                prefixIcon: ProximityIcons.password,
                suffixIcon:
                    passwordRecoveryValidation.passwordConfirm_visibility
                        ? ProximityIcons.eye_off
                        : ProximityIcons.eye_on,
                suffixOnPressed: () => passwordRecoveryValidation
                    .changePasswordConfirmVisibility(),
                obscureText:
                    !passwordRecoveryValidation.passwordConfirm_visibility,
                errorText: passwordRecoveryValidation.passwordConfirm.error,
                onChanged: (value) =>
                    passwordRecoveryValidation.verifyPassword(value),
                enabled: !passwordRecoveryValidation.loading,
                borderType: BorderType.middle,
              ),
              const InfoMessage(message: '.'),
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: PrimaryButton(
                    onPressed: () {
                      passwordRecoveryValidation.modifyPassword(context);
                    },
                    title: "Sumbit.",
                  )),
              const Spacer(),
            ])));
  }
}
