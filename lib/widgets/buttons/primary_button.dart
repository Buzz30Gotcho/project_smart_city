import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';

import 'button_state.dart';

class PrimaryButton extends ElevatedButton {
  PrimaryButton(
      {Key? key,
      VoidCallback? onPressed,
      required String title,
      ButtonState? buttonState})
      : super(
            key: key,
            onPressed: (buttonState == ButtonState.disabled) ? null : onPressed,
            child: (buttonState == ButtonState.loading)
                ? CircularProgressIndicator(
                    color: primaryTextDarkColor,
                    backgroundColor: blueSwatch.shade500,
                    strokeWidth: tiny_50,
                  )
                : Text(title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis));
}
