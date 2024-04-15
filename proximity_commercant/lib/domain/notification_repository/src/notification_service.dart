import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/domain/notification_repository/models/models.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/pages.dart';

class NotificationService with ChangeNotifier {
  Order? _order;
  late bool _loadingOrder = false;

  List<NotificationModel> _notifications = [];
  late bool _loadingNotifications = false;

  Order? get order => _order;
  bool get loadingOrder => _loadingOrder;

  List<NotificationModel> get notifications => _notifications;
  bool get loadingNotifications => _loadingNotifications;

  NotificationService() {
    print("init service");
    getNotifications(null);
  }

  Future<void> getNotifications(BuildContext? context) async {
    _notifications = [];
    _loadingNotifications = true;
    notifyListeners();

    /// open hive boxP
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer " + _token;
      var res = await dio.get(BASE_API_URL + '/notification/$_id');
      _loadingNotifications = false;
      notifyListeners();
      if (res.statusCode == 200) {
        _notifications = [];
        _notifications!
            .addAll(NotificationModel.notificationsFromJsonList(res.data));
        notifyListeners();
        print("_notifications.length");
        print(_notifications.length);
        if (context != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NotificationsScreen(notifications: _notifications)));
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }
    }
  }

  Future getOrder(String order_id, BuildContext context,
      {bool? returnOrder = false, bool? refundOrder = false}) async {
    print("ws lanched : $order_id  ");
    _order = null;
    _loadingOrder = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      var res = await dio.get(BASE_API_URL + '/order/$order_id');
      notifyListeners();
      if (res.statusCode == 200) {
        print(res.data.length);
        _order = Order.fromJson(res.data);
        _loadingOrder = false;
        notifyListeners();
        if (res.data != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderPage(
                      order: _order,
                      returnOrder: returnOrder,
                      refundOrder: refundOrder)));
        }
      }
    } on DioError catch (e) {
      _loadingOrder = false;
      notifyListeners();
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }
    }
  }

  Future makeItSeend(String notificationId) async {
    print("ws lanched : $notificationId  ");

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      Map<String, dynamic> fd = {"seend": true, "seendInList": true};
      var res = await dio.post(
          BASE_API_URL + '/notification/update/$notificationId',
          data: fd);
      notifyListeners();
      if (res.statusCode == 200) {
        print("notification updated");
        var index = _notifications
            .indexWhere((element) => element.notification_id == notificationId);
        if (index != -1) {
          _notifications[index].seend = true;
          _notifications[index].seendInList = true;
          notifyListeners();
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }
    }
  }

  Future makeItListSeend() async {
    print("ws lanched :  ");

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      Map<String, dynamic> fd = {"seendInList": true};
      var res = await dio.post(BASE_API_URL + '/notification/update/user/$_id',
          data: fd);
      notifyListeners();
      if (res.statusCode == 200) {
        print("notification updated");

        _notifications.map((el) {
          el.seendInList = true;
          return el;
        });
        notifyListeners();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }
    }
  }
}
