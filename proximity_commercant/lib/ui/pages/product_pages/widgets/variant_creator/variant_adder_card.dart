import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class VariantAdderCard extends CardButton {
  VariantAdderCard(BuildContext context, {Key? key, GestureTapCallback? onPressed})
      : super(
      key: key,
      onPressed: onPressed,
      margin: EdgeInsets.zero,
      child: SizedBox(
          width: (MediaQuery
              .of(context)
              .size
              .width - normal_100 * 4) / 3,
          height: (MediaQuery
              .of(context)
              .size
              .width - normal_100 * 4) / 3,
          child: const Icon(ProximityIcons.add)
      ));
}