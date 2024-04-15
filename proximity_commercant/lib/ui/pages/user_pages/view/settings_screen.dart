import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(children: const [
              TopBar(title: 'Settings.'),
              InfoMessage(
                  message:
                  'Enable to receive emails from SmartCity and their sellers with deals, coupons, items recommendations and services.'),
            ])));
  }
}
