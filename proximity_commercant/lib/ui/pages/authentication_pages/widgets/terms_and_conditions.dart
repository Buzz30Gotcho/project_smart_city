import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/view/terms_conditions_screen.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key, required this.value, this.onChanged})
      : super(key: key);

  final bool value;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(normal_100),
      child: InkWell(
          onTap: onChanged,
          child: Row(children: [
            Icon(value ? ProximityIcons.check_filled : ProximityIcons.check,
                size: normal_125,
                color: value ? Theme.of(context).primaryColor : null),
            const SizedBox(width: small_100),
            Text('I Agree to the ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: normal_100)),
            GestureDetector(
              onTap: (() => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => TermsAndAgreementsScreen()),
                  (Route<dynamic> route) => true)),
              child: Text('Terms & Conditions.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: normal_100)),
            )
          ])),
    );
  }
}
