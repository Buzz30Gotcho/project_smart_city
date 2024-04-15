/*import 'package:flutter/material.dart';
import 'package:proximity/config/values.dart';

import 'border_type.dart';
class EditText extends StatefulWidget {
  const EditText({
    Key? key,
    this.enabled = true,
    this.saved,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnPressed,
    required this.hintText,
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
  final String? saved;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSaved;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final BorderType borderType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final GestureTapCallback? suffixOnPressed;
  final bool obscureText;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
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
    final Container _editTextContainer = Container(
        padding: (() {
          switch (widget.borderType) {
            case BorderType.single:
              return const EdgeInsets.all(tiny_50);
            case BorderType.top:
              return const EdgeInsets.all(tiny_50).copyWith(bottom: 0);
            case BorderType.topLeft:
              return const EdgeInsets.all(tiny_50)
                  .copyWith(right: 0, bottom: 0);
            case BorderType.topRight:
              return const EdgeInsets.all(tiny_50).copyWith(left: 0, bottom: 0);
            case BorderType.middle:
              return const EdgeInsets.symmetric(horizontal: tiny_50);
            case BorderType.bottom:
              return const EdgeInsets.all(tiny_50).copyWith(top: 0);
            case BorderType.singleLeft:
              return const EdgeInsets.all(tiny_50).copyWith(right: 0);
          }
        }()),
        decoration: BoxDecoration(
          color: (() {
            if (widget.errorText != null) {
              return Theme.of(context).errorColor;
            } else {
              return (_borderColor ?? Theme.of(context).dividerColor);
            }
          }()),
          borderRadius: (() {
            switch (widget.borderType) {
              case BorderType.single:
                return const BorderRadius.all(smallRadius);
              case BorderType.top:
                return const BorderRadius.vertical(top: smallRadius);
              case BorderType.topLeft:
                return const BorderRadius.only(topLeft: smallRadius);
              case BorderType.topRight:
                return const BorderRadius.only(topRight: smallRadius);
              case BorderType.middle:
                return const BorderRadius.all(smallRadius);
              case BorderType.bottom:
                return const BorderRadius.vertical(bottom: smallRadius);
              case BorderType.singleLeft:
                return const BorderRadius.horizontal(left: smallRadius);
            }
          }()),
        ),
        child: Container(
            height: (widget.maxLines == 1)
                ? normal_300
                : normal_200 * widget.maxLines!,
            decoration: BoxDecoration(
              color: widget.enabled
                  ? Theme.of(context).cardColor
                  : Theme.of(context).backgroundColor,
              borderRadius: (() {
                switch (widget.borderType) {
                  case BorderType.single:
                    return const BorderRadius.all(innerBorderRadius);
                  case BorderType.top:
                    return const BorderRadius.vertical(top: innerBorderRadius);
                  case BorderType.topLeft:
                    return const BorderRadius.only(topLeft: innerBorderRadius);
                  case BorderType.topRight:
                    return const BorderRadius.only(topRight: innerBorderRadius);
                  case BorderType.middle:
                    return const BorderRadius.all(innerBorderRadius);
                  case BorderType.bottom:
                    return const BorderRadius.vertical(
                        bottom: innerBorderRadius);
                  case BorderType.singleLeft:
                    return const BorderRadius.horizontal(
                        left: innerBorderRadius);
                }
              }()),
            ),
            child: TextField(
              focusNode: _focus,
              cursorColor: (widget.errorText != null)
                  ? Theme.of(context).errorColor
                  : null,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              obscureText: widget.obscureText,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.w600),
              enabled: widget.enabled,
              // initialValue: widget.saved,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
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
                      borderRadius: BorderRadius.circular(5)),
                  label: Text(
                    widget.hintText,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  // hintText: widget.hintText,
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
            )));
    if (widget.borderType == BorderType.middle) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: normal_100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _editTextContainer,
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
    } else {
      return _editTextContainer;
    }
  }
}*/

import 'package:flutter/material.dart';
import 'package:proximity/config/values.dart';

import 'border_type.dart';

