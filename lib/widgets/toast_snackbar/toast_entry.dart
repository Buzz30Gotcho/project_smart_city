import 'dart:async';

import 'package:flutter/material.dart';

/// Signature for a function to buildCustom Toast
typedef PositionedToastBuilder = Widget Function(
    BuildContext context, Widget child);

/// internal class [ToastEntry] which maintains
/// each [OverlayEntry] and [Duration] for every toast user
/// triggered
class ToastEntry {
  final OverlayEntry? entry;
  final Duration? duration;

  ToastEntry({this.entry, this.duration});
}

/// internal [StatefulWidget] which handles the show and hide
/// animations for [FToast]
class ToastStateFul extends StatefulWidget {
  const ToastStateFul(
      {Key? key,
        required this.child,
        required this.toastDuration,
        required this.fadeDuration})
      : super(key: key);

  final Widget child;
  final Duration toastDuration;
  final Duration fadeDuration;

  @override
  ToastStateFulState createState() => ToastStateFulState();
}

/// State for [_ToastStateFul]
class ToastStateFulState extends State<ToastStateFul>
    with SingleTickerProviderStateMixin {
  /// Start the showing animations for the toast
  showIt() {
    _animationController!.forward();
  }

  /// Start the hidding animations for the toast
  hideIt() {
    _animationController!.reverse();
    _timer?.cancel();
  }

  /// Controller to start and hide the animation
  AnimationController? _animationController;
  late Animation _fadeAnimation;

  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.fadeDuration,
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    super.initState();

    showIt();
    _timer = Timer(widget.toastDuration, () {
      hideIt();
    });
  }

  @override
  void deactivate() {
    _timer?.cancel();
    _animationController!.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation as Animation<double>,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}
