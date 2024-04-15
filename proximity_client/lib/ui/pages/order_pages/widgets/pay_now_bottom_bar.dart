import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class PayNowBottomBar extends StatelessWidget {
  const PayNowBottomBar({Key? key, required this.totalPrice, this.buttonState, this.onPressed})
      : super(key: key);

  final String totalPrice;
  final ButtonState? buttonState;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: normal_100, sigmaY: normal_100),
            child: Container(
                padding: const EdgeInsets.all(normal_100),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background.withOpacity(0.9),
                    border: Border(
                        top: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: tiny_50))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Text(totalPrice,
                              style: Theme.of(context).textTheme.displaySmall)),
                      PrimaryButton(onPressed: onPressed,
                          buttonState: buttonState,
                          title: 'Pay Now.')
                    ]))));
  }
}
