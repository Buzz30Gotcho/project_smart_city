import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/authentication/authentication.dart';
import 'package:proximity_commercant/domain/authentication/src/reset_password_validation.dart';

class RecoveryCodeScreen extends StatelessWidget {
  var email;
  RecoveryCodeScreen({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordRecoveryValidation =
        Provider.of<ResetPasswordValidation>(context);

    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: normal_100),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                            top: normal_200, bottom: normal_100),
                        child: SmallIconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(ProximityIcons.chevron_left)),
                      ),
                      Text('We sent you an email!',
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center),
                      Text(
                          "Enter Recovery Code code sent to your email address " +
                              passwordRecoveryValidation.email.value!,
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center),
                      const SizedBox(height: normal_100),
                      OTPTextField(
                        onChanged:
                            passwordRecoveryValidation.changeRecoveryCode,
                      ),
                      const SizedBox(height: normal_200),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Recovery Code not received? ',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            TextSpan(
                              text: 'Resend.',
                              style: Theme.of(context).textTheme.bodyText1,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  /// Display Toast Message
                                  ToastSnackbar()
                                      .init(context)
                                      .showToast(message: "Code Resent!");
                                },
                            ),
                          ])),
                      const SizedBox(height: normal_200),
                      PrimaryButton(
                        title: 'Submit',
                        onPressed: () {
                          passwordRecoveryValidation
                              .verifyRecoveryCode(context);
                        },
                        buttonState: passwordRecoveryValidation.loading
                            ? ButtonState.loading
                            : passwordRecoveryValidation.isValid
                                ? ButtonState.enabled
                                : ButtonState.disabled,
                      )
                    ]))));
  }
}
