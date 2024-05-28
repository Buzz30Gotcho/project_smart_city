import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/data_persistence/data_persistence.dart';
import 'package:dio/dio.dart';

class ShareService with ChangeNotifier {
  int? _shareOption = 0; // 1 for email , 2 for sms
  String? _email;
  String? _phone;

  int? get shareOption => _shareOption; // 1 for email , 2 for sms
  String? get email => _email;
  String? get phone => _phone;

  // constructor
  ShareService() {
    /// Hive box
  }

  void changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void changePhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void changeOption(int value) {
    _shareOption = value;
    notifyListeners();
  }

  Future<void> shareProduct(String productId, BuildContext context) async {
    // _products = null;
    // _loading = true;
    // notifyListeners();

    /// open hive boxP
    var credentialsBox = Boxes.getCredentials();
    String id = credentialsBox.get('id');
    String token = credentialsBox.get('token');

    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer ";
      final Map<String, dynamic> data = {
        "email": _email,
        "userId": id,
      };
      var res = await dio.post(
          '$BASE_API_URL/notification/shareProduct/$productId',
          data: data);
      // _loading = false;
      // notifyListeners();
      if (res.statusCode == 200) {
        _shareOption = 0;
        _email = "";
        _phone = "";
        notifyListeners();

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text('The Product was shared with success')),
        );
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Error , re-try please')),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('${e.response!}')));
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Error , re-try please')),
      );
    }
  }

  Future<void> shareStore(String storeId, BuildContext context) async {
    // _products = null;
    // _loading = true;
    // notifyListeners();

    /// open hive boxP
    var credentialsBox = Boxes.getCredentials();
    String id = credentialsBox.get('id');
    String token = credentialsBox.get('token');

    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer ";
      final Map<String, dynamic> data = {
        "email": _email,
        "userId": id,
      };
      var res = await dio
          .post('$BASE_API_URL/notification/shareStore/$storeId', data: data);
      // _loading = false;
      // notifyListeners();
      if (res.statusCode == 200) {
        _shareOption = 0;
        _email = "";
        _phone = "";
        notifyListeners();

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text('The Product was shared with success')),
        );
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Error , re-try please')),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('${e.response!}')));
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('Error , re-try please')),
        );
      }
    }
  }
}
