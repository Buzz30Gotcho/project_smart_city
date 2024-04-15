import 'package:flutter/material.dart';

import 'button_state.dart';

class SecondaryButton extends OutlinedButton {
  SecondaryButton(
      {Key? key,
      required VoidCallback? onPressed,
      required String title,
      ButtonState? buttonState})
      : super(
            key: key,
            onPressed: (buttonState == ButtonState.disabled) ? null : onPressed,
            child: (buttonState == ButtonState.loading)
                ? const CircularProgressIndicator()
                : Text(title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis));
}
