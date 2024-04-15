import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(normalRadius),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: normal_200, sigmaX: normal_200),
            child: Container(
                decoration: BoxDecoration(
                    color: (Theme.of(context).brightness == Brightness.dark)
                        ? Theme.of(context).cardColor
                        : Theme.of(context).backgroundColor.withOpacity(0.8),
                    borderRadius: const BorderRadius.all(normalRadius),
                    border: Border.all(
                        width: tiny_50, color: Theme.of(context).cardColor)),
                child: child)));
  }
}
