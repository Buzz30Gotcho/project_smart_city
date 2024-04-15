import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';

import 'package:proximity/widgets/forms/phone_textfield.dart';
import 'package:proximity_commercant/domain/authentication/authentication.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/authentication_pages.dart';
import 'package:proximity_commercant/ui/pages/home_pages/home_pages.dart';

class SignUpPhoneScreen extends StatefulWidget {
  const SignUpPhoneScreen({Key? key}) : super(key: key);

  @override
  State<SignUpPhoneScreen> createState() => _SignUpPhoneScreenState();
}

class _SignUpPhoneScreenState extends State<SignUpPhoneScreen> {
  String? _passwordStrength;
  bool isTyping = false;

  Color _getProgressColor(double percentage) {
    if (percentage > 0.0 && percentage < 0.25) {
      _passwordStrength = "Very weak";
      return redSwatch.shade500;
    } else if (percentage >= 0.25 && percentage < 0.5) {
      _passwordStrength = "Weak";
      return Colors.orange.shade500;
    } else if (percentage >= 0.5 && percentage < 0.75) {
      _passwordStrength = "Medium";
      return Colors.yellow.shade500;
    } else if (percentage >= 0.75 && percentage <= 1.0) {
      _passwordStrength = "Strong";
      return greenSwatch.shade500;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupValidation = Provider.of<SignupValidation>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Spacer(),
              //  const SizedBox(height: normal_100),
              Image.asset(
                'assets/proximity-logo-light.png',
                width: 100,
                height: 100,
              ),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Sign Up',
                            style: Theme.of(context).textTheme.displaySmall,
                            maxLines: 1,
                            overflow: TextOverflow
                                .ellipsis), /*
                    const Text('fields with * are mandatory',
                        style: TextStyle(fontSize: 10)),
                    const Text(
                        'you must at least one enter the email or the phone',
                        style: TextStyle(fontSize: 10))*/
                      ])),
              const SizedBox(height: small_100),

              /// Signup Forms
              EditText(
                hintText: 'User name(Required)',
                prefixIcon: ProximityIcons.user,
                errorText: signupValidation.userName.error,
                onChanged: (value) => signupValidation.changeUserName(value),
                enabled: !signupValidation.loading,
              ),
              const SizedBox(height: small_100),

              EditPhoneNumber(
                hintText: "Phone number(Required)",
                prefixIcon: ProximityIcons.phone,
                errorText: signupValidation.phone.error,
                // onChanged: (value) => signupValidation.changePhone(),
                enabled: !signupValidation.loading,
                onChanged: ((value) => signupValidation.changePhone(value)),
                keyboardType: TextInputType.number,
              ),

              const EditTextSpacer(),
              EditText(
                hintText: "Password(Required)",
                prefixIcon: ProximityIcons.password,
                suffixIcon: signupValidation.password_visibility
                    ? ProximityIcons.eye_off
                    : ProximityIcons.eye_on,
                suffixOnPressed: () =>
                    signupValidation.changePasswordVisibility(),
                obscureText: !signupValidation.password_visibility,
                errorText: signupValidation.password.error,
                onChanged: (value) {
                  signupValidation.changePassword(value);
                  setState(() {
                    isTyping = value.isNotEmpty;
                    print(isTyping); // Update the isTyping variable
                  });
                },
                enabled: !signupValidation.loading,
                borderType: BorderType.middle,
              ),
              const EditTextSpacer(),
              signupValidation.passwordPercentage != null
                  ? isTyping
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: normal_100),
                          child: LinearProgressIndicator(
                            value: signupValidation.passwordPercentage,
                            backgroundColor: Colors.grey[200],
                            color: _getProgressColor(
                                signupValidation.passwordPercentage!),
                          ),
                        )
                      : Container()
                  : Container(),

              const EditTextSpacer(),
              EditText(
                hintText: "Password Confirmation(Required)",
                prefixIcon: ProximityIcons.password,
                suffixIcon: signupValidation.passwordConfirm_visibility
                    ? ProximityIcons.eye_off
                    : ProximityIcons.eye_on,
                suffixOnPressed: () =>
                    signupValidation.changePasswordConfirmVisibility(),
                obscureText: !signupValidation.passwordConfirm_visibility,
                errorText: signupValidation.passwordConfirm.error,
                onChanged: (value) => signupValidation.verifyPassword(value),
                enabled: !signupValidation.loading,
                borderType: BorderType.middle,
              ),

              /// Error Messages
              const EditTextSpacer(),
              EditText(
                hintText: "Email(optional)",
                prefixIcon: ProximityIcons.email,
                errorText: signupValidation.email.error,
                onChanged: (value) => signupValidation.changeEmail(value),
                enabled: !signupValidation.loading,
              ),

              TermsAndConditions(
                  value: signupValidation.termsAgreement,
                  onChanged: () => signupValidation.agreeToTerms()),

              /// Signup Button
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: PrimaryButton(
                      onPressed: () => signupValidation.signup(context),
                      buttonState: signupValidation.loading
                          ? ButtonState.loading
                          : signupValidation.signUpPhoneisValid
                              ? ButtonState.enabled
                              : ButtonState.disabled,
                      title: 'Sign Up.')),

              const Spacer(),
              InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen())),
                  child: Padding(
                      padding: const EdgeInsets.all(normal_100),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Already have an account?  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: normal_100)),
                            TextSpan(
                                text: 'Log In.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: normal_100))
                          ])))),
              Spacer(),
            ])));
  }
}
