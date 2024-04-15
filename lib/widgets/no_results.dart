import 'package:flutter/material.dart';
import 'package:proximity/config/values.dart';

class NoResults extends StatelessWidget {
  const NoResults({Key? key, required this.message, required this.icon})
      : super(key: key);

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: large_200, horizontal: large_100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: huge_200, color: Theme.of(context).dividerColor),
          const SizedBox(height: normal_100),
          Text(message,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center),
          const SizedBox(height: huge_100),
        ],
      ),
    );
  }
}
