//import 'dart:convert';
//import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
//import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/authentication/authentication.dart';
import 'package:proximity_commercant/domain/notification_repository/notification_repository.dart';
//import 'package:proximity_commercant/domain/store_repository/src/store_service.dart';
//import 'package:proximity_commercant/main.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/view/login_screen.dart';
import 'package:proximity_commercant/ui/pages/home_pages/home_pages.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
//import 'package:proximity_commercant/ui/pages/onBoarding_page/OnBoardingScreen.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  NotificationService notificationServiceGlobal = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationServiceGlobal.getNotifications(null);
    initPlatform(notificationServiceGlobal);
  }

  String _debugLabelString = "";
  String notification_type = "Refund";
  Map<String, dynamic>? notification = null;
  String notification_title = "";
  String notification_body = "";

  @override
  Widget build(BuildContext parentContext) {
    final loginValidation = Provider.of<LoginValidation>(parentContext);
    final notificationService = Provider.of<NotificationService>(parentContext);

    var welcomeBox = Boxes.getWecome();
    final welcome = welcomeBox.get('welcome');

    if (_debugLabelString != "") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleNotification(notification, notificationService, parentContext);
        notificationService.getNotifications(null);
        setState(() {
          _debugLabelString = "";
        });
      });
    }

    return loginValidation.isLogged
        ? welcome == null
            ? const WelcomeScreen()
            : const HomeScreen()
        : const LoginScreen();
  }

  Future<void> initPlatform(NotificationService notificationService) async {
    OneSignal.Notifications.addClickListener((OSNotificationClickEvent event) {
      notificationServiceGlobal.getNotifications(null);
      print('BODY ${event.notification.body}');
      print('TITLE: ${event.notification.title}');
      print(
          "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
      var credentialsBox = Boxes.getCredentials();
      var _id = credentialsBox.get('id');

      print(_id);
      print("event.notification.additionalData 1");
      print(event.notification.additionalData);

      if (_id != null &&
          _id != "" &&
          event.notification.additionalData != null &&
          event.notification.additionalData!["owner_id"].contains(_id)) {
        print("is the owner");
        notificationService.getNotifications(null);
        setState(() {
          _debugLabelString = event.notification.jsonRepresentation();
          notification = event.notification.additionalData;
          notification_title = event.notification.title ?? "";
          notification_body = event.notification.body ?? "";
        });
      }
      print('"OneSignal: notification opened: ${event}');
    });

    OneSignal.Notifications.addForegroundWillDisplayListener(
        (OSNotificationWillDisplayEvent event) {
      notificationServiceGlobal.getNotifications(null);
      print("event.notification.additionalData");
      print(event.notification.additionalData);
      print('BODY ${event.notification.body}');
      print('TITLE: ${event.notification.title}');
      print(
          "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
      var credentialsBox = Boxes.getCredentials();
      var _id = credentialsBox.get('id');

      print(_id);

      if (_id != null &&
          _id != "" &&
          event.notification.additionalData != null &&
          event.notification.additionalData!["owner_id"].contains(_id)) {
        print("is the owner");
        notificationService.getNotifications(null);
        setState(() {
          _debugLabelString = event.notification.jsonRepresentation();
          notification = event.notification.additionalData;
          notification_title = event.notification.title ?? "";
          notification_body = event.notification.body ?? "";
        });
      } else {
        //event.complete(null);
      }
    });
  }

  void handleNotification(notification, notificationService, parentContext) {
    print("abousssssssssssssssss");
    // var message = _debugLabelString;
    // var notification = json.decode(_debugLabelString);
    var notification_icon = ProximityIcons.delivery_duotone_1;
    //var notification_text = "Apple store responded to one of your orders";
    //var notification_redirection = "";
    var notification_image = null;

    switch (notification!["sub_type"]) {
      case "Delivery":
        notification_icon = ProximityIcons.delivery_duotone_1;
        break;
      case "Pickup":
        notification_icon = ProximityIcons.self_pickup_duotone_1;
        break;
      case "Reservation":
        notification_icon = ProximityIcons.history_duotone_1;
        break;
      case "Return":
        notification_image = "assets/img/return_icon.png";
        break;
      case "Refund":
        notification_image = "assets/img/refund_icon.png";
        break;
      case "Cancel":
        notification_icon = ProximityIcons.rejected_duotone_1;
        break;
      default:
    }

    showDialogPopup(
        barrierDismissible: false,
        context: context,
        pageBuilder: (ctx, anim1, anim2) => StatefulBuilder(
            builder: (context, setState) => DialogPopup(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - normal_200 * 2,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const SizedBox(height: normal_100),
                      Stack(children: [
                        ImageFiltered(
                            imageFilter: blurFilter,
                            child: Icon(Icons.check_circle_outline_outlined,
                                color: blueSwatch.shade100.withOpacity(1 / 3),
                                size: normal_300)),
                        if (notification_image == null ||
                            notification_image == "")
                          Icon(notification_icon,
                              color: redSwatch.shade500, size: normal_300),
                        if (notification_image != null &&
                            notification_image != "")
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Positioned.fill(
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    normalRadius),
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Image.asset(
                                                    notification_image)))),
                                  ])),
                      ]),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: normal_100,
                              left: normal_100,
                              right: normal_100),
                          child: Text(
                              notification_title
                              // message
                              ,
                              style: Theme.of(context).textTheme.headline3,
                              textAlign: TextAlign.center)),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: normal_100,
                              left: normal_100,
                              right: normal_100),
                          child: Text(
                              notification_body
                              // message
                              ,
                              style: Theme.of(context).textTheme.subtitle2,
                              textAlign: TextAlign.center)),
                      Padding(
                          padding: const EdgeInsets.all(normal_100),
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Expanded(
                                child: SecondaryButton(
                                    title: 'Cancel.',
                                    onPressed: () =>
                                        Navigator.of(context).pop())),
                            const SizedBox(
                              width: small_100,
                            ),
                            Expanded(
                                child: SecondaryButton(
                                    title: 'Voir.',
                                    onPressed: () async {
                                      if (notification!["type"] == 'order') {
                                        Navigator.of(context).pop();
                                        await notificationService.getOrder(
                                            notification!["id"], parentContext,
                                            refundOrder:
                                                notification!["sub_type"] ==
                                                    "Refund",
                                            returnOrder:
                                                notification!["sub_type"] ==
                                                    "Return");
                                      }
                                    })),
                          ]))
                    ])))));
  }
}
