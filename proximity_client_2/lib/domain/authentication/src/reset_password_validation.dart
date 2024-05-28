import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/domain_repository/models/models.dart';
import 'package:proximity/widgets/toast_snackbar/toast_snackbar.dart';
import 'package:proximity_client/domain/data_persistence/src/boxes.dart';
import 'package:proximity_client/ui/pages/authentication_pages/authentication_pages.dart';
import 'package:proximity_client/ui/pages/authentication_pages/view/password_reset_screen.dart';
import 'package:proximity_client/ui/pages/authentication_pages/view/recovery_code_screen.dart';

class ResetPasswordValidation with ChangeNotifier {
  // form fields
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _passwordConfirm = ValidationItem(null, null);
  ValidationItem get passwordConfirm => _passwordConfirm;
  bool _password_visibility = false;
  bool _passwordConfirm_visibility = false;
  // essential values for the UI
  // loading to render circular progress bar when waiting for server response
  bool _loading = false;

  // password visibility
  bool get password_visibility => _password_visibility;
  bool get passwordConfirm_visibility => _passwordConfirm_visibility;

  // Getters
  ValidationItem get email => _email;

  ValidationItem get password => _password;

  bool get loading => _loading;
  ValidationItem _recoveryCode = ValidationItem(null, null);

  // essential values for the UI
  // loading to render circular progress bar when waiting for server response

  // Getters
  ValidationItem get recoveryCode => _recoveryCode;

  bool get isValid {
    return (_recoveryCode.value != null);
  }

  void changePasswordVisibility() {
    _password_visibility = !password_visibility;
    notifyListeners();
  }

  void changePasswordConfirmVisibility() {
    _passwordConfirm_visibility = !passwordConfirm_visibility;
    notifyListeners();
  }

  // Setters
  void changeRecoveryCode(String value) {
    if (value.length == 4) {
      _recoveryCode = ValidationItem(value, null);
      notifyListeners();
    } else {
      _recoveryCode = ValidationItem(null, null);
      notifyListeners();
    }
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

  void verifyPassword(String value) {
    if (value == '') {
      _passwordConfirm = ValidationItem(null, null);
      notifyListeners();
    } else if (value == _password.value) {
      _passwordConfirm = ValidationItem(value, null);
      notifyListeners();
    } else {
      _passwordConfirm = ValidationItem(null, "Passwords do not match");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  /// POST method
  ///

  void verifyRecoveryCode(BuildContext context) async {
    /// set loading to true
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();

    /// prepare the dataForm
    final Map<String, dynamic> data = {
      "email": _email.value,
      "token": _recoveryCode.value
    };

    /// post the dataForm via dio call
    ///
    var token = _recoveryCode.value;
    print(token);
    var id = _email.value;
    try {
      print(token);
      var res = await Dio().get('$BASE_API_URL/password-reset/$id/$token');
      print(res.data);
      if (res.statusCode == 200) {
        _loading = false;
        notifyListeners();

        /// Save Credentials
        // credentialsBox.put('firstTime', false);
        // credentialsBox.put('token', res.data['token']);

        if (res.data["success"]) {
          ToastSnackbar().init(context).showToast(
              message: "${res.statusMessage}", type: ToastSnackbarType.success);

          /// Go to [HomeScreen]
          Future.delayed(largeAnimationDuration, () {
            notifyListeners();
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const PasswordResetScreen()),
              (Route<dynamic> route) => false);
        } else {
          ToastSnackbar().init(context).showToast(
              message: "${res.data["message"]}", type: ToastSnackbarType.error);
        }

        /// Display Results Message
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

  void modifyPassword(BuildContext context) async {
    /// set loading to true
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();

    /// prepare the dataForm
    final Map<String, dynamic> data = {
      "password": _password.value,
      "password_confirmation": _passwordConfirm.value
    };

    /// post the dataForm via dio call
    ///
    var token = _recoveryCode.value;
    print(token);
    var id = _email.value;
    try {
      print(token);
      var res = await Dio()
          .post('$BASE_API_URL/password-reset/$id/$token', data: data);
      print(res.data);
      if (res.statusCode == 200) {
        _loading = false;
        notifyListeners();

        /// Save Credentials
        // credentialsBox.put('firstTime', false);
        //credentialsBox.put("email", _email.value);
        //credentialsBox.put('token', res.data['token']);
        
        credentialsBox.put('token', res.data['data']['token']);
        credentialsBox.put('id', res.data['data']['user']['id']);
        credentialsBox.put('email', res.data['data']['user']['email']);
        credentialsBox.put('welcome', res.data['data']['user']['welcome']);
        if (res.data["success"]) {
          ToastSnackbar().init(context).showToast(
              message: "${res.statusMessage}", type: ToastSnackbarType.success);

          /// Go to [HomeScreen]
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false);
        } else {
          ToastSnackbar().init(context).showToast(
              message: "${res.data["message"]}", type: ToastSnackbarType.error);
        }

        /// Display Results Message
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

  /// login methods
  void createResetPasswordRequest(BuildContext context) async {
    /// set loading to true
    _loading = true;
    notifyListeners();

    /// prepare the dataForm
    final Map<String, dynamic> data = {
      "email": _email.value,
    };

    /// post the dataForm via dio call
    try {
      var res = await Dio().post('$BASE_API_URL/password-reset', data: data);

      if (res.statusCode == 200) {
        /// Save Credentials
        /// Display Results Message
        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);

        /// Go to [HomeScreen]
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => RecoveryCodeScreen(email: _email.value)),
            (Route<dynamic> route) => true);
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
}
