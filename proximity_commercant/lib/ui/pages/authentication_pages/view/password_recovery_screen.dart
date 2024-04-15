import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/authentication/src/reset_password_validation.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

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
                const TopBar(title: 'Password Recovery.'),
                const SizedBox(height: normal_100),
                EditText(
                    hintText: "Email, Phone Number or Username.",
                    prefixIcon: ProximityIcons.user,
                    // errorText: passwordRecoveryValidation.email.error,
                    onChanged: (value) =>
                        passwordRecoveryValidation.changeEmail(value),
                    enabled: !passwordRecoveryValidation.loading,
                    borderType: BorderType.top),
                const InfoMessage(
                    message:
                        'Enter the email, phone number or username associated with your Proximity account down below.'),
                Padding(
                    padding: const EdgeInsets.all(normal_100),
                    child: PrimaryButton(
                      buttonState: passwordRecoveryValidation.loading
                          ? ButtonState.loading
                          : null,
                      onPressed: () {
                        passwordRecoveryValidation
                            .createResetPasswordRequest(context);
                      },
                      title: "Search.",
                    )),
                const Spacer(),
              ]),
        ));
  }
}
