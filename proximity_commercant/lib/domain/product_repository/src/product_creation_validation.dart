import 'dart:io';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/config/config.dart';
import 'package:proximity/domain_repository/domain_repository.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';
import 'package:proximity_commercant/domain/product_repository/models/models.dart';

import '../../store_repository/models/policy_model.dart';

class ProductCreationValidation with ChangeNotifier {
  String? _id;
  String? _storeId;

  Product? _product;

  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _description = ValidationItem(null, null);
  ValidationItem _category = ValidationItem(null, null);
  ValidationItem _price = ValidationItem(null, null);
  ValidationItem _quantity = ValidationItem("0", null);

  List<StoreCategory>? _storeRayons = [];
  List<StoreCategory>? get storeRayons => _storeRayons;

  StoreCategory _selectedRayon = StoreCategory(name: "", selected: true);
  StoreCategory get selectedRayon => _selectedRayon;

  late bool _loadingProductCategories;
  bool get loadingProductCategories => _loadingProductCategories;

  List<ProductCategory>? _productCategories = [];
  List<ProductCategory>? get productCategories => _productCategories;

  ProductCategory _selectedCategorie =
      ProductCategory(name: "", selected: true, subCategories: []);
  ProductCategory get selectedCategorie => _selectedCategorie;

  ProductSubCategory _selectedSubCategorie =
      ProductSubCategory(name: "", selected: false);
  ProductSubCategory get selectedSubCategorie => _selectedSubCategorie;

  // double? _price;
  double? _discount;
  bool? _storePolicy = true;
  bool? _hasVariants = false;
  bool? _productPolicy;
  Policy? _policy;

  // int? _quantity;
  Map<String, Set<String>> _characteristics = {};
  List<ProductVariant> _variants = [];
  List<dynamic> _images = [];

  bool _showImagePicker = false;
  bool get showImagePicker => _showImagePicker;
  bool? get storePolicy => _storePolicy;
  bool? get hasVariants => _hasVariants;

  bool? get productPolicy => _productPolicy;
  ProductCreationValidation();

  ProductCreationValidation.setProduct(Product product) {
    _product = product;
    _id = product.id;
    _storeId = product.storeId;
    _name = ValidationItem(product.name, null);
    _description = ValidationItem(product.description, null);
    _category = ValidationItem(product.categoryId, null);
    if (product.price != null) {
      _price = ValidationItem(product.price.toString(), null);
    }
    if (product.quantity != null) {
      _quantity = ValidationItem(product.quantity.toString(), null);
    }
    if (product.policy != null) {
      _policy = product.policy;
    }

    /// Setting up Characteristics
    if (product.variants != null) {
      for (var variantCharacteristic
          in product.variants!.first.characteristics!) {
        _characteristics.addAll({variantCharacteristic['name']: <String>{}});
      }
      for (var variant in product.variants!) {
        for (var variantCharacteristic in variant.characteristics!) {
          _characteristics[variantCharacteristic['name']]!
              .add(variantCharacteristic['value']);
        }
      }
    }
    if (product.variants != null &&
        product.variants!.length > 0 &&
        product.variants![0].characteristics![0]!["value"] != product.name) {
      _hasVariants = true;
    }

    /// Setting up product variants
    if (product.variants != null) {
      _variants.addAll(product.variants!);
    }

    /// Setting up product images
    if (product.images != null) {
      _images = product.images!;
    }
  }

  // Getters
  Policy? get policy => _policy;
  ValidationItem get name => _name;

  ValidationItem get description => _description;

  ValidationItem get category => _category;

  ValidationItem? get price => _price;

  double? get discount => _discount;

  //int? get quantity => _quantity;
  ValidationItem? get quantity => _quantity;
  //

  Map<String, Set<String>> get characteristics => _characteristics;

  String get characteristicsTitle {
    if (_characteristics.isEmpty) {
      return "Add options.";
    } else {
      return "${_characteristics.entries.map((e) => "${e.key}(${e.value.length})").toList()}"
          .replaceAll("[", "")
          .replaceAll("]", "");
    }
  }

  List get characteristicsList {
    if (_characteristics.isEmpty) {
      return [];
    } else {
      var myList = _characteristics.keys.toList();

      return myList;
    }
  }

  List<ProductVariant> get variants => _variants;

  int get variantsMaxSize {
    int _maxSize = 1;
    for (Set<String> e in _characteristics.values) {
      _maxSize = e.length * _maxSize;
    }
    if (_maxSize < 17) {
      return _maxSize;
    } else {
      return 16;
    }
  }

  List<dynamic> get images => _images;

  // checks if forms is valid and verified
  bool get isValid {
    if (_name.value != null && _description.value != null) {
      return true;
    } else {
      return false;
    }
  }

  // Setters
  setPolicy(Policy? policy) {
    _policy = policy;
    print("policyyyy " + _policy!.toJson().toString());
    notifyListeners();
  }

