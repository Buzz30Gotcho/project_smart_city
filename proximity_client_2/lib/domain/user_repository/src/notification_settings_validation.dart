import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proximity_client/domain/user_repository/models/models.dart';

class NotificationSettingsValidation with ChangeNotifier {
  bool _notifications = false;
  bool _notifSms = false;
  bool _notifEmail = false;
  bool _notifInPlateforme = false;
  bool _notifPopUp = false;
  bool _notifOrders = false;
  bool _notifOffers = false;
  bool _notifBatch = false;
  final bool _loading = false;
  int? _notifDuration;

  bool? get notifications => _notifications;
  bool? get notifOrders => _notifOrders;
  bool? get notifOffers => _notifOffers;
  bool? get notifBatch => _notifBatch;
  int? get notifDuration => _notifDuration;
  bool? get notifEmail => _notifEmail;
  bool? get notifSms => _notifSms;
  bool? get notifInPlateforme => _notifInPlateforme;
  bool? get notifPopUp => _notifPopUp;
  bool get loading => _loading;

  NotificationSettingsValidation.setUserNotificationsSettings(User? user) {
    if (user!.notification != null) {
      initUserNotification(user.notification!);
    }
    notifyListeners();
  }

  void initUserNotification(UserNotification notification) {
    _notifOrders = notification.orderNotifications ?? false;
    _notifOffers = notification.offerNotification ?? false;
    _notifSms = notification.sms ?? false;
    _notifEmail = notification.mail ?? false;
    _notifInPlateforme = notification.platforme ?? false;
    _notifPopUp = notification.popup ?? false;

    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notifications = value;

    notifyListeners();
  }

  void toggleNotifEmail(bool value) {
    _notifEmail = value;

    notifyListeners();
  }

  void toggleNotifSms(bool value) {
    _notifSms = value;

    notifyListeners();
  }

  void toggleNotifInPlateforme(bool value) {
    _notifInPlateforme = value;

    notifyListeners();
  }

  void toggleNotifPopup(bool value) {
    _notifPopUp = value;

    notifyListeners();
  }

  void toggleNotifRealTime(bool value) {
    _notifOrders = value;
    notifyListeners();
  }

  void toggleNotifHourly(bool value) {
    _notifOffers = value;
    notifyListeners();
  }

  void toggleNotifBatch(bool value) {
    _notifBatch = value;
    if (value) {
      _notifOrders = false;
      _notifOffers = false;
    }
    notifyListeners();
  }

  void changeNotifDuration(String hour, int index) {
    _notifDuration = int.parse(hour);

    notifyListeners();
  }

  Map<String, dynamic> toFormData() {
    Map<String, dynamic> notification = {
      "orderNotifications": _notifOrders,
      "offerNotification": _notifOffers,
      "mail": _notifEmail,
      "sms": _notifSms,
      "platforme": _notifInPlateforme,
      "popup": _notifPopUp,
      "vibration": false,
      "ringing": false,
    };
    return {"notification": json.encode(notification)};
  }
}
