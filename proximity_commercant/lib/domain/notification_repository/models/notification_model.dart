import 'package:flutter/foundation.dart';

class NotificationModel {
  String? notification_id;
  String? owner_id;
  String? title;
  String? content;
  String? id;
  String? type;
  String? sub_type;
  bool? seend = false;
  bool? seendInList = false;

  NotificationModel({
    this.notification_id,
    this.owner_id,
    this.title,
    this.content,
    this.id,
    this.type,
    this.sub_type,
    this.seend,
    this.seendInList,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notification_id: json['_id'],
      owner_id: json['owner_id'],
      title: json['title'],
      content: json['content'],
      id: json['id'],
      type: json['type'],
      sub_type: json['sub_type'],
      seend: json['seend'],
      seendInList: json['seendInList'],
    );
  }

  static List<NotificationModel> notificationsFromJsonList(
      List<dynamic> parsedJson) {
    List<NotificationModel> _list = [];
    for (int i = 0; i < parsedJson.length; i++) {
      _list.add(NotificationModel.fromJson(parsedJson[i]));
    }
    return _list;
  }
}
