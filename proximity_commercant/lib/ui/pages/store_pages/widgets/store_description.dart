import 'package:flutter/material.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';

class StoreDescription extends StatelessWidget {
  const StoreDescription({Key? key, required this.description})
      : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionDivider(
          leadIcon: ProximityIcons.description,
          title: localizations!.storeDescription,
          color: Theme.of(context).primaryColor),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: small_100),
          child: LongText(description))
    ]);
  }
}
