import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/icons/proximity_icons.dart';

class InfoMessage extends StatelessWidget {
  const InfoMessage({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: normal_100, horizontal: normal_200),
      padding: const EdgeInsets.all(normal_100),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(smallRadius)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ProximityIcons.info,
              color: Theme.of(context).textTheme.bodyText2!.color),
          const SizedBox(width: normal_100),
          Expanded(
              child:
                  Text(message, style: Theme.of(context).textTheme.bodyText2))
        ],
      ),
    );
  }
}
