import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';

import 'package:proximity/widgets/forms/phone_textfield.dart';
import 'package:proximity_commercant/domain/authentication/authentication.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/authentication_pages.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/view/signUp_phone_screen.dart';
import 'package:proximity_commercant/ui/pages/home_pages/home_pages.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
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

              const SizedBox(height: small_100),
              EditText(
                hintText: "Email",
                prefixIcon: ProximityIcons.email,
                errorText: signupValidation.email.error,
                onChanged: (value) => signupValidation.changeEmail(value),
                enabled: !signupValidation.loading,
              ),

              /// Signup Button
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: PrimaryButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupEmailScreen())),
                      buttonState: signupValidation.loading
                          ? ButtonState.loading
                          : signupValidation.emailIsValid
                              ? ButtonState.enabled
                              : ButtonState.disabled,
                      title: 'Next.')),
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: SecondaryButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPhoneScreen())),
                      title: 'Sign up with Phone.')),
              const Spacer(),
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
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen())),
                            icon: Image.asset('assets/img/google.png',
                                width: normal_200, height: normal_200))),
                    const SizedBox(width: normal_200),
                    Expanded(
                        child: NormalIconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen())),
                            icon: Image.asset('assets/img/facebook.png',
                                width: normal_200, height: normal_200))),
                    const SizedBox(width: normal_200),
                    Expanded(
                        child: NormalIconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen())),
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
                          ])))),
              Spacer()
            ])));
  }
}
