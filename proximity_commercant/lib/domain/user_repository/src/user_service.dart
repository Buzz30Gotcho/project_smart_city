import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/domain/user_repository/models/models.dart';
import 'package:proximity_commercant/ui/pages/home_pages/home_pages.dart';

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

  bool get valid => (_user != null);

  bool? get isVerified => (_user == null) ? null : (_user!.isVerified!);

  UserService() {
    getUserData();
  }

  /// image Picker
  void editProfileImage(File imageList) async {
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /* final Map<String, dynamic> data = {
      "image": await MultipartFile.fromFile(imageList[0].path,
          filename: imageList[0].path.split('/').last)*/

    FormData _formData = FormData.fromMap({});
    _formData.files
        .add(MapEntry('image', MultipartFile.fromFileSync(imageList.path)));

    /*  final Map<String, dynamic> data =
        MapEntry('image', MultipartFile.fromFileSync(_profileImage.first.path));*/
    print("res.statusCode");
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      var res = await dio.put(BASE_API_URL + '/user/update_image/$_id',
          data: _formData);
      //_loading = false;
      print(res.statusCode);
      notifyListeners();
      if (res.statusCode == 200) {
        /// Save new User Data
        _user = User.fromJson(res.data);
        notifyListeners();

        /// Display Results Message
        /* ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);
        Navigator.pop(context);*/
      }
    } on DioError catch (e) {
      print(e);
      if (e.response != null) {
        /// Display Error Response
        /* ToastSnackbar().init(context).showToast(
            message: "${e.response!.data}", type: ToastSnackbarType.error);*/
      } else {
        /// Display Error Message
        /*   ToastSnackbar()
            .init(context)
            .showToast(message: "${e.message}", type: ToastSnackbarType.error);*/
      }
    }
  }

  /// PUT Methods
  Future updateUser(BuildContext context, Map<String, dynamic> data) async {
    _loading = true;
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
      var res = await dio.put(BASE_API_URL + '/user/$_id', data: data);
      _loading = false;
      notifyListeners();
      if (res.statusCode == 200) {
        /// Save new User Data
        _user = User.fromJson(res.data);
        notifyListeners();

        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);
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
    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String? _token = credentialsBox.get('token');

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      var res = await dio.get(BASE_API_URL + '/user/find/$_id');

      if (res.statusCode == 200) {
        /// Save new User Data
        _user = User.fromJson(res.data);
        print(_user!.profileImage);
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

  /// GET methods
  Future welcomeValidate(BuildContext context) async {
    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    var welcomeBox = Boxes.getWecome();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      var res = await dio.get(BASE_API_URL + '/user/welcome/$_id');

      if (res.statusCode == 200) {
        /// Save new User Data
        _user = User.fromJson(res.data);
        notifyListeners();
        welcomeBox.put('welcome', 'true');

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
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
