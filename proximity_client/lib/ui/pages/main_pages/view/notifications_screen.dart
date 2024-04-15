import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:
                ListView(children: const [TopBar(title: 'Notifications.')])));
  }
}
