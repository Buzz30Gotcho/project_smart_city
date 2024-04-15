import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class RichEditText extends StatefulWidget {
  const RichEditText({Key? key, required this.children, this.errorText})
      : super(key: key);

  final List<Widget> children;
  final String? errorText;

  @override
  State<RichEditText> createState() => _RichEditTextState();
}

class _RichEditTextState extends State<RichEditText> {
  List<Widget> _childrenBuilder() {
    List<Widget> _children = [];
    for (int i = 0; i < widget.children.length; i++) {
      _children.add(widget.children[i]);
      if (i != widget.children.length - 1) {
        _children.add(Container(
          height: tiny_50,
          color: Theme.of(context).dividerColor,
        ));
      }
    }
    return _children;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: normal_100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _childrenBuilder(),
        ));
  }
}
