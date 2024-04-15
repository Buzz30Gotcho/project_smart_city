import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key, required this.errors}) : super(key: key);

  final List<String?> errors;

  List<Text> _messagesBuilder(BuildContext context, List<String?> _errors) {
    List<Text> _list = [];
    for (int i = 0; i < _errors.length; i++) {
      if (_errors[i] != null) {
        _list.add(Text('● ${_errors[i]!}',
            style: TextStyle(color: Theme.of(context).errorColor)));
      }
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: normal_100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _messagesBuilder(context, errors),
        ));
  }
}
