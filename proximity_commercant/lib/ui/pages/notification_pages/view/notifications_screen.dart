import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/notification_repository/models/models.dart';
import 'package:proximity_commercant/ui/pages/pages.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key, this.notifications}) : super(key: key);
  List<NotificationModel>? notifications;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.notifications!.length.toString());
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const TopBar(title: 'Notifications Page.'),
      Expanded(
          child: (widget.notifications == null)
              ? const NoResults(
                  icon: ProximityIcons.product,
                  message: 'Notifications not found.')
              : (widget.notifications!.isEmpty)
                  ? const NoResults(
                      icon: ProximityIcons.product,
                      message: 'There are no notifications.')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: normal_100),
                      itemCount: widget.notifications!.length,
                      itemBuilder: (_, i) => Column(children: [
                        NotificationItem(notification: widget.notifications![i])
                      ]),
                    )),
    ])));
  }
}
