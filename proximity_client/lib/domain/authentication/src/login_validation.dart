import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/authentication/src/googleSigninApi.dart';
import 'package:proximity_client/domain/data_persistence/data_persistence.dart';
import 'package:proximity_client/ui/pages/main_pages/main_pages.dart';
import 'package:proximity_client/ui/pages/authentication_pages/authentication_pages.dart';

class LoginValidation with ChangeNotifier {
  // form fields
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  bool _isLogged = false;

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
  LoginValidation() {
    checkLoginStatus();
  }

  bool get isValid {
    if (_email.value != null && _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  // Setters
  void changeEmail(String value) {
    if (value == '') {
      _email = ValidationItem(null, null);
      notifyListeners();
    } else if (value.length > 3) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (emailValid) {
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
  void login(BuildContext context, {GoogleSignInAccount? user}) async {
    /// set loading to true
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();

    /// prepare the dataForm
    Map<String, dynamic> data = {};

    if (user != null) {
      data = {
        "email": user.email,
        "name": user.displayName,
        "google": true,
        "role": "user"
      };
    } else {
      data = {
        "email": _email.value,
        "password": _password.value,
        "role": "user"
      };
    }

    /// post the dataForm via dio call
    try {
      var res = await Dio().post('$AUTH_API_URL/login', data: data);

      if (res.statusCode == 200) {
        if (res.data["success"]) {
          credentialsBox.put('token', res.data["data"]['token']);
          credentialsBox.put('id', res.data["data"]['user']['id']);
          credentialsBox.put('email', res.data["data"]['user']['email']);
          credentialsBox.put('email', _email.value);
          credentialsBox.put('username', res.data["data"]['user']['username']);
          credentialsBox.put('welcome', res.data["data"]['user']['welcome']);
          ToastSnackbar().init(context).showToast(
              message: "${res.data["message"]}",
              type: ToastSnackbarType.success);
          Future.delayed(largeAnimationDuration, () {
            notifyListeners();
          });

          /// Go to [HomeScreen]
          final welcome = credentialsBox.get('welcome');
          //var box = await Hive.openBox('authentication');

          if (welcome == null || welcome == 'false') {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const WelcomeScreenAfterLogin()),
                (Route<dynamic> route) => false);
          } else {
            /// Display Results Message
            ToastSnackbar().init(context).showToast(
                message: "${res.statusMessage}",
                type: ToastSnackbarType.success);

            /// Go to [HomeScreen]
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainScreen()),
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

  void checkLoginStatus() {
    var credentialsBox = Boxes.getCredentials();
    final token = credentialsBox.get('token');
    //var box = await Hive.openBox('authentication');

    if (token != null) {
      _isLogged = true;
    }
  }

  void logout() async {
    var credentialsBox = Boxes.getCredentials();
    // Delete an item
    await credentialsBox.delete('token');
    _isLogged = false;
    notifyListeners();
  }

  void googleLogin(BuildContext context) async {}

  void facebookLogin(BuildContext context) async {}

  Future signInGoogle(BuildContext context) async {
    final user = await GoogleSignInApi.login();
    print(user);
    if (user != null && user.email != "") {
      login(context, user: user);
    }
  }
}
