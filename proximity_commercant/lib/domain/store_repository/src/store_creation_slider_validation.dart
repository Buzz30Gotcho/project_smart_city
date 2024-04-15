import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/domain/store_repository/models/workingTime_model.dart';

import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

class StoreCreationSliderValidation with ChangeNotifier {
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

  StoreCreationSliderValidation();

  StoreCreationSliderValidation.setStore(Store store) {
    _id = store.id;
    _storeName = ValidationItem(store.name, null);
    // _storeCategory = ValidationItem(store.category?.toString(), null);
    _storeDescription = ValidationItem(store.description, null);

    if (store.address != null) {
      _storeAddress = store.address!;
    }
    if (store.policy != null) {
      setPolicy(store.policy);
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

  late bool _loadingStoreCategories;
  bool get loadingStoreCategories => _loadingStoreCategories;

  List<StoreCategory>? _storeCategories = [];
  List<StoreCategory>? get storeCategories => _storeCategories;

  StoreCategory? _selectedStoreCategorie =
      StoreCategory(name: "", selected: true);
  StoreCategory? get selectedStoreCategorie => _selectedStoreCategorie;

  List<StoreCategory>? _storeRayons = [];
  List<StoreCategory>? get storeRayons => _storeRayons;

  late bool _loadingProductCategories;
  bool get loadingProductCategories => _loadingProductCategories;

  List<ProductCategory>? _productCategories = [];
  List<ProductCategory>? get productCategories => _productCategories;

  List<StoreCategory> templates = [
    StoreCategory(id: 1, name: 'Template 1', selected: true),
    StoreCategory(id: 2, name: 'Template 2', selected: false),
    // Add more categories and subcategories as needed
  ];
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
  void changeSelectedStoreCategory(StoreCategory value, int index) {
    print("changeSelectedStoreCategory");
    print(_selectedStoreCategorie!.name);
    print(value.name);
    _selectedStoreCategorie = value;
    notifyListeners();
  }

  // Setters
  void changeStoreCategories(List<StoreCategory> value) {
    _storeCategories = value;
    notifyListeners();
  }

  void changeSelectStoreCategorie(value, id,
      {bool? check_deselect = false, BuildContext? context = null}) {
    print(check_deselect);
    var index = storeCategories!.indexWhere((element) => element.id == id);
    if (index != -1) {
      if (value == true ||
          check_deselect != true ||
          (check_deselect == true &&
              storeCategories![index].product_count! <= 0)) {
        print(storeCategories![index].product_count);
        storeCategories![index].selected = value!;
        notifyListeners();
      } else {
        ToastSnackbar().init(context!).showToast(
            message: "you must first move its products to another category",
            type: ToastSnackbarType.error);
      }
    }
  }

  void addStoreCategorie(name) {
    final newStoreCategoryId = storeCategories!.length + 1;
    final newStoreCategory = StoreCategory(
        id: newStoreCategoryId,
        name: name,
        selected: false,
        dbId: null,
        product_count: 0);
    storeCategories!.add(newStoreCategory);
    notifyListeners();
  }

  void initStoreRayons(value) {
    _storeRayons = [];
    _storeRayons!.addAll(value);
    notifyListeners();
  }

  void changeSelectStoreRayons(value, id,
      {bool? check_deselect = false, BuildContext? context = null}) {
    var index = storeRayons!.indexWhere((element) => element.id == id);
    if (index != -1) {
      if (value == true ||
          check_deselect != true ||
          (check_deselect == true && storeRayons![index].product_count! <= 0)) {
        print(storeRayons![index].product_count);
        storeRayons![index].selected = value!;
        notifyListeners();
      } else {
        ToastSnackbar().init(context!).showToast(
            message: "you must first move its products to another rayon",
            type: ToastSnackbarType.error);
      }
    }
  }

  void changeSelectStoreTemplate(value, id) {
    templates = templates.map((e) {
      if (e.id == id) {
        return StoreCategory(
            id: e.id, name: e.name, selected: (value ?? false));
      } else {
        return StoreCategory(
            id: e.id, name: e.name, selected: !(value ?? false));
      }
    }).toList();

    notifyListeners();
  }

  void addStoreRayon(name) {
    final newStoreRayonId = storeRayons!.length + 1;
    final newStoreRayon = StoreCategory(
        id: newStoreRayonId,
        name: name,
        selected: false,
        dbId: null,
        product_count: 0);
    storeRayons!.add(newStoreRayon);
    notifyListeners();
  }

  void changeSelectProductCategorie(value, index,
      {bool? check_deselect = false, BuildContext? context = null}) {
    if (index != -1) {
      if (value == true ||
          check_deselect != true ||
          (check_deselect == true &&
              productCategories![index].product_count! <= 0)) {
        print(productCategories![index].product_count);
        productCategories![index].selected = value!;
        notifyListeners();
      } else {
        ToastSnackbar().init(context!).showToast(
            message: "you must first move its products to another category",
            type: ToastSnackbarType.error);
      }
    }
  }

  void addProductCategorie(name, context) {
    if (selectedStoreCategorie != null && selectedStoreCategorie!.name != "") {
      final newProductCategoryId = productCategories!.length + 1;
      final newProductCategory = ProductCategory(
          id: newProductCategoryId,
          name: name,
          selected: false,
          subCategories: [],
          dbId: null,
          storeCategoryDBId: selectedStoreCategorie!.dbId,
          storeCategoryId: selectedStoreCategorie!.id,
          product_count: 0);
      productCategories!.add(newProductCategory);
      notifyListeners();
    } else {
      ToastSnackbar().init(context).showToast(
          message: "You must select a store category firstly",
          type: ToastSnackbarType.error);
    }
  }

  void addProductSubCategorie(name, parentIndex) {
    final newProductSubCategoryId =
        productCategories![parentIndex].subCategories.length + 1;
    final newProductSubCategory = ProductSubCategory(
        id: newProductSubCategoryId,
        name: name,
        selected: false,
        dbId: null,
        product_count: 0);
    productCategories![parentIndex].subCategories.add(newProductSubCategory);
    notifyListeners();
  }

  void changeSelectProductSubCategorie(value, id, parentIndex,
      {bool? check_deselect = false, BuildContext? context = null}) {
    var index = productCategories![parentIndex]
        .subCategories
        .indexWhere((element) => element.id == id);
    if (index != -1) {
      if (value == true ||
          check_deselect != true ||
          (check_deselect == true &&
              productCategories![parentIndex]
                      .subCategories[index]
                      .product_count! <=
                  0)) {
        print(
            productCategories![parentIndex].subCategories[index].product_count);
        productCategories![parentIndex].subCategories[index].selected = value!;
        if (value! == true &&
            productCategories![parentIndex].selected == false) {
          productCategories![parentIndex].selected = true;
        }
        if (productCategories![parentIndex]
            .subCategories
            .where((element) => element.selected == true)
            .isEmpty) {
          productCategories![parentIndex].selected = false;
        }
        // productCategories![parentIndex].selected =
        //     checkIfAllSubCategoriesSelected(parentIndex);
        notifyListeners();
      } else {
        ToastSnackbar().init(context!).showToast(
            message: "you must first move its products to another category",
            type: ToastSnackbarType.error);
      }
    }
  }

  bool checkIfAllSubCategoriesSelected(int categoryIndex) {
    return productCategories![categoryIndex]
        .subCategories
        .every((subProductCategory) => subProductCategory.selected);
  }

  void selectAllSubCategories(int categoryIndex) {
    productCategories![categoryIndex]
        .subCategories
        .forEach((subProductCategory) {
      subProductCategory.selected = true;
    });
    notifyListeners();
  }

  void deselectAllSubCategories(int categoryIndex) {
    productCategories![categoryIndex]
        .subCategories
        .forEach((subProductCategory) {
      subProductCategory.selected = false;
    });
    notifyListeners();
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
    print("changed");
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

  /// A method to convert this form validator into a Store object
  FormData toFormData(Policy policy) {
    FormData _formData = FormData();
    try {
      // Code that might throw the exception
      print("policy");
      print(storeName.value);
      WorkingTime workingTime = WorkingTime(
          option: _workingTimeOption!,
          fixedHours: _fixedWorkingHours,
          customizedHours: _customizedWorkingHours);

      // store categories
      List<Map<String, dynamic>> fdStoreCategories = [];

      var selectedStoreCategories =
          _storeCategories!.where((element) => element.selected).toList();

      fdStoreCategories = selectedStoreCategories
          .map((e) => {"id": e.dbId, "eid": e.id, "name": e.name})
          .cast<Map<String, dynamic>>()
          .toList();
      // product categories

      var selectedProductCategories =
          productCategories!.where((element) => element.selected).toList();
      selectedProductCategories = selectedProductCategories.map((e) {
        e.subCategories =
            e.subCategories.where((element) => element.selected).toList();
        return e;
      }).toList();
      List<Map<String, dynamic>> fdProductCategories = [];

      fdProductCategories = selectedProductCategories
          .map((e) {
            List<Map<String, dynamic>> fdProductSubCategories = [];
            fdProductSubCategories = e.subCategories
                .map((es) => {"id": es.dbId, "name": es.name})
                .cast<Map<String, dynamic>>()
                .toList();

            return {
              "id": e.dbId,
              "name": e.name,
              "storeCategoryDBId": e.storeCategoryDBId,
              "storeCategoryId": e.storeCategoryId,
              "subCategories": json.encode(fdProductSubCategories)
            };
          })
          .cast<Map<String, dynamic>>()
          .toList();

      // store rayons
      List<Map<String, dynamic>> fdStoreRayons = [];

      var selectedStoreRayons =
          _storeRayons!.where((element) => element.selected).toList();

      fdStoreRayons = selectedStoreRayons
          .map((e) => {"name": e.name})
          .cast<Map<String, dynamic>>()
          .toList();

      // store Template
      List<Map<String, dynamic>> fdStoreTemplates = [];

      var selectedStoreTemplate =
          templates.where((element) => element.selected).toList();
      var templateId =
          selectedStoreTemplate.isNotEmpty ? selectedStoreTemplate[0].id : null;

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
        "workingTime": workingTime.toJson(),
        "storeCategories": json.encode(fdStoreCategories),
        "productCategories": json.encode(fdProductCategories),
        "storeRayons": json.encode(fdStoreRayons),
        "template": templateId
        //workingTime.toJson() //getWorkingHoursJson(),
      });
      print("_______________________________________________");
      print(json.encode(fdStoreCategories));
      print(json.encode(fdProductCategories));

      // _formData.fields.add(policytoFormData);
      if (_storeImages.isNotEmpty) {
        if (_storeImages.first is File) {
          print("image added");
          _formData.files.add(MapEntry(
              'image', MultipartFile.fromFileSync(_storeImages.first.path)));
        }
      }
      print("ff" + workingTime.toJson());
      print(_formData.fields);
      return _formData;
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('Stack Trace: $stackTrace');
    }
    return _formData;
  }

  /// A method to convert this form validator into a Store object
  FormData updateFormData(Policy policy) {
    FormData _formData = FormData();
    try {
      // Code that might throw the exception
      print("policy");
      print(storeName.value);
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
        "workingTime": workingTime.toJson(),
        //workingTime.toJson() //getWorkingHoursJson(),
      });

      // _formData.fields.add(policytoFormData);
      if (_storeImages.isNotEmpty) {
        if (_storeImages.first is File) {
          print("image added");
          _formData.files.add(MapEntry(
              'image', MultipartFile.fromFileSync(_storeImages.first.path)));
        }
      }

      return _formData;
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('Stack Trace: $stackTrace');
    }
    return _formData;
  }

  /// A method to convert this form validator into a Store object
  FormData UpdateStoreCategoriesFormData() {
    FormData _formData = FormData();
    try {
      // store categories
      List<Map<String, dynamic>> fdStoreCategories = [];

      var selectedStoreCategories =
          _storeCategories!.where((element) => element.selected).toList();

      fdStoreCategories = selectedStoreCategories
          .map((e) => {"id": e.dbId, "name": e.name})
          .cast<Map<String, dynamic>>()
          .toList();

      FormData _formData = FormData.fromMap({
        "storeCategories": json.encode(fdStoreCategories)
        //workingTime.toJson() //getWorkingHoursJson(),
      });

      return _formData;
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('Stack Trace: $stackTrace');
    }
    return _formData;
  }

  /// A method to convert this form validator into a Store object
  FormData UpdateProductCategoriesFormData() {
    FormData _formData = FormData();
    try {
      // product categories

      var selectedProductCategories =
          productCategories!.where((element) => element.selected).toList();
      selectedProductCategories = selectedProductCategories.map((e) {
        e.subCategories =
            e.subCategories.where((element) => element.selected).toList();
        return e;
      }).toList();
      List<Map<String, dynamic>> fdProductCategories = [];

      fdProductCategories = selectedProductCategories
          .map((e) {
            List<Map<String, dynamic>> fdProductSubCategories = [];
            fdProductSubCategories = e.subCategories
                .map((e) => {"id": e.dbId, "name": e.name})
                .cast<Map<String, dynamic>>()
                .toList();

            return {
              "id": e.dbId,
              "name": e.name,
              "subCategories": json.encode(fdProductSubCategories)
            };
          })
          .cast<Map<String, dynamic>>()
          .toList();

      FormData _formData = FormData.fromMap({
        "productCategories": json.encode(fdProductCategories),
      });

      return _formData;
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('Stack Trace: $stackTrace');
    }
    return _formData;
  }

  FormData UpdateStoreRayonsFormData() {
    FormData _formData = FormData();
    try {
      // store rayons
      List<Map<String, dynamic>> fdStoreRayons = [];

      var selectedStoreRayons =
          _storeRayons!.where((element) => element.selected).toList();

      fdStoreRayons = selectedStoreRayons
          .map((e) => {"name": e.name, "id": e.dbId})
          .cast<Map<String, dynamic>>()
          .toList();

      FormData _formData = FormData.fromMap({
        "storeRayons": json.encode(fdStoreRayons),
      });

      return _formData;
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('Stack Trace: $stackTrace');
    }
    return _formData;
  }

  FormData UpdateStoreTemplateFormData() {
    FormData _formData = FormData();
    try {
      // store Template
      List<Map<String, dynamic>> fdStoreTemplates = [];

      var selectedStoreTemplate =
          templates.where((element) => element.selected).toList();
      var templateId =
          selectedStoreTemplate.isNotEmpty ? selectedStoreTemplate[0].id : null;

      FormData _formData = FormData.fromMap({"template": templateId});
      return _formData;
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('Stack Trace: $stackTrace');
    }
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

  Future getStoreCategories() async {
    /// open hive box
    _loadingStoreCategories = true;
    notifyListeners();
    var credentialsBox = Boxes.getCredentials();
    String _token = credentialsBox.get('token');

    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      var res = await dio.get(BASE_API_URL + '/storeCategory');
      if (res.statusCode == 200) {
        print(res.data);
        _storeCategories = [];
        _storeCategories!
            .addAll(StoreCategory.storeCategoriesFromJsonList(res.data));
        notifyListeners();
      }

      _loadingStoreCategories = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }

      _loadingStoreCategories = false;
      notifyListeners();
    }
  }

  Future getInitStoreCategories() async {
    /// open hive box
    _loadingStoreCategories = true;
    notifyListeners();
    var credentialsBox = Boxes.getCredentials();
    String _token = credentialsBox.get('token');

    try {
      if (_id == null) {
        print('store id not found ');
      } else {
        Dio dio = Dio();
        dio.options.headers["token"] = "Bearer $_token";
        var res = await dio.get(BASE_API_URL + '/storeCategory/store/' + _id!);
        if (res.statusCode == 200) {
          print(res.data);
          _storeCategories = [];
          _storeCategories!
              .addAll(StoreCategory.storeCategoriesFromJsonList(res.data));
          notifyListeners();
        }

        _loadingStoreCategories = false;
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

      _loadingStoreCategories = false;
      notifyListeners();
    }
  }

  Future getProductCategories() async {
    /// open hive box
    print("start service of product categories");
    _loadingProductCategories = true;
    notifyListeners();
    var credentialsBox = Boxes.getCredentials();
    String _token = credentialsBox.get('token');

    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";

      var cats = storeCategories!
          .where((element) => element.selected && element.dbId != null);
      var catsIds = cats.map((e) {
        return e.dbId;
      }).toList();
      FormData _formData = FormData.fromMap({
        "storeCategories": json.encode(catsIds),
      });
      var res = await dio.post(BASE_API_URL + '/category/storeCategory',
          data: _formData);
      if (res.statusCode == 200) {
        print(res.data);
        _productCategories = [];
        _productCategories!
            .addAll(ProductCategory.productCategoriesFromJsonList(res.data));
        notifyListeners();
      }

      _loadingProductCategories = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }

      _loadingStoreCategories = false;
      notifyListeners();
    }
  }

  Future getStoreProductCategories() async {
    /// open hive box
    print("start service of store product categories");
    _loadingProductCategories = true;
    notifyListeners();
    var credentialsBox = Boxes.getCredentials();
    String _token = credentialsBox.get('token');

    try {
      if (_id == null) {
        print('store id not found ');
      } else {
        Dio dio = Dio();
        dio.options.headers["token"] = "Bearer $_token";

        var res = await dio.post(
            BASE_API_URL + '/category/storeCategory/store/' + _id!,
            data: {});
        if (res.statusCode == 200) {
          print(res.data);

          _productCategories = [];
          _productCategories!.addAll(
              ProductCategory.productCategoriesFromJsonList(
                  res.data["ProductCategories"]));

          _storeCategories = [];
          _storeCategories!.addAll(StoreCategory.storeCategoriesFromJsonList(
              res.data["StoreCategories"]));
          notifyListeners();
        }

        _loadingProductCategories = false;
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

      _loadingStoreCategories = false;
      notifyListeners();
    }
  }

  Future getStoreRayons() async {
    /// open hive box
    print("start service of store rayons");
    _loadingProductCategories = true;
    notifyListeners();
    var credentialsBox = Boxes.getCredentials();
    String _token = credentialsBox.get('token');

    try {
      if (_id == null) {
        print('store id not found ');
      } else {
        Dio dio = Dio();
        dio.options.headers["token"] = "Bearer $_token";

        var res = await dio.get(BASE_API_URL + '/store/seller/store/' + _id!);
        if (res.statusCode == 200) {
          print(res.data);

          _storeRayons = [];
          _storeRayons!.addAll(StoreCategory.storeCategoriesFromJsonList(
              res.data["storeRayons"]));

          notifyListeners();
        }

        _loadingProductCategories = false;
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

      _loadingStoreCategories = false;
      notifyListeners();
    }
  }
}
