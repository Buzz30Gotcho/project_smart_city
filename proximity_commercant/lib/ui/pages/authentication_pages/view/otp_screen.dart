import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/authentication/authentication.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otpValidation = Provider.of<OTPValidation>(context);
    var credentialsBox = Boxes.getCredentials();
    var email = credentialsBox.get("email");
    var phone = credentialsBox.get("phone ");

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
                      email != null
                          ? Text('We sent you an email!',
                              style: Theme.of(context).textTheme.subtitle1,
                              textAlign: TextAlign.center)
                          : Text('We sent you sms !',
                              style: Theme.of(context).textTheme.subtitle1,
                              textAlign: TextAlign.center),
                      email != null
                          ? Text(
                              'Enter OTP code sent to your email address ' +
                                  email,
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center)
                          : Text(
                              'Enter OTP code sent to your phone number ' +
                                  phone,
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center),
                      const SizedBox(height: normal_100),
                      OTPTextField(
                        onChanged: otpValidation.changeVerificationCode,
                      ),
                      const SizedBox(height: normal_200),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'OTP not received? ',
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
                          otpValidation.verify(context);
                        },
                        buttonState: otpValidation.loading
                            ? ButtonState.loading
                            : otpValidation.isValid
                                ? ButtonState.enabled
                                : ButtonState.disabled,
                      )
                    ]))));
  }
}
