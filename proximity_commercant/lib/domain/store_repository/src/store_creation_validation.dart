import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/store_repository/models/workingTime_model.dart';

import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

class StoreCreationValidation with ChangeNotifier {
  String? _id;
  ValidationItem _storeName = ValidationItem(null, null);
  ValidationItem _storeDescription = ValidationItem(null, null);
  ValidationItem _storeCategory = ValidationItem(null, null);
  final List<String> _selectedDays = [];
  ValidationItem _storeRegistrationNumber = ValidationItem(null, null);

  int _timeRangeKey = 0;
  String? _errorMessage;

  List<TimeRange>? _fixedWorkingHours = [];
  Map<String, List<TimeRange>>? _dayWorkingHours;
  Map<String, List<TimeRange>>? _customizedWorkingHours;
  final TimeOfDay? _openTime = const TimeOfDay(hour: 09, minute: 00);
  final TimeOfDay? _closeTime = const TimeOfDay(hour: 18, minute: 00);
  //List<WorkingTime> _storeWorkingTimes = [];
  Address _storeAddress = Address();
  String? _workingTimeOption;
  List<dynamic> _storeImages = [];
  final List<String> _deletedImages = [];
  Policy? _policy;
  WorkingTime? _workingTime;

  StoreCreationValidation();

  StoreCreationValidation.setStore(Store store) {
    _id = store.id;
    _storeName = ValidationItem(store.name, null);
    // _storeCategory = ValidationItem(store.category?.toString(), null);
    _storeDescription = ValidationItem(store.description, null);

    // if (store.policy != null) {
    /*
      _selfPickupFree = store.policy!.shippingMethods!
          .contains(ShippingMethod.selfPickupFree);
      _selfPickupPartial = store.policy!.shippingMethods!
          .contains(ShippingMethod.selfPickupPartial);
      _selfPickupTotal = store.policy!.shippingMethods!
          .contains(ShippingMethod.selfPickupTotal);
      _selfPickup = _selfPickupFree || _selfPickupPartial || _selfPickupTotal;
      _delivery =
          (store.policy!.shippingMethods!.contains(ShippingMethod.delivery));*/
    //_tax = store.policy!.tax;
    /* _selfPickupPrice = store.policy!.selfPickUpPrice;
      _openWeekend = store.policy!.openWeekend;
      _openDay = store.policy!.openDay;
      _openNight = store.policy!.openNight;*/
    // _openTime = DateTime.parse(store.policy!.openTime!);
    // _closeTime = DateTime.parse(store.policy!.closeTime!);
    // }
    if (store.address != null) {
      _storeAddress = store.address!;
    }
    if (store.image != null) {
      _storeImages = [store.image!];
    }
    // set working time :
    if (store.workingTime != null) {
      _workingTimeOption = store.workingTime!.option;
      if (store.workingTime!.fixedHours != null) {
        if (store.workingTime!.fixedHours!.isNotEmpty) {
          _fixedWorkingHours = store.workingTime!.fixedHours;
        }
      }
      if (store.workingTime!.customizedHours != null) {
        _customizedWorkingHours = store.workingTime!.customizedHours;
        _dayWorkingHours = store.workingTime!.customizedHours!;
        _customizedWorkingHours!.forEach((day, values) {
          // Map the dayString to a Day enum value

          // Add the mapping to the second map
          _selectedDays.add(day); //values;
        });
      }
    }
  }

  // Getters
  ValidationItem get storeName => _storeName;
  String? get workingTimeOption => _workingTimeOption;

  ValidationItem get storeCategory => _storeCategory;

  ValidationItem get storeDescription => _storeDescription;
  ValidationItem get storeRegistrationNumber => _storeRegistrationNumber;

  bool? get globalPolicy => _globalPolicy;
  bool? get customPolicy => _customPolicy;
  List<String> get selectedDays => _selectedDays;

  bool? _globalPolicy = true;
  bool? _customPolicy = false;
  TimeOfDay? get openTime => _openTime;

