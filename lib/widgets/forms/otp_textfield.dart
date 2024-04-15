import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proximity/config/config.dart';

class OTPTextField extends StatefulWidget {
  /// TextField Controller
  final OtpFieldController? controller;

  /// Number of the OTP Fields
  final int length;

  /// content padding of the text fields
  final EdgeInsets contentPadding;

  /// Manage the type of keyboard that shows up
  final TextInputType keyboardType;

  /// show the error border or not
  final bool hasError;

  final TextCapitalization textCapitalization;

  /// Text Field Alignment
  /// default: MainAxisAlignment.spaceBetween [MainAxisAlignment]
  final MainAxisAlignment textFieldAlignment;

  /// Obscure Text if data is sensitive
  final bool obscureText;

  /// Whether the [InputDecorator.child] is part of a dense form (i.e., uses less vertical
  /// space).
  final bool isDense;

  /// Callback function, called when a change is detected to the pin.
  final ValueChanged<String>? onChanged;

  /// Callback function, called when pin is completed.
  final ValueChanged<String>? onCompleted;

  final List<TextInputFormatter>? inputFormatter;

  const OTPTextField({
    Key? key,
    this.length = 4,
    this.controller,
    this.hasError = false,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.textFieldAlignment = MainAxisAlignment.spaceBetween,
    this.obscureText = false,
    this.onChanged,
    this.inputFormatter,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    this.isDense = false,
    this.onCompleted,
  })  : assert(length > 1),
        super(key: key);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  late List<String> _pin;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      widget.controller!.setOtpTextFieldState(this);
    }

    _focusNodes = List<FocusNode?>.filled(widget.length, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.length, null,
        growable: false);

    _pin = List.generate(widget.length, (int i) {
      return '';
    });
  }

  @override
  void dispose() {
    for (var controller in _textControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: large_150,
        height: large_150,
        child: Row(
            mainAxisAlignment: widget.textFieldAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              return buildTextField(context, index);
            })));
  }

  /// This function Build and returns individual TextField item.
  ///
  /// * Requires a build context
  /// * Requires Int position of the field
  Widget buildTextField(BuildContext context, int index) {
    if (_focusNodes[index] == null) _focusNodes[index] = FocusNode();

    if (_textControllers[index] == null) {
      _textControllers[index] = TextEditingController();
    }
    final isLast = index == widget.length - 1;

    InputBorder _getBorder(Color color) {
      final colorOrError =
          widget.hasError ? Theme.of(context).errorColor : color;

      return OutlineInputBorder(
        borderSide: BorderSide(color: colorOrError, width: tiny_50),
        borderRadius: const BorderRadius.all(smallRadius),
      );
    }

    return SizedBox(
      width: large_150,
      height: large_150,
      child: TextField(
        controller: _textControllers[index],
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
        inputFormatters: widget.inputFormatter,
        maxLength: 1,
        focusNode: _focusNodes[index],
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          isDense: widget.isDense,
          filled: true,
          fillColor: Theme.of(context).cardColor,
          counterText: "",
          contentPadding: widget.contentPadding,
          border: _getBorder(Theme.of(context).dividerColor),
          focusedBorder: _getBorder(Theme.of(context).primaryColor),
          enabledBorder: _getBorder(Theme.of(context).dividerColor),
          disabledBorder: _getBorder(Theme.of(context).disabledColor),
          errorBorder: _getBorder(Theme.of(context).errorColor),
          focusedErrorBorder: _getBorder(Theme.of(context).errorColor),
          errorText: null,
          // to hide the error text
          errorStyle: const TextStyle(height: 0, fontSize: 0),
        ),
        onChanged: (String str) {
          if (str.length > 1) {
            _handlePaste(str);
            return;
          }

          // Check if the current value at this position is empty
          // If it is move focus to previous text field.
          if (str.isEmpty) {
            if (index == 0) return;
            _focusNodes[index]!.unfocus();
            _focusNodes[index - 1]!.requestFocus();
          }

          // Update the current pin
          setState(() {
            _pin[index] = str;
          });

          // Remove focus
          if (str.isNotEmpty) _focusNodes[index]!.unfocus();
          // Set focus to the next field if available
          if (index + 1 != widget.length && str.isNotEmpty) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }

          String currentPin = _getCurrentPin();

          // if there are no null values that means otp is completed
          // Call the `onCompleted` callback function provided
          if (!_pin.contains(null) &&
              !_pin.contains('') &&
              currentPin.length == widget.length) {
            widget.onCompleted?.call(currentPin);
          }

          // Call the `onChanged` callback function
          widget.onChanged!(currentPin);
        },
      ),
    );
  }

  String _getCurrentPin() {
    String currentPin = "";
    _pin.forEach((String value) {
      currentPin += value;
    });
    return currentPin;
  }

  void _handlePaste(String str) {
    if (str.length > widget.length) {
      str = str.substring(0, widget.length);
    }

    for (int i = 0; i < str.length; i++) {
      String digit = str.substring(i, i + 1);
      _textControllers[i]!.text = digit;
      _pin[i] = digit;
    }

    FocusScope.of(context).requestFocus(_focusNodes[widget.length - 1]);

    String currentPin = _getCurrentPin();

    // if there are no null values that means otp is completed
    // Call the `onCompleted` callback function provided
    if (!_pin.contains(null) &&
        !_pin.contains('') &&
        currentPin.length == widget.length) {
      widget.onCompleted?.call(currentPin);
    }

    // Call the `onChanged` callback function
    widget.onChanged!(currentPin);
  }
}

