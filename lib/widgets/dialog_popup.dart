import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';

const EdgeInsets _defaultInsetPadding =
    EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

class DialogPopup extends StatelessWidget {
  /// Creates a dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  const DialogPopup({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = _defaultInsetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    required this.child,
  }) : super(key: key);

  final Color? backgroundColor;
  final double? elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets insetPadding;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets effectivePadding = MediaQuery.of(context).viewInsets;
    return AnimatedPadding(
        padding: effectivePadding,
        duration: insetAnimationDuration,
        curve: insetAnimationCurve,
        child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 280.0),
                    child: Card(child: child)))));
  }
}

/// ShowDialogPopup is used to create a DialogPopup
Future<T?> showDialogPopup<T extends Object>({
  required BuildContext context,
  required RoutePageBuilder pageBuilder,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
}) {
  assert(true);
  return Navigator.of(context, rootNavigator: useRootNavigator)
      .push<T>(RawDialogRoute<T>(
    pageBuilder: pageBuilder,
    barrierDismissible: barrierDismissible,
    barrierLabel: '',
    barrierColor: Theme.of(context).shadowColor.withOpacity(1 / 3),
    transitionDuration: normalAnimationDuration,
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: small_100 * anim1.value, sigmaY: small_100 * anim1.value),
        child: FadeTransition(child: child, opacity: anim1)),
    settings: routeSettings,
  ));
}
