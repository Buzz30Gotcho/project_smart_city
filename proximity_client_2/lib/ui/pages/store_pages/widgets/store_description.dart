import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class StoreDescription extends StatelessWidget {
  const StoreDescription({Key? key, required this.description})
      : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SectionDivider(
          leadIcon: ProximityIcons.description,
          title: 'Store Description.',
          color: Theme.of(context).primaryColor),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: small_100),
          child:
              LongText(description))
    ]);
  }
}
