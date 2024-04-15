import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/notification_repository/notification_repository.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    /// get Locale
    final Locale _locale = Localizations.localeOf(context);
    final notificationService = Provider.of<NotificationService>(context);
    return InkWell(
      onTap: () async {
        notificationService.makeItSeend(notification.notification_id ?? "");
        if (notification!.type == 'order') {
          await notificationService.getOrder(notification.id ?? "", context,
              refundOrder: notification!.sub_type == "Refund",
              returnOrder: notification!.sub_type == "Return");
        }
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0).copyWith(bottom: 2),
          decoration: BoxDecoration(color: Colors.white24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Material(
                color: Colors.transparent,
                child: InkWell(
                    // onTap: () =>
                    //     cartService.checkAllOrderedProducts(cart.storeId!),
                    child: Container(
                  decoration: BoxDecoration(
                    color: notification.seend == true
                        ? Color.fromARGB(255, 244, 244, 244)
                        : Color.fromARGB(255, 218, 218, 218),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(small_100),
                      child: Row(children: [
                        // SmallIconButton(
                        //     onPressed: () {},
                        //     icon: Icon(ProximityIcons.user,
                        //         color: Theme.of(context).primaryColor)),
                        Expanded(
                            flex: 1,
                            child: Text('${notification.title}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(fontSize: 12))),
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('${notification.content}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontSize: 12))),
                        )
                      ])),
                ))),
          ])),
    );
  }
}