  void toggleStorePolicy(
    bool value,
  ) {
    _storePolicy = value;
    if (value) {
      _productPolicy = false;

      //StoreDialogs.gobalPolicy(context!, 1);
    }
    notifyListeners();
  }

  void toggleVariants(
    bool value,
  ) {
    _hasVariants = value;
    if (value) {
      //  _productPolicy = false;

      //StoreDialogs.gobalPolicy(context!, 1);
    }
    notifyListeners();
  }

  void changeName(String value) {
    if (value.isEmpty) {
      _name = ValidationItem(null, null);
      notifyListeners();
    } else if (value.length > 3) {
      _name = ValidationItem(value, null);
      notifyListeners();
    } else {
      _name = ValidationItem(null, "Name must be at least 3 characters");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changeDescription(String value) {
    if (value.isEmpty) {
      _description = ValidationItem(null, null);
      notifyListeners();
    } else if (value.length > 20) {
      _description = ValidationItem(value, null);
      notifyListeners();
    } else {
      _description =
          ValidationItem(null, "Description must be at least 20 characters");
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changeCategory(String value, int index) {
    _category = ValidationItem(value, null);
    notifyListeners();
  }

  void changePrice(String value) {
    if (value == '') {
      // _price = ValidationItem(null, null);
    } else {
      bool _priceValid = RegExp(r'^\d+(\.\d{1,3})?$').hasMatch(value);
      if (_priceValid) {
        _price = ValidationItem(value, null);
      } else {
        _price = ValidationItem(null, "● Enter a valid price (e.g., 12.99).");
      }
    }

    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changeDiscount(double value) {
    _discount = value;
    notifyListeners();
  }

  /* void changeQuantity(String value) {
    _quantity = int.tryParse(value);
    notifyListeners();
  }*/
  void changeQuantity(String value) {
    if (value == '') {
      _quantity = ValidationItem(null, null);
      notifyListeners();
    } else {
      int? quantity = int.tryParse(value);
      if (quantity != null && quantity > 0) {
        _quantity = ValidationItem(value, null);
        notifyListeners();
      } else {
        _quantity = ValidationItem(null, "Enter a valid quantity.");
      }
    }
    Future.delayed(largeAnimationDuration, () {
      notifyListeners();
    });
  }

  void changeCharacteristics(Map<String, Set<String>> newCharacteristics) {
    _characteristics =
        newCharacteristics.map((key, value) => MapEntry(key, value.toSet()));
    _variants = [];
    notifyListeners();
  }

  /// variant creator
  void addVariant(ProductVariant variant) {
    _variants.add(variant);
    notifyListeners();
  }

  void removeVariant(int index) {
    _variants.removeAt(index);
    notifyListeners();
  }

  /// image Picker
  void addProductImage(List<dynamic> imageList) {
    _images = imageList;
    notifyListeners();
  }

  void removeProductImage(int index) {
    //if (_shopImages[index] is String) _deletedImages.add(_shopImages[index]);
    _images.removeAt(index);
    notifyListeners();
  }

  void setShowImagePicker() {
    if (_showImagePicker == true) {
      _showImagePicker = false;
    } else {
      _showImagePicker = true;
    }

    notifyListeners();
  }

  String _variantsFormData() {
    String _formData = "[";
    List<String> _car = [];
    for (var v in _variants) {
      _formData += '{"characterstics": [';

      for (var c in v.characteristics!) {
        if (c is MapEntry<String, dynamic>) {
          _formData += '''{
          "name": "${c.key}",
          "value": "${c.value}"
        },''';
        } else {
          _formData += '''{
          "name": "${c["name"]}",
          "value": "${c["value"]}"
        },''';
        }
      }
      if (_formData.endsWith(',')) {
        _car = _formData.characters.toList();
        _car.removeLast();
        _formData = _car.join("");
      }
      _formData += '], "price": ${v.price}, "quantity": ${v.quantity}},';
    }
    if (_formData.endsWith(',')) {
      _car = _formData.characters.toList();
      _car.removeLast();
      _formData = _car.join("");
    }
    _formData += "]";
    return _formData;
  }

  String productToVariant() {
    String _formData = "[";
    List<String> _car = [];
    _formData += '{"characterstics": [';
    _formData += '''{
          "name": "option",
          "value": "${name.value}"
        }''';

    _formData +=
        '], "price": ${double.parse(price!.value!)}, "quantity": ${_quantity.value!}},';
    if (_formData.endsWith(',')) {
      _car = _formData.characters.toList();
      _car.removeLast();
      _formData = _car.join("");
    }
    _formData += "]";
    return _formData;
  }

  /// A method to convert this form validator into a Store object
  FormData toFormData(Policy? policy) {
    print("im here for adding product");
    // print("policyyyy " + _policy!.toJson().toString());

    print("init price");
    // print(productToVariant());
    var productPrice = 0.0;

    var variants = "";

    print("_variants");

    if (price != null && price!.value != null && hasVariants == false) {
      print("product price");
      productPrice = double.parse(price!.value!);
      variants = productToVariant();
    } else if (_variants.isNotEmpty && hasVariants == true) {
      print("variantes prices");
      productPrice = _variants[0].price!;
      for (var v in _variants) {
        if (v.price! < productPrice) productPrice = v.price!;
      }
      print(productPrice);
      variants = _variantsFormData();
    }

    print({
      "name": name.value,
      "description": description.value,
      "categoryId": category.value,
      "price": productPrice,
      // "discount": discount,
      "variantes": variants,
      "storeId": _storeId,
      "policy": policy?.toJson(),
    });
    FormData _formData = FormData.fromMap({
      "name": name.value,
      "description": description.value,
      "storeCategoryId": _selectedCategorie.storeCategoryDBId,
      "categoryId": _selectedCategorie.dbId,
      "subCategoryId": _selectedSubCategorie.dbId,
      "rayonId": _selectedRayon.dbId,
      "price": productPrice,
      // "discount": discount,
      "variantes": variants,
      "storeId": _storeId,
      "policy": policy?.toJson(),
    });

    if (_images.isNotEmpty) {
      for (var v in _images) {
        if (v is File) {
          print("pt ; " + v.path);

          _formData.files
              .add(MapEntry('images', MultipartFile.fromFileSync(v.path)));
        }
      }
    }
    // to do remooooove
    if (_variants.isNotEmpty) {
      for (ProductVariant v in _variants) {
        if (v.image is File) {
          print("pt ; " + v.image.path);
          _formData.files.add(MapEntry(
              'varientsImages', MultipartFile.fromFileSync(v.image.path)));
        }
      }
    }

    if (_variants.isEmpty && _images.isNotEmpty) {
      _formData.files.add(MapEntry(
          'varientsImages', MultipartFile.fromFileSync(_images[0].path)));
    }
    print(_formData);
    return _formData;
  }

  Future getStoreCatsRayons() async {
    /// open hive box
    print("start service of store rayons");
    _loadingProductCategories = true;
    notifyListeners();
    var credentialsBox = Boxes.getCredentials();
    String _token = credentialsBox.get('token');

    try {
      if (_storeId == null) {
        print('store id not found ');
      } else {
        Dio dio = Dio();
        dio.options.headers["token"] = "Bearer $_token";

        var res = await dio
            .get(BASE_API_URL + '/store/seller/store/catRayons/' + _storeId!);
        if (res.statusCode == 200) {
          print(res.data);

          _storeRayons = [];
          _storeRayons!.addAll(
              StoreCategory.storeCategoriesFromJsonList(res.data["rayons"]));

          notifyListeners();

          _productCategories = [];
          _productCategories!.addAll(
              ProductCategory.productCategoriesFromJsonList(res.data["cats"]));

          notifyListeners();

          if (_product != null && _product!.categoryId != null) {
            var cats = _productCategories!
                .where((element) => element.dbId == _product!.categoryId)
                .toList();
            if (cats.isNotEmpty) {
              _selectedCategorie = cats[0];
              print(_selectedCategorie.name);

              notifyListeners();
              var subCats = cats[0]
                  .subCategories!
                  .where((element) => element.dbId == _product!.subCategoryId)
                  .toList();
              if (subCats.isNotEmpty) {
                _selectedSubCategorie = subCats[0];
                print(_selectedSubCategorie.name);

                notifyListeners();
              }
            }
          }

          if (_product != null && _product!.rayonId != null) {
            var rayons = _storeRayons!
                .where((element) => element.dbId == _product!.rayonId)
                .toList();
            if (rayons.isNotEmpty) {
              _selectedRayon = rayons[0];
              notifyListeners();
              print(_selectedRayon.name);
              notifyListeners();
            }
          }

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

      _loadingProductCategories = false;
      notifyListeners();
    }
  }

  // Setters
  void changeSelectedCategorie(ProductCategory value, int index) {
    print("changeSelectedStoreCategory");
    print(_selectedCategorie!.name);
    print(value.name);
    _selectedCategorie = value;
    _selectedSubCategorie = ProductSubCategory(name: "", selected: true);
    notifyListeners();
  }

  void changeSelectedRayon(StoreCategory value, int index) {
    print("changeSelectedStoreCategory");
    print(_selectedRayon!.name);
    print(value.name);
    _selectedRayon = value;
    notifyListeners();
  }

  void changeSelectedSubCategorie(ProductSubCategory value, int index) {
    print("changeSelectedStoreCategory");
    print(_selectedSubCategorie!.name);
    print(value.name);
    _selectedSubCategorie = value;
    notifyListeners();
  }
}
