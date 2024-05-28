import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/authentication/src/googleSigninApi.dart';
import 'package:proximity_client/domain/cart_repository/cart_repository.dart';
import 'package:proximity_client/ui/pages/authentication_pages/view/otp_screen.dart';
import 'package:proximity_client/domain/data_persistence/data_persistence.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignupValidation with ChangeNotifier {
  // form fields
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _phone = ValidationItem(null, null);

  ValidationItem _userName = ValidationItem(null, null);
  ValidationItem _passwordConfirm = ValidationItem(null, null);
  bool _termsAgreement = false;
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

  bool get isValid {
    return ((_email.value != null || _phone.value != null) &&
        _password.value != null &&
        _passwordConfirm.value != null &&
        _termsAgreement);
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

  void changePhone(PhoneNumber value) {
    print(value.toString());
    if (value.toString().length > 3) {
    bool phoneValid =
        RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value.number);
    if (phoneValid) {
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
      bool userNameValid = RegExp(
              r'(^(?=.{6,18}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$)')
          .hasMatch(value);
      if (userNameValid) {
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
  void signup(BuildContext context, {GoogleSignInAccount? user}) async {
    /// set loading to true
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();

    var cartItemsBox = Boxes.getCartItemsBox();
    var cartItems = [];

    Iterable<CartItem> allItems = cartItemsBox.values;

// Print each item in the box
    for (CartItem item in allItems) {
      cartItems.add({
        "productId": item.id,
        "quantity": item.orderedQuantity,
        "variantId": item.variantId
      });
    }

    String passwordUser = "";
    if (user != null) {
      var r = Random();
      passwordUser =
          String.fromCharCodes(List.generate(8, (index) => r.nextInt(33) + 89));
    }

    /// prepare the dataForm
    final Map<String, dynamic> data = user != null
        ? {
            "username": user.displayName!.replaceAll(" ", ""),
            "email": user.email,
            "password": passwordUser,
            "password_confirmation": passwordUser,
            "role": "user",
            "google": true
          }
        : _phone.value != null
            ? _email.value != null
                ? {
                    "username": _userName.value,
                    "email": _email.value,
                    "phone": _phone.value,
                    "password": _password.value,
                    "password_confirmation": _passwordConfirm.value,
                    "role": "user",
                    "cart": jsonEncode(cartItems)
                  }
                : {
                    "username": _userName.value,
                    "phone": _phone.value,
                    "password": _password.value,
                    "password_confirmation": _passwordConfirm.value,
                    "role": "user",
                    "cart": jsonEncode(cartItems)
                  }
            : {
                "username": _userName.value,
                "email": _email.value,
                "password": _password.value,
                "password_confirmation": _passwordConfirm.value,
                "role": "user",
                "cart": jsonEncode(cartItems)
              };

    /// post the dataForm via dio call
    try {
      _loading = true;
      var res = await Dio().post('$AUTH_API_URL/register', data: data);

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

  Future openAddEmailDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Text("Why Adding an email !",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: normal_100,
                  ),
                  Text(
                    'Thanks for checking us out!\n We wanted to let you know that adding your email will unlock a variety of benefits for you. \n Not only will you be able to receive updates on your orders and shipping information, but you will also be the first to know about exclusive deals and promotions.\n Additionally, having your email on file will make it easier and faster for you to checkout,\n and allow us to provide you with personalized product recommendations based on your shopping history.\n Do not worry, we take your privacy seriously and will never share your information with third parties.\n Join our community and unlock a world of benefits.\n It also helps with order tracking and enables password recovery in case you forget your login credentials \n sign up and add your email today!.',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TertiaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'I understund')
              ],
            ));
  }

  void googleLogin(BuildContext context) async {}

  void facebookLogin(BuildContext context) async {}

  Future signUpGoogle(BuildContext context) async {
    final user = await GoogleSignInApi.login();
    print(user);
    if (user != null && user.email != "") {
      signup(context, user: user);
    }
  }
}
