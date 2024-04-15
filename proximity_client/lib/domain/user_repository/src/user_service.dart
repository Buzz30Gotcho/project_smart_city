import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/data_persistence/data_persistence.dart';
import 'package:proximity_client/domain/user_repository/models/models.dart';
import 'package:proximity_client/ui/pages/main_pages/main_pages.dart';

class UserService extends ChangeNotifier {
  User? _user;

  // essential values for the UI
  // loading to render circular progress bar when waiting for server response
  bool _loading = false;

  User? get user => _user;

  bool get loading => _loading;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  bool? get isVerified => (_user == null) ? null : (_user!.isVerified!);

  UserService() {
    getUserData();
  }

  /// PUT Methods
  Future updateUser(BuildContext context, Map<String, dynamic> data) async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String id = credentialsBox.get('id');
    String token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $token";
      var res = await dio.put('$BASE_API_URL/user/$id', data: data);
      _loading = false;
      notifyListeners();
      if (res.statusCode == 200) {
        /// Save new User Data
        _user = User.fromJson(res.data);
        print(_user);
        notifyListeners();

        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "Updated with success}", type: ToastSnackbarType.success);
        Navigator.pop(context);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        /// Display Error Response
        ToastSnackbar().init(context).showToast(
            message: "${e.response!.data}", type: ToastSnackbarType.error);
      } else {
        /// Display Error Message
        ToastSnackbar()
            .init(context)
            .showToast(message: "${e.message}", type: ToastSnackbarType.error);
      }
    }
    _loading = false;
    notifyListeners();
  }

  /// GET methods
  Future getUserData() async {
    //to do : fix this
    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String id = credentialsBox.get('id');
    String token = credentialsBox.get('token');

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $token";
      var res = await dio.get('$BASE_API_URL/user/find/$id');

      if (res.statusCode == 200) {
        /// Save new User Data
        _user = User.fromJson(res.data);
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
    notifyListeners();
  }

  Future welcomeValidate(BuildContext context) async {
    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String id = credentialsBox.get('id');
    String token = credentialsBox.get('token');

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $token";
      var res = await dio.get('$BASE_API_URL/user/welcome/$id');

      if (res.statusCode == 200) {
        /// Save new User Data
        _user = User.fromJson(res.data);
        notifyListeners();
        credentialsBox.put('welcome', 'true');

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route<dynamic> route) => false);
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
    notifyListeners();
  }
}