class EditText extends StatefulWidget {
  const EditText({
    Key? key,
    this.controller,
    this.enabled = true,
    this.saved,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnPressed,
    required this.hintText,
    this.label,
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
  final TextEditingController? controller;
  final bool enabled;
  final String hintText;
  final String? label;
  final String? saved;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSaved;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final BorderType borderType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final GestureTapCallback? suffixOnPressed;
  final bool obscureText;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
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
            controller: widget.controller,
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
            enabled: widget.enabled,
            // initialValue: widget.saved,
            onChanged: widget.onChanged,

            decoration: InputDecoration(
                hintText: widget.label,
                filled: true,
                fillColor: widget.enabled
                    ? Theme.of(context).cardColor
                    : Theme.of(context).backgroundColor,
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
/*
import 'package:flutter/material.dart';
import 'package:proximity/config/values.dart';

import 'border_type.dart';

class EditText extends StatefulWidget {
  const EditText({
    Key? key,
    this.enabled = true,
    this.saved,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnPressed,
    required this.hintText,
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
  final String? saved;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSaved;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final BorderType borderType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final GestureTapCallback? suffixOnPressed;
  final bool obscureText;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
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
    final Container _editTextContainer = Container(
        padding: (() {
          switch (widget.borderType) {
            case BorderType.single:
              return const EdgeInsets.all(tiny_50);
            case BorderType.top:
              return const EdgeInsets.all(tiny_50).copyWith(bottom: 0);
            case BorderType.topLeft:
              return const EdgeInsets.all(tiny_50)
                  .copyWith(right: 0, bottom: 0);
            case BorderType.topRight:
              return const EdgeInsets.all(tiny_50).copyWith(left: 0, bottom: 0);
            case BorderType.middle:
              return const EdgeInsets.symmetric(horizontal: tiny_50);
            case BorderType.bottom:
              return const EdgeInsets.all(tiny_50).copyWith(top: 0);
            case BorderType.singleLeft:
              return const EdgeInsets.all(tiny_50).copyWith(right: 0);
          }
        }()),
        decoration: BoxDecoration(
          color: (() {
            if (widget.errorText != null) {
              return Theme.of(context).errorColor;
            } else {
              return (_borderColor ?? Theme.of(context).dividerColor);
            }
          }()),
          borderRadius: (() {
            switch (widget.borderType) {
              case BorderType.single:
                return const BorderRadius.all(smallRadius);
              case BorderType.top:
                return const BorderRadius.vertical(top: smallRadius);
              case BorderType.topLeft:
                return const BorderRadius.only(topLeft: smallRadius);
              case BorderType.topRight:
                return const BorderRadius.only(topRight: smallRadius);
              case BorderType.middle:
                return null;
              case BorderType.bottom:
                return const BorderRadius.vertical(bottom: smallRadius);
              case BorderType.singleLeft:
                return const BorderRadius.horizontal(left: smallRadius);
            }
          }()),
        ),
        child: Container(
            height: (widget.maxLines == 1)
                ? normal_300
                : normal_200 * widget.maxLines!,
            decoration: BoxDecoration(
              color: widget.enabled
                  ? Theme.of(context).cardColor
                  : Theme.of(context).backgroundColor,
              borderRadius: (() {
                switch (widget.borderType) {
                  case BorderType.single:
                    return const BorderRadius.all(innerBorderRadius);
                  case BorderType.top:
                    return const BorderRadius.vertical(top: innerBorderRadius);
                  case BorderType.topLeft:
                    return const BorderRadius.only(topLeft: innerBorderRadius);
                  case BorderType.topRight:
                    return const BorderRadius.only(topRight: innerBorderRadius);
                  case BorderType.middle:
                    return null;
                  case BorderType.bottom:
                    return const BorderRadius.vertical(
                        bottom: innerBorderRadius);
                  case BorderType.singleLeft:
                    return const BorderRadius.horizontal(
                        left: innerBorderRadius);
                }
              }()),
            ),
            child: TextFormField(
              focusNode: _focus,
              cursorColor: (widget.errorText != null)
                  ? Theme.of(context).errorColor
                  : null,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              obscureText: widget.obscureText,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.w600),
              enabled: widget.enabled,
              initialValue: widget.saved,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  labelText: widget.hintText,
                  hintText: widget.hintText,
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
            )));
    if (widget.borderType == BorderType.single) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: normal_100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _editTextContainer,
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
    } else {
      return _editTextContainer;
    }
  }
}
*/
