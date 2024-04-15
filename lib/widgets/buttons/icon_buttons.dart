import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';

class LargeIconButton extends StatelessWidget {
  const LargeIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.title,
      this.selected = false});

  final VoidCallback? onPressed;
  final Widget icon;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        key: key,
        onPressed: onPressed,
        child: Column(children: [
          icon,
          Text(title,
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
        ]),
        style: selected
            ? OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: normal_100),
                side: BorderSide(
                    width: tiny_50, color: Theme.of(context).primaryColor),
                elevation: 0,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.2))
            : OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: normal_100)));
  }
}

class NormalIconButton extends OutlinedButton {
  NormalIconButton(
      {Key? key, required VoidCallback? onPressed, required Widget icon})
      : super(
            key: key,
            onPressed: onPressed,
            child: icon,
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: normal_100)));
}

class SmallIconButton extends OutlinedButton {
  SmallIconButton(
      {Key? key, required VoidCallback? onPressed, required Widget icon})
      : super(
            key: key,
            onPressed: onPressed,
            child: icon,
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(large_125, large_125)));
}

class TimeButton extends OutlinedButton {
  TimeButton({Key? key, required VoidCallback? onPressed, required Widget text})
      : super(
            key: key,
            onPressed: onPressed,
            child: text,
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: normal_100)));
}
