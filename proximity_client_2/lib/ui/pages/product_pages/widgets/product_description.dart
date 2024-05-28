import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/l10n/app_localizations.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key, required this.description})
      : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SectionDivider(
          leadIcon: ProximityIcons.description,
          title: AppLocalizations.of(context)!.productDescription,
          color: Theme.of(context).primaryColor),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: small_100),
          child: LongText(description))
    ]);
  }
}
