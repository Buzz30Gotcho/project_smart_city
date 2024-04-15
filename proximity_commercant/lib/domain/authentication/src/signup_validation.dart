import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/view/otp_screen.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignupValidation with ChangeNotifier {
  // form fields
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _phone = ValidationItem(null, null);

  ValidationItem _userName = ValidationItem(null, null);
  ValidationItem _passwordConfirm = ValidationItem(null, null);
  bool _termsAgreement = false;
  double? _passwordPercentage;
  final String _phoneNumberString = "";
  // essential values for the UI
  // loading to render circular progress bar when waiting for server response
  bool _loading = false;

  // password visibility
  bool _password_visibility = false;
  bool _passwordConfirm_visibility = false;

  // Getters
  // Getters
  ValidationItem get userName => _userName;
  ValidationItem get email => _email;
  ValidationItem get phone => _phone;

  ValidationItem get password => _password;
  ValidationItem get passwordConfirm => _passwordConfirm;

  bool get termsAgreement => _termsAgreement;

  bool get password_visibility => _password_visibility;
  bool get passwordConfirm_visibility => _passwordConfirm_visibility;
  bool get loading => _loading;
  double? get passwordPercentage => _passwordPercentage;

  bool get signUpPhoneisValid {
    return ((_phone.value != null) &&
        _password.value != null &&
        _passwordConfirm.value != null &&
        _termsAgreement);
  }

  bool get SignUpEmailisValid {
    return ((_email.value != null) &&
        _password.value != null &&
        _passwordConfirm.value != null &&
        _termsAgreement);
  }

  bool get emailIsValid {
    return ((_email.value != null));
  }

  // Setters
  void changeEmail(String value) {
    if (value == '') {
      _email = ValidationItem(null, null);
      notifyListeners();
    } else if (value.length > 3) {
      bool _emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
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

  void changePhone(PhoneNumber value) {
    print(value.toString());
    if (value == null) {
      _phone = ValidationItem("", null);
      notifyListeners();
    } else if (value.toString().length > 3) {
      bool _phoneValid =
          RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value.number);
      if (_phoneValid) {
        _phone = ValidationItem(value.completeNumber, null);
        print(_phone.value);

        notifyListeners();
      } else {
        _phone = ValidationItem(null, "Enter a valid Phone number.");
      }
    } else {
      _phone = ValidationItem(null, "Email must be at least 3 characters.");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changeUserName(String value) {
    if (value == '') {
      _userName = ValidationItem(null, null);
      notifyListeners();
    } else if (value.length > 6) {
      bool _userNameValid = RegExp(
              r'(^(?=.{6,18}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$)')
          .hasMatch(value);
      if (_userNameValid) {
        _userName = ValidationItem(value, null);
        notifyListeners();
      } else {
        _userName = ValidationItem(
            null, "User name can only contain alphanumeric characters .");
      }
    } else {
      _userName =
          ValidationItem(null, "User name should be at least 6 characters .");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  /************************* */
  void changePassword(String value) {
    int totalConditions = 5; // Number of password strength conditions
    int conditionsMet = 0;
    List<String> errorMessages =
        []; // Store error messages for conditions not met

    if (value.isEmpty) {
      _password = ValidationItem(null, null);
      _passwordPercentage = 0.0;
      notifyListeners();
      return;
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      errorMessages
          .add("● Password must contain at least 1 uppercase letter[A-Z]");
    } else {
      conditionsMet++;
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      errorMessages
          .add("● Password must contain at least 1 lowercase letter[a-z]");
    } else {
      conditionsMet++;
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      errorMessages.add("● Password must contain at least 1 number");
    } else {
      conditionsMet++;
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      errorMessages
          .add("● Password must contain at least 1 special character[!@#%^&*]");
    } else {
      conditionsMet++;
    }

    if (value.length < 8) {
      errorMessages.add("● Password must be at least 8 characters");
    } else {
      conditionsMet++;
    }

    if (conditionsMet == totalConditions) {
      _password = ValidationItem(value, null);
    } else {
      _password = ValidationItem(null, errorMessages.join('\n'));
    }

    _passwordPercentage = conditionsMet / totalConditions;
    notifyListeners();

    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }
  /*
  void changePassword(String value) {
    int totalConditions = 5; // Number of password strength conditions
    int conditionsMet = 0;

    if (value.isEmpty) {
      _password = ValidationItem(null, null);
      _passwordPercentage = 0.0;
      notifyListeners();
      return;
    }

    if (value.contains(RegExp(r'[A-Z]'))) {
      conditionsMet++;
    } else {
      _password = ValidationItem(
          null, "Password must contain at least 1 uppercase letter");
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
      return;
    }
    if (value.contains(RegExp(r'[a-z]'))) {
      // Condition for at least one lowercase letter
      conditionsMet++;
    } else {
      _password = ValidationItem(
          null, "Password must contain at least 1 lowercase letter");
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
      return;
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      conditionsMet++;
    } else {
      _password =
          ValidationItem(null, "Password must contain at least 1 number");
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
      return;
    }

    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      conditionsMet++;
    } else {
      _password = ValidationItem(
          null, "Password must contain at least 1 special character");
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
      return;
    }
    if (value.length >= 8) {
      conditionsMet++;
    } else {
      _password =
          ValidationItem(null, "Password must be at least 8 characters");
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
      return;
    }
    if (conditionsMet == totalConditions) {
      _password = ValidationItem(value, null);
      _passwordPercentage = conditionsMet / totalConditions;
    }

    notifyListeners();

    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }
*/
  // Check for uppercase l♂etters

  // Check for lowercase letters
  /* if (value.contains(RegExp(r'[a-z]'))) {
      conditionsMet++;
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
    }*/

  // Check for numbers

  // Check for special characters

  //_passwordPercentage = conditionsMet / totalConditions;

/*
  void changePassword(String value) {
    int totalConditions = 4; // Number of password strength conditions
    int conditionsMet = 0;
    print(value);
    print(_password.error);

    if (value.isEmpty) {
      _password = ValidationItem(null, null);
      _passwordPercentage = 0.0;
      notifyListeners();
      return;
    }

    if (value.length > 8) {
      conditionsMet++;
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
    } else {
      _password =
          ValidationItem(null, "Password must be at least 8 characters");
    }
    // Check for uppercase l♂etters
    if (value.contains(RegExp(r'[A-Z]'))) {
      conditionsMet++;
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
    } else {
      _password = ValidationItem(
          null, "Password must be at least 1 uppercase character");
    }

    // Check for lowercase letters
    /* if (value.contains(RegExp(r'[a-z]'))) {
      conditionsMet++;
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
    }*/

    // Check for numbers
    if (value.contains(RegExp(r'[0-9]'))) {
      conditionsMet++;
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
    }
    {
      _password = ValidationItem(null, "Password must be at least 1 number");
    }

    // Check for special characters
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      conditionsMet++;
      _passwordPercentage = conditionsMet / totalConditions;
      notifyListeners();
    }
    {
      _password = ValidationItem(
          null, "Password must be at least 1 special character !@#%^&* ");
    }

    //_passwordPercentage = conditionsMet / totalConditions;

    if (conditionsMet == totalConditions) {
      _password = ValidationItem(value, null);
    }

    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }
*/
  // Update the password strength percentage in your UI or state variable
  // e.g., _passwordStrengthPercentage = passwordPercentage;
/*
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
  } */ //////////////////////////

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
    notifyListeners();
  }

  void changePasswordVisibility() {
    _password_visibility = !password_visibility;
    notifyListeners();
  }

  void changePasswordConfirmVisibility() {
    _passwordConfirm_visibility = !passwordConfirm_visibility;
    notifyListeners();
  }

  void agreeToTerms() {
    _termsAgreement = !_termsAgreement;
    notifyListeners();
  }

  /// signup methods
  void signup(BuildContext context) async {
    /// set loading to true
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();

    /// prepare the dataForm
    final Map<String, dynamic> data = _phone.value != null
        ? _email.value != null
            ? {
                "username": _userName.value,
                "email": _email.value,
                "phone": _phone.value,
                "password": _password.value,
                "password_confirmation": _passwordConfirm.value,
                "role": "seller"
              }
            : {
                "username": _userName.value,
                "phone": _phone.value,
                "password": _password.value,
                "password_confirmation": _passwordConfirm.value,
                "role": "seller"
              }
        : {
            "username": _userName.value,
            "email": _email.value,
            "password": _password.value,
            "password_confirmation": _passwordConfirm.value,
            "role": "seller"
          };

    /// post the dataForm via dio call
    try {
      _loading = true;
      var res = await Dio().post(AUTH_API_URL + '/register', data: data);

      if (res.statusCode == 200) {
        _loading = false;
        notifyListeners();
        print(res.data);

        /// Save Credentials
        credentialsBox.put('id', res.data['_id']);
        credentialsBox.put('email', res.data['email']);
        credentialsBox.put('phone', res.data['phone']);
        Future.delayed(largeAnimationDuration, () {
          notifyListeners();
        });

        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);

        /// Go to [OtpScreen]
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const OTPScreen()),
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

  void googleLogin(BuildContext context) async {}

  void facebookLogin(BuildContext context) async {}
}
