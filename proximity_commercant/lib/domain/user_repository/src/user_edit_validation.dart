import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/config/backend.dart';
import 'package:proximity/config/values.dart';
import 'package:proximity/domain_repository/domain_repository.dart';
import 'package:proximity/widgets/toast_snackbar/toast_snackbar.dart';
import 'package:proximity_commercant/domain/data_persistence/src/boxes.dart';
import 'package:proximity_commercant/domain/user_repository/models/models.dart';

import 'package:proximity_commercant/domain/user_repository/src/user_service.dart';

class UserEditValidation with ChangeNotifier {
  late ValidationItem _userName;

  late ValidationItem _emailAddress;
  late ValidationItem _password;
  late ValidationItem _phone;
  late DateTime _birthdate;
  late List<dynamic> _profileImage;
  late Address _address;
  bool _imageUpdated = false;

  UserEditValidation.setUser(User user) {
    _userName = ValidationItem(user.userName, null);

    _emailAddress = ValidationItem(user.email, null);
    _password = ValidationItem(null, null);
    _phone = ValidationItem(user.phone, null);
    _birthdate = user.birthdate!;
    _profileImage = user.profileImage ?? [null];
    _address = user.address ?? Address();
    notifyListeners();
  }

  // Getters
  ValidationItem get userName => _userName;

  ValidationItem get emailAddress => _emailAddress;

  ValidationItem get password => _password;

  ValidationItem get phone => _phone;

  DateTime get birthdate => _birthdate;

  List<dynamic> get profileImage => _profileImage;

  Address get address => _address;

  // checks if forms is valid and verified
  bool get isValid {
    if (_userName.value != null && _emailAddress.value != null //&&
        // _phone.value != null &&
        // birthdate.value != null &&
        //  _address.isAddressValid
        ) {
      return true;
    } else {
      return false;
    }
  }

  // Setters
  void changeUserName(String value) {
    _userName = ValidationItem(value, null);
    notifyListeners();
  }

  void changeEmailAddress(String value) {
    _emailAddress = ValidationItem(value, null);
    notifyListeners();
  }

  void changePhoneNumber(String value) {
    _phone = ValidationItem(value, null);
    notifyListeners();
  }

  void changeBirthdate(DateTime value) {
    _birthdate = value;
    notifyListeners();
  }

  /// Address Form Validators
  void changeAddress(Address newAddress) {
    _address = newAddress;
    notifyListeners();
  }

  void changeFullAddress(String value) {
    _address.fullAddress = value;
    notifyListeners();
  }

  void changeStreetName(String value) {
    _address.streetName = value;
    notifyListeners();
  }

  void changeCountry(String code, int index) {
    _address.countryCode = code;
    _address.countryName = countryList[code];
    notifyListeners();
  }

  void changeRegion(String value) {
    _address.region = value;
    notifyListeners();
  }

  void changeCity(String value) {
    _address.city = value;
    notifyListeners();
  }

  void changePostalCode(String value) {
    _address.postalCode = value; //"\d{2}[ ]?\d{3}"
    notifyListeners();
  }

  /// image Picker
  void editProfileImage(File imageList, UserService userService) async {
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
        var user = User.fromJson(res.data);
        if (_profileImage.isNotEmpty) {
          _profileImage.removeAt(0);
        }
        _profileImage.add(user.profileImage!.first);
        notifyListeners();

        userService.getUserData();
        notifyListeners();

        /// Display Results Message
        /* ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);
        Navigator.pop(context);*/
      }
    } on DioError catch (e) {
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

  void removeProfileImage(int index) {
    _profileImage.removeAt(index);
    notifyListeners();
  }

  /// A method to convert the form into a User Object
  Map<String, dynamic> toDataForm() {
    if (phone.value != null && emailAddress.value != null) {
      return {
        "email": emailAddress.value,
        // "password": password.value,
        "username": userName.value,

        "phone": phone.value,
        "adresse": {
          "latitude": address.lat,
          "longitude": address.lng,
          "fullAdress": address.fullAddress ?? "",
          "streetName": address.fullAddress ?? "",
          "apartmentNumber": address.streetName ?? "",
          "city": address.city ?? "",
          "country": address.countryName ?? "",
          "countryCode": address.countryCode ?? "",
          "region": address.region ?? "",
          "postalCode": address.postalCode ?? ""
        },
        "shippingAdress": {
          "fullAdress": address.fullAddress ?? "",
          "streetName": address.streetName ?? "",
          "apartmentNumber": address.streetName ?? "",
          "city": address.city ?? "",
          "countryCode": address.countryCode ?? "",
          "country": address.countryName ?? "",
          "region": address.region ?? "",
          "postalCode": address.postalCode
        }
      };
    } else {
      if (phone.value == null) {
        return {
          "email": emailAddress.value,
          // "password": password.value,
          "username": userName.value,

          "adresse": {
            "latitude": address.lat,
            "longitude": address.lng,
            "fullAdress": address.fullAddress ?? "",
            "streetName": address.fullAddress ?? "",
            "apartmentNumber": address.streetName ?? "",
            "city": address.city ?? "",
            "country": address.countryName ?? "",
            "countryCode": address.countryCode ?? "",
            "region": address.region ?? "",
            "postalCode": address.postalCode ?? ""
          },
          "shippingAdress": {
            "fullAdress": address.fullAddress ?? "",
            "streetName": address.streetName ?? "",
            "apartmentNumber": address.streetName ?? "",
            "city": address.city ?? "",
            "countryCode": address.countryCode ?? "",
            "country": address.countryName ?? "",
            "region": address.region ?? "",
            "postalCode": address.postalCode
          }
        };
      } else {
        return {
          //"email": emailAddress.value,
          // "password": password.value,
          "username": userName.value,

          "phone": phone.value,

          "adresse": {
            "latitude": address.lat,
            "longitude": address.lng,
            "fullAdress": address.fullAddress ?? "",
            "streetName": address.fullAddress ?? "",
            "apartmentNumber": address.streetName ?? "",
            "city": address.city ?? "",
            "country": address.countryName ?? "",
            "countryCode": address.countryCode ?? "",
            "region": address.region ?? "",
            "postalCode": address.postalCode ?? ""
          },
          "shippingAdress": {
            "fullAdress": address.fullAddress ?? "",
            "streetName": address.streetName ?? "",
            "apartmentNumber": address.streetName ?? "",
            "city": address.city ?? "",
            "countryCode": address.countryCode ?? "",
            "country": address.countryName ?? "",
            "region": address.region ?? "",
            "postalCode": address.postalCode
          }
        };
      }
    }
  }
}
