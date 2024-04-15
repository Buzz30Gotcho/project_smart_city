import 'package:flutter/material.dart';
import 'package:proximity/config/values.dart';

import 'border_type.dart';

class EditTime extends StatefulWidget {
  const EditTime({
    Key? key,
    this.enabled = false,
    this.saved,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnPressed,
    required this.hintText,
    required this.labelText,
    this.errorText,
    this.keyboardType,
    this.maxLines = 1,
    this.borderType = BorderType.single,
    this.onChanged,
    this.onSaved,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  final bool enabled;
  final String hintText;
  final String labelText;
  final String? saved;
  final String? errorText;
  final ValueChanged<dynamic>? onChanged;
  final ValueChanged<String>? onSaved;
  final ValueChanged<String>? onSubmitted;
  //final ValueChanged<String>? onChanged;
  final ValueChanged<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final BorderType borderType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final GestureTapCallback? suffixOnPressed;
  final bool obscureText;

  @override
  State<EditTime> createState() => _EditTimeState();
}

class _EditTimeState extends State<EditTime> {
  FocusNode? _focus;
  Color? _borderColor, _iconColor;

  /// Notify the text field whenever focus is true,
  /// to change the border color
  void _onFocusChange() {
    if (_focus!.hasFocus == true) {
      setState(() {
        _borderColor = Theme.of(context).primaryColor;
        _iconColor = Theme.of(context).primaryColor;
      });
    } else {
      setState(() {
        _borderColor = Theme.of(context).dividerColor;
        _iconColor = Theme.of(context).textTheme.bodyText2!.color;
      });
    }
  }

  @override
  void initState() {
    _focus = FocusNode();
    _focus!.addListener(_onFocusChange);
    super.initState();
    // todo: add a text initial value
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: normal_100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: widget.saved,
            focusNode: _focus,
            cursorColor: (widget.errorText != null)
                ? Theme.of(context).errorColor
                : null,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            obscureText: widget.obscureText,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w600,
                ),

            // initialValue: widget.saved,
            onChanged: widget.onChanged,

            decoration: InputDecoration(
                filled: true,
                fillColor: //widget.enabled
                    Theme.of(context).cardColor,
                // : Theme.of(context).backgroundColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                  borderRadius: const BorderRadius.all(smallRadius),
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                  color: (() {
                    if (widget.errorText != null) {
                      return Theme.of(context).errorColor;
                    } else {
                      return Theme.of(context).primaryColor;
                    }
                  })(),
                )),
                border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(normalRadius)),
                label: Text(
                  widget.hintText,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: (() {
                        if (widget.errorText != null) {
                          return Theme.of(context).errorColor;
                        } else {
                          return Theme.of(context).textTheme.bodyText2!.color;
                        }
                      })()),
                ),
                prefixIcon: (widget.prefixIcon != null)
                    ? Icon(widget.prefixIcon,
                        size: normal_200,
                        color: (() {
                          if (widget.errorText != null) {
                            return Theme.of(context).errorColor;
                          } else {
                            return (_iconColor ??
                                Theme.of(context).textTheme.bodyText2!.color);
                          }
                        }()))
                    : null,
                suffixIcon: (widget.suffixIcon != null)
                    ? GestureDetector(
                        onTap: widget.suffixOnPressed,
                        child: Icon(widget.suffixIcon,
                            size: normal_200,
                            color: (() {
                              if (widget.errorText != null) {
                                return Theme.of(context).errorColor;
                              } else {
                                return (_iconColor ??
                                    Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color);
                              }
                            }())),
                      )
                    : null,
                contentPadding: (widget.maxLines! > 1)
                    ? const EdgeInsets.all(normal_100)
                    : null),
          ),
          if (widget.errorText != null)
            Padding(
                padding: const EdgeInsets.all(small_50),
                child: Text(widget.errorText!,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Theme.of(context).errorColor)))
        ],
      ),
    );
  }
}