class OtpFieldController {
  late _OTPTextFieldState _otpTextFieldState;

  void setOtpTextFieldState(_OTPTextFieldState state) {
    _otpTextFieldState = state;
  }

  void clear() {
    final textFieldLength = _otpTextFieldState.widget.length;
    _otpTextFieldState._pin = List.generate(textFieldLength, (int i) {
      return '';
    });

    final textControllers = _otpTextFieldState._textControllers;
    textControllers.forEach((textController) {
      if (textController != null) {
        textController.text = '';
      }
    });

    final firstFocusNode = _otpTextFieldState._focusNodes[0];
    if (firstFocusNode != null) {
      firstFocusNode.requestFocus();
    }
  }

  void set(List<String> pin) {
    final textFieldLength = _otpTextFieldState.widget.length;
    if (pin.length < textFieldLength) {
      throw Exception(
          "Pin length must be same as field length. Expected: $textFieldLength, Found ${pin.length}");
    }

    _otpTextFieldState._pin = pin;
    String newPin = '';

    final textControllers = _otpTextFieldState._textControllers;
    for (int i = 0; i < textControllers.length; i++) {
      final textController = textControllers[i];
      final pinValue = pin[i];
      newPin += pinValue;

      if (textController != null) {
        textController.text = pinValue;
      }
    }

    final widget = _otpTextFieldState.widget;

    widget.onChanged?.call(newPin);

    widget.onCompleted?.call(newPin);
  }

  void setValue(String value, int position) {
    final maxIndex = _otpTextFieldState.widget.length - 1;
    if (position > maxIndex) {
      throw Exception(
          "Provided position is out of bounds for the OtpTextField");
    }

    final textControllers = _otpTextFieldState._textControllers;
    final textController = textControllers[position];
    final currentPin = _otpTextFieldState._pin;

    if (textController != null) {
      textController.text = value;
      currentPin[position] = value;
    }

    String newPin = "";
    currentPin.forEach((item) {
      newPin += item;
    });

    final widget = _otpTextFieldState.widget;
    if (widget.onChanged != null) {
      widget.onChanged!(newPin);
    }
  }

  void setFocus(int position) {
    final maxIndex = _otpTextFieldState.widget.length - 1;
    if (position > maxIndex) {
      throw Exception(
          "Provided position is out of bounds for the OtpTextField");
    }

    final focusNodes = _otpTextFieldState._focusNodes;
    final focusNode = focusNodes[position];

    if (focusNode != null) {
      focusNode.requestFocus();
    }
  }
}
