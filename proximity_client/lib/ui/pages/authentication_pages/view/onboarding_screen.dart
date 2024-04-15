import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/authentication/src/login_validation.dart';
import 'package:proximity_client/ui/pages/authentication_pages/view/view.dart';
import 'package:proximity_client/ui/pages/authentication_pages/widgets/widgets.dart';
import 'package:proximity_client/ui/pages/main_pages/view/main_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginValidation = Provider.of<LoginValidation>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: loginValidation.isLogged
            ? const MainScreen()
            : SafeArea(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const OnboardingCarousel(),
                  const Spacer(),
                  Row(
                    children: [
                      const SizedBox(width: normal_100),
                      Expanded(
                          child: SecondaryButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()));
                        },
                        title: 'Sign Up.',
                      )),
                      const SizedBox(width: normal_100),
                      Expanded(
                          child: SecondaryButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        title: 'Log In.',
                      )),
                      const SizedBox(width: normal_100),
                    ],
                  ),
                  const SizedBox(height: normal_200),
                ],
              )));
  }
}
