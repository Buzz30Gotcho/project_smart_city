import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/icons/proximity_icons.dart';
import 'package:proximity/widgets/buttons/icon_buttons.dart';
import 'package:proximity/widgets/buttons/primary_button.dart';
import 'package:proximity_commercant/domain/authentication/authentication.dart';

class TermsAndAgreementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signupValidation = Provider.of<SignupValidation>(context);
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
                    Text('Terms & Conditions. ',
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Welcome to our app!",
                                style: Theme.of(context).textTheme.headline5),
                            SizedBox(height: 16.0),
                            Text(
                                "By using our app, you agree to the following terms and conditions:"),
                            SizedBox(height: 8.0),
                            Text(
                                "1. You must be at least 13 years old to use this app."),
                            Text(
                                "2. You are responsible for any content you post using our app."),
                            Text(
                                "3. We reserve the right to remove any content that violates our terms and conditions."),
                            Text(
                                "4. We may update these terms and conditions from time to time without notice to you."),
                            SizedBox(height: 16.0),
                            Text(
                                "By clicking 'Agree' below, you agree to these terms and conditions."),
                            SizedBox(height: large_150),
                            Padding(
                              padding: const EdgeInsets.all(normal_100),
                              child: PrimaryButton(
                                  onPressed: () {
                                    signupValidation.agreeToTerms();

                                    Navigator.pop(context);
                                  },
                                  title: "Agree"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}
