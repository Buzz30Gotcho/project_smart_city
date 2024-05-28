class UserNotification {
  bool? orderNotifications;
  bool? offerNotification;
  bool? mail;
  bool? sms;
  bool? platforme;
  bool? popup;
  bool? vibration;
  bool? ringing;

  UserNotification(
      {this.orderNotifications,
      this.offerNotification,
      this.mail,
      this.sms,
      this.platforme,
      this.popup,
      this.vibration,
      this.ringing});

  UserNotification.fromJson(Map<String, dynamic> parsedJson)
      : orderNotifications = parsedJson['orderNotifications'],
        offerNotification = parsedJson['offerNotification'],
        mail = parsedJson['mail'],
        sms = parsedJson['sms'],
        platforme = parsedJson['platforme'],
        popup = parsedJson['popup'],
        vibration = parsedJson['vibration'],
        ringing = parsedJson['ringing'];
}
