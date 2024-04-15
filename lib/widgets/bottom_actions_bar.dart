import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class BottomActionsBar extends StatelessWidget {
  const BottomActionsBar({Key? key, required this.buttons}) : super(key: key);

  final List<ButtonStyleButton> buttons;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: normal_100, sigmaY: normal_100),
            child: Container(
                padding: const EdgeInsets.all(normal_100),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.9),
                    border: Border(
                        top: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: tiny_50))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(buttons.length,
                        (index) => Expanded(child: buttons[index]))))));
  }
}