  TimeOfDay? get closeTime => _closeTime;
  int get timeRangeKey => _timeRangeKey;

  Address get storeAddress => _storeAddress;
  Policy? get policy => _policy;
  WorkingTime? get workingTime => _workingTime;

  List<dynamic> get storeImages => _storeImages;

  List<String> get deletedImages => _deletedImages;

  List<TimeRange>? get fixedWorkingHours => _fixedWorkingHours;

  Map<String, List<TimeRange>>? get customizedWorkingHours =>
      _customizedWorkingHours;
  Map<String, List<TimeRange>>? get dayWorkingHours => _dayWorkingHours;
  String? get errorMessage => _errorMessage;
  setPolicy(Policy? policy) {
    _policy = policy;
  }

  // checks if forms is valid and verified
  bool get isValid {
    if (_storeName.value != null &&
        _storeDescription.value != null &&
        _storeRegistrationNumber != null &&
        // (_selfPickup || _delivery) &&
        // _shopCategory.value != null &&
        _storeAddress.isAddressValid) {
      return true;
    } else {
      return false;
    }
  }

  // Setters
  void changeStoreName(String value) {
    if (value.length > 3) {
      _storeName = ValidationItem(value, null);
      notifyListeners();
    } else if (value.isEmpty) {
      _storeName = ValidationItem(null, null);
      notifyListeners();
    } else {
      _storeName = ValidationItem(null, "Name must be at least 3 characters");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changeTimeRangeKey() {
    _timeRangeKey++;
    print(_timeRangeKey);
  }

  void toggleGlobalPolicy(
    bool value,
  ) {
    _globalPolicy = value;
    if (value) {
      _customPolicy = false;

      //StoreDialogs.gobalPolicy(context!, 1);
    }
    notifyListeners();
  }

  void toggleCustomPolicy(bool value) {
    _customPolicy = value;
    if (value) {
      _globalPolicy = false;
    }

    notifyListeners();
  }

  void changeStoreCategory(int value, int index) {
    _storeCategory = ValidationItem(value.toString(), null);
    notifyListeners();
  }

  void changeStoreDescription(String value) {
    if (value.length > 20) {
      _storeDescription = ValidationItem(value, null);
      notifyListeners();
    } else if (value.isEmpty) {
      _storeDescription = ValidationItem(null, null);
      notifyListeners();
    } else {
      _storeDescription =
          ValidationItem(null, "Description must be at least 20 characters");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changeStoreRegistrationNumber(String value) {
    if (value.length > 9) {
      _storeRegistrationNumber = ValidationItem(value, null);
      notifyListeners();
    } else if (value.isEmpty) {
      _storeRegistrationNumber = ValidationItem(null, null);
      notifyListeners();
    } else {
      _storeRegistrationNumber =
          ValidationItem(null, "Please provide a valid registration number");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  /// Address Form Validators
  void changeAddress(Address newAddress) {
    _storeAddress = newAddress;
    notifyListeners();
  }

  void changeFullAddress(String value) {
    _storeAddress.fullAddress = value;
    notifyListeners();
  }

  void changeStreetName(String value) {
    _storeAddress.streetName = value;
    notifyListeners();
  }

  void changeCountry(String code, int index) {
    _storeAddress.countryCode = code;
    _storeAddress.countryName = countryList[code];
    notifyListeners();
  }

  void changeRegion(String value) {
    _storeAddress.region = value;
    notifyListeners();
  }

  void changeCity(String value) {
    _storeAddress.city = value;
    notifyListeners();
  }

  void changePostalCode(String value) {
    _storeAddress.postalCode = value;
    notifyListeners();
  }

  /// image Picker
  void addStoreImage(List<dynamic> imageList) {
    _storeImages = imageList;
    notifyListeners();
  }

  void removeStoreImage(int index) {
    _storeImages.removeAt(index);
    notifyListeners();
  }

  void changeWorkingTimeOption(String value, int index) {
    _workingTimeOption = value;
    notifyListeners();
  }

  void addFixedWorkingHours(TimeRange timeRange) {
    _fixedWorkingHours!.add(timeRange);

    notifyListeners();
  }

  void deleteFixedWorkingHours(TimeRange timeRange) {
    _fixedWorkingHours!.remove(timeRange);

    notifyListeners();
  }

  /* void addCustomizedHours(String day, TimeRange timeRanges) {
    /*  _customizedWorkingHours ??= {};
    _customizedWorkingHours![day] = [];
    _customizedWorkingHours![day]!.add(timeRanges);*/
    _customizedWorkingHours ??= {};

    if (_customizedWorkingHours![day] == null) {
      _customizedWorkingHours![day] = [];
    }

    _customizedWorkingHours![day]!.add(timeRanges);
  }
  */
  void addCustomizedHours(String day, TimeRange timeRanges) {
    _customizedWorkingHours ??= {};

    if (_customizedWorkingHours![day] == null) {
      _customizedWorkingHours![day] = [];
    }

    // Check if the time range already exists
    bool exists = _customizedWorkingHours![day]!.any((range) =>
        range.openTime == timeRanges.openTime &&
        range.closeTime == timeRanges.closeTime);
    if (exists) {
      _errorMessage = "The time range already exists";
      print(_errorMessage);
      notifyListeners();
    }
    if (!exists) {
      _customizedWorkingHours![day]!.add(timeRanges);
    }
  }

  void removeDay(String day) {
    _customizedWorkingHours?.remove(day);
  }

  void addDayDayWorkingHours(
    String day,
  ) {
    _dayWorkingHours ??= {};
    _dayWorkingHours![day] = [];
    //_dayWorkingHours![day]!.add(timeRanges);
  }

  void addDayWorkingHours(String day, TimeRange timeRanges) {
    _dayWorkingHours ??= {};

    if (_dayWorkingHours![day] == null) {
      _dayWorkingHours![day] = [];
    }

    _dayWorkingHours![day]!.add(timeRanges);
  }

  void deleteDayWorkingHours(String day, TimeRange timeRanges) {
    if (_dayWorkingHours != null && _dayWorkingHours![day] != null) {
      _dayWorkingHours![day]!.removeWhere((range) =>
          range.openTime == timeRanges.openTime &&
          range.closeTime == timeRanges.closeTime);
    }
  }

  addWorkingHours(TimeRange timeRange) {}
  void removeDayWorkingHours(String day) {
    _dayWorkingHours?.remove(day);
  }

  void deleteSelectedDay(String day) {
    _selectedDays.remove(day);
    notifyListeners();
  }

  void addSelectedDays(String day) {
    _selectedDays.add(day);

    notifyListeners();
  }

  Future<TimeOfDay?>? getStartTime(
      BuildContext context, TimeOfDay? initTime) async {
    var newOpenTime = await showTimePicker(
      context: context,
      initialTime: initTime!,
    );
    if (newOpenTime == null) {
      return initTime;
    } else {
      return newOpenTime;
    }
    //notifyListeners();
  }

  Future<TimeOfDay?> getClosingTime(
      BuildContext context, TimeOfDay? initTime) async {
    var newCloseTime =
        await showTimePicker(context: context, initialTime: initTime!);
    // notifyListeners();

    if (newCloseTime == null) {
      return initTime;
    } else {
      return newCloseTime;
    }
    // notifyListeners();
  }

  /*  if (selfPickUplMaxDays != null) {
      pickup = {"timeLimit": selfPickUplMaxDays};
    } else {
      delivery = {
        "zone": {
          "centerPoint": {
            "latitude": storeAddress.lat ?? 0.0,
            "longitude": storeAddress.lng ?? 0.0
          },
          "raduis": shippingMaxKM ?? 0
        },
        "pricing": {"fixe": shippingFixedPrice ?? 0, "km": shippingPerKm ?? 0}
      };
    }

    if (returnAccept != null && returnAccept == true) {
      returnPolicy = {
        "duration": returnMaxDays,
        "productStatus": returnCondition,
        "refund": {
          "returnMethod": returnCondition,
          "order": {"fixe": returnPerFee, "percentage": returnPerFee},
          "shipping": {"fixe": returnPerFee, "percentage": returnPerFee}
        }
      };
    }

    return {
      "policy": {
        "pickups": pickup,
        "delivery": delivery,
        "reservation": {
          "duration": reservationDuration,
          "payment": {
            "free": reservationFree,
            "partial": {"fixe": reservationtax, "percentage": reservationtax},
            "total": reservationTotal
          },
          "cancelation": {
            "restrictions": {
              "fixe": reservationcancelationtax,
              "percentage": reservationcancelationtax
            }
          }
        },
        "return": returnPolicy,
        "order": {
          "validation": {
            "auto": oredersAutoValidation,
            "manual": oredersManValidation
          },
          "notification": {
            "realtime": notifRealTime,
            "time": notifDuration,
            "perOrdersNbr": notifDuration,
            "sendMode": {
              "mail": notifEmail,
              "sms": notifSms,
              "popup": notifPopUp,
              "vibration": notifInPlateforme,
              "ringing": notifInPlateforme
            }
          }
        }
      }
    };*/

  /// A method to convert this form validator into a Store object
  FormData toFormData(Policy policy) {
    WorkingTime workingTime = WorkingTime(
        option: _workingTimeOption!,
        fixedHours: _fixedWorkingHours,
        customizedHours: _customizedWorkingHours);
    FormData _formData = FormData.fromMap({
      "name": storeName.value,
      "description": storeDescription.value,
      // "isVerified": false,
      "location": '''{
        "type": "Point",
        "coordinates": [${storeAddress.lat ?? 0.0}, ${storeAddress.lng ?? 0.0}]
      }''',
      "address": '''{
        "city": "${storeAddress.city ?? ""}",
        "streetName": "${storeAddress.streetName ?? ""}",
        "postalCode": "${storeAddress.postalCode ?? ""}",
        "fullAdress": "${storeAddress.fullAddress ?? ""}",
        "region": "${storeAddress.region ?? ""}",
        "country": "${storeAddress.countryName ?? ""}",
        "countryCode": "FR"
      }''',
      "policy": policy.toJson(),
      "workingTime": workingTime.toJson()
      //workingTime.toJson() //getWorkingHoursJson(),
    });

    // _formData.fields.add(policytoFormData);
    if (_storeImages.isNotEmpty) {
      if (_storeImages.first is File) {
        _formData.files.add(MapEntry(
            'image', MultipartFile.fromFileSync(_storeImages.first.path)));
      }
    }
    print("ff" + workingTime.toJson());
    print(_formData.toString());
    return _formData;
  }

  Map<String, dynamic> getWorkingHoursJson() {
    List<Map<String, dynamic>> _fixedHoursListJson = [];
    Map<String, List<Map<String, dynamic>>> _customizedHoursMapJson = {};

    if (_fixedWorkingHours!.isNotEmpty) {
      // Add fixed working hours to the fixedHoursList
      for (var timeRange in _fixedWorkingHours!) {
        _fixedHoursListJson.add(timeRange.toJson());
      }
    }

    if (_customizedWorkingHours != null) {
      // Add customized working hours to the customizedHoursMap
      for (var entry in _customizedWorkingHours!.entries) {
        String day = entry.key;
        List<TimeRange> timeRanges = entry.value;
        List<Map<String, dynamic>> timeRangesList = [];

        for (var timeRange in timeRanges) {
          timeRangesList.add(timeRange.toJson());
        }

        _customizedHoursMapJson[day] = timeRangesList;
      }
    }

    return {
      "option": _workingTimeOption,

      "fixedHours": _fixedHoursListJson, // Updated name here
      "customizedHours": _customizedHoursMapJson, // Updated name here
    };
  }
}
