import 'package:flutter/material.dart';
import 'package:proximity/config/colors.dart';
import 'package:proximity/config/values.dart';

class SlideSelector extends StatelessWidget {
  const SlideSelector(
      {Key? key, required this.title, required this.value, this.onChanged})
      : super(key: key);

  final String title;
  final int value;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(normal_100).copyWith(bottom: 0),
          child: Row(children: [
            Text(title, style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(width: small_100),
            const Expanded(child: Divider(height: tiny_50, thickness: tiny_50)),
            const SizedBox(width: small_100),
            Text('$value Km', style: Theme.of(context).textTheme.subtitle1)
          ]),
        ),

        /// Material Slider
        Slider(
            activeColor: redSwatch.shade400,
            inactiveColor: redSwatch.shade100,
            value: value.toDouble(),
            divisions: MAX_SEARCH_DISTANCE - MIN_SEARCH_DISTANCE,
            onChanged: onChanged,
            max: MAX_SEARCH_DISTANCE.toDouble(),
            min: MIN_SEARCH_DISTANCE.toDouble()),
      ],
    );
  }
}
