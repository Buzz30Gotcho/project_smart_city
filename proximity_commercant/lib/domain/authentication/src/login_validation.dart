import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/proximity_commercant_app.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/authentication_pages.dart';
import 'package:proximity_commercant/ui/pages/home_pages/home_pages.dart';
import 'package:restart_app/restart_app.dart';

import '../../../main.dart';

class LoginValidation with ChangeNotifier {
  // form fields
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

  bool _isLogged = false;
  bool _isVerified = false;

  // essential values for the UI
  // loading to render circular progress bar when waiting for server response
  bool _loading = false;

  // password visibility
  bool _visibility = false;

  // Getters
  ValidationItem get email => _email;

  ValidationItem get password => _password;

  bool get visibility => _visibility;

  bool get loading => _loading;
  bool get isLogged => _isLogged;
  bool get isVerified => _isVerified;

  bool get isValid {
    if (_email.value != null && _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  LoginValidation() {
    checkLoginStatus();
  }

  // Setters
  void changeEmail(String value) {
    if (value == '') {
      _email = ValidationItem(null, null);
      notifyListeners();
    } else if (value.length > 3) {
      bool _emailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value) ||
              RegExp(r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$")
                  .hasMatch(value) ||
              RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value);
      if (_emailValid) {
        _email = ValidationItem(value, null);
        notifyListeners();
      } else {
        _email = ValidationItem(null, "Enter a valid Email address.");
      }
    } else {
      _email = ValidationItem(null, "Email must be at least 3 characters.");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changePassword(String value) {
    if (value == '') {
      _password = ValidationItem(null, null);
      notifyListeners();
    } else if (value.length > 6) {
      _password = ValidationItem(value, null);
      notifyListeners();
    } else {
      _password =
          ValidationItem(null, "Password must be at least 6 characters");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changeVisibility() {
    _visibility = !visibility;
    notifyListeners();
  }

  /// login methods
  void login(BuildContext context) async {
    /// set loading to true
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    var welcomeBox = Boxes.getWecome();

    /// prepare the dataForm
    final Map<String, dynamic> data = {
      "email": _email.value,
      "password": _password.value,
      "role": "seller"
    };

    /// post the dataForm via dio call
    try {
      var res = await Dio().post(AUTH_API_URL + '/login', data: data);
      print(res.data["success"]);
      print(res.data["message"]);
      if (res.statusCode == 200) {
        /// Save Credentialsprint
        (res.data["success"]);
        if (res.data["success"]) {
          credentialsBox.put('token', res.data["data"]['token']);
          credentialsBox.put('id', res.data["data"]['user']['id']);
          credentialsBox.put('email', res.data["data"]['user']['email']);
          credentialsBox.put('email', _email.value);
          credentialsBox.put('username', res.data["data"]['user']['username']);
          welcomeBox.put('welcome', res.data["data"]['user']['welcome']);
          ToastSnackbar().init(context).showToast(
              message: "${res.data["message"]}",
              type: ToastSnackbarType.success);
          Future.delayed(largeAnimationDuration, () {
            notifyListeners();
          });

          /// Go to [HomeScreen]
          final welcome = welcomeBox.get('welcome');
          //var box = await Hive.openBox('authentication');

          if (welcome == null) {
            Future.delayed(largeAnimationDuration, () {
              notifyListeners();
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (Route<dynamic> route) => false);
          } else {
            Future.delayed(largeAnimationDuration, () {
              notifyListeners();
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route<dynamic> route) => false);
          }
        } else {
          credentialsBox.put('email', _email.value);
          if (res.data["data"] == 1) {
            ToastSnackbar().init(context).showToast(
                message: "${res.data["message"]}",
                type: ToastSnackbarType.error);
          } else {
            if (res.data["data"] == 2) {
              ToastSnackbar().init(context).showToast(
                  message: "${res.data["message"]}",
                  type: ToastSnackbarType.error);
            } else {
              if (res.data["data"] == 3) {
                ToastSnackbar().init(context).showToast(
                    message: "${res.data["message"]}",
                    type: ToastSnackbarType.error);
              } else {
                if (res.data["data"] == 4) {
                  ToastSnackbar().init(context).showToast(
                      message: "${res.data["message"]}",
                      type: ToastSnackbarType.success);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const OTPScreen()),
                      (Route<dynamic> route) => true);
                }
              }
            }
          }
        }
      }

      /*  
        credentialsBox.put('token', res.data['token']);
        credentialsBox.put('id', res.data['user']['id']);
        credentialsBox.put('email', res.data['user']['email']);
        credentialsBox.put('username', res.data['user']['username']);
        _isVerified = res.data['user']['isVerified'];*/
      /*  if (_isVerified) {
          /// Display Results Message
          ToastSnackbar().init(context).showToast(
              message: "${res.statusMessage}", type: ToastSnackbarType.success);

          /// Go to [HomeScreen]
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const OTPScreen()),
              (Route<dynamic> route) => false);
        }*/
    } on DioError catch (e) {
      if (e.response != null) {
        /// Display Error Response
        ToastSnackbar()
            .init(context)
            .showToast(message: "${e.response}", type: ToastSnackbarType.error);
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

  void logout(BuildContext context) async {
    var credentialsBox = Boxes.getCredentials();
    // credentialsBox = await Hive.openBox('credentials');
    // Delete an item
    await credentialsBox.deleteFromDisk();
    credentialsBox =
        await Hive.openBox('credentials'); // await credentialsBox.clear();
    // print(credentialsBox.values);
    //runApp(ProximityCommercantApp());
    Phoenix.rebirth(context);
    _isLogged = false;
    notifyListeners();
  }

  void checkLoginStatus() {
    var credentialsBox = Boxes.getCredentials();

    final token = credentialsBox.get('token');

    //var box = await Hive.openBox('authentication');

    if (token != null) {
      _isLogged = true;
      notifyListeners();
    }
  }

  void googleLogin(BuildContext context) async {}

  void facebookLogin(BuildContext context) async {}
}
