import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class NotificationsPreferencesScreen extends StatelessWidget {
  const NotificationsPreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      TopBar(title: 'Notifications.'),
      ListToggle(title: 'Orders', value: true),
      ListToggle(title: 'Flashdeals', value: true),
      ListToggle(title: 'Reminders', value: true),
      InfoMessage(message: 'Turn off the buttons to disable notifications.'),
      ListToggle(title: 'Email Notifications', value: false),
      InfoMessage(
          message:
              'Enable to receive emails from SmartCity and their sellers with deals, coupons, items recommendations and services.'),
    ])));
  }
}
