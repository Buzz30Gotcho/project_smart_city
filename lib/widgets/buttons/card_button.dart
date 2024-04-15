import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';

class CardButton extends StatefulWidget {
  const CardButton(
      {Key? key,
      required this.child,
      this.onPressed,
      this.coverChild,
      this.margin,
      this.opacity})
      : super(key: key);

  final Widget child;
  final GestureTapCallback? onPressed;
  final Widget? coverChild;
  final EdgeInsetsGeometry? margin;
  final double? opacity;

  @override
  _CardButtonState createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  late Animation scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: smallAnimationDuration,
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
    scaleAnimation = Tween(
      begin: 0.5,
      end: 1.0,
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuart));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildCardButton(double scale) => GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: _tapCancel,
      child: Transform.scale(
          scale: scale,
          child: Stack(
            children: [
              Card(
                  margin:
                      widget.margin ?? const EdgeInsets.all(small_100),
                  child: widget.child),
              if (widget.coverChild != null) widget.coverChild!
            ],
          )));

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value / 3;
    return (widget.opacity != null)
        ? Opacity(opacity: widget.opacity!, child: _buildCardButton(_scale))
        : _buildCardButton(_scale);
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _tapCancel() {
    _controller.reverse();
  }
}
