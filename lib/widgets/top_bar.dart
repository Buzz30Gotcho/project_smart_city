import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(normal_100).copyWith(top: normal_200),
        child: Row(children: [
          SmallIconButton(
              onPressed: () {
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
              icon: const Icon(ProximityIcons.chevron_left)),
          const SizedBox(width: normal_100),
          Expanded(
              child: Text(title,
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis))
        ]));
  }
}
