import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';

import 'package:proximity/widgets/forms/phone_textfield.dart';
import 'package:proximity_client/domain/authentication/src/signup_validation.dart';
import 'package:proximity_client/ui/pages/authentication_pages/view/login_screen.dart';
import 'package:proximity_client/ui/pages/authentication_pages/widgets/terms_and_conditions.dart';
import 'package:proximity_client/ui/pages/main_pages/view/main_screen.dart';
import 'package:proximity_client/domain/authentication/src/googleSigninApi.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signupValidation = Provider.of<SignupValidation>(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: ListView(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: Column(children: [
                    Text('Sign Up.',
                        style: Theme.of(context).textTheme.displayMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const Text('fields with * are mandatory',
                        style: TextStyle(fontSize: 10)),
                    const Text('you must at least one enter the email or the phone',
                        style: TextStyle(fontSize: 10))
                  ])),
              const SizedBox(height: small_100),

              /// Signup Forms
              EditText(
                hintText: 'User name*',
                prefixIcon: ProximityIcons.user,
                errorText: signupValidation.userName.error,
                onChanged: (value) => signupValidation.changeUserName(value),
                enabled: !signupValidation.loading,
              ),
              const SizedBox(height: small_100),
              EditText(
                // hintText: "Email.",
                hintText: localizations!.email,
                prefixIcon: ProximityIcons.email,
                errorText: signupValidation.email.error,
                onChanged: (value) => signupValidation.changeEmail(value),
                enabled: !signupValidation.loading,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: normal_200),
                child: GestureDetector(
                  onTap: () => signupValidation.openAddEmailDialog(context),
                  child: Text("why add an email ? ",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor:
                              Theme.of(context).textTheme.titleLarge!.color)),
                ),
              ),
              const SizedBox(height: small_100),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: normal_100),
                child: EditPhoneNumber(
                  hintText: "Phone number.",
                  prefixIcon: ProximityIcons.phone,
                  errorText: signupValidation.phone.error,
                  // onChanged: (value) => signupValidation.changePhone(),
                  enabled: !signupValidation.loading,
                  onChanged: ((value) => signupValidation.changePhone(value)),
                  keyboardType: TextInputType.number,
                ),
              ),
              const EditTextSpacer(),
              EditText(
                hintText: "Password*",
                prefixIcon: ProximityIcons.password,
                suffixIcon: signupValidation.password_visibility
                    ? ProximityIcons.eye_off
                    : ProximityIcons.eye_on,
                suffixOnPressed: () =>
                    signupValidation.changePasswordVisibility(),
                obscureText: !signupValidation.password_visibility,
                errorText: signupValidation.password.error,
                onChanged: (value) => signupValidation.changePassword(value),
                enabled: !signupValidation.loading,
                borderType: BorderType.middle,
              ),
              const EditTextSpacer(),
              EditText(
                hintText: "Password Confirmation*",
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
              const ErrorMessage(errors: [
                //signupValidation.email.error,
                // signupValidation.password.error
              ]),
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
                          : signupValidation.isValid
                              ? ButtonState.enabled
                              : ButtonState.disabled,
                      title: 'Sign Up.')),
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                height: tiny_50,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Theme.of(context)
                                          .dividerColor
                                          .withOpacity(0.0),
                                      Theme.of(context).dividerColor,
                                    ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)))),
                        const SizedBox(width: normal_100),
                        const Text("Or Connect With",
                            textAlign: TextAlign.center),
                        const SizedBox(width: normal_100),
                        Expanded(
                            child: Container(
                                height: tiny_50,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Theme.of(context)
                                          .dividerColor
                                          .withOpacity(0.0),
                                      Theme.of(context).dividerColor,
                                    ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft))))
                      ])),
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                        child: NormalIconButton(
                            onPressed: () async {
                              try {
                                await GoogleSignInApi.logout();
                              } catch (e) {
                                print(e.toString());
                              }
                              signupValidation.signUpGoogle(context);
                            },
                            icon: Image.asset('assets/img/google.png',
                                width: normal_200, height: normal_200))),
                    const SizedBox(width: normal_200),
                    Expanded(
                        child: NormalIconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen())),
                            icon: Image.asset('assets/img/facebook.png',
                                width: normal_200, height: normal_200))),
                    const SizedBox(width: normal_200),
                    Expanded(
                        child: NormalIconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen())),
                            icon: Image.asset('assets/img/twitter.png',
                                width: normal_200, height: normal_200)))
                  ])),
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
                          ]))))
            ])));
  }
}
