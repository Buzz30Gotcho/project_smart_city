import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/domain/product_repository/models/offer_model.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';

class ProductService with ChangeNotifier {
  late List<Product>? _products;
  late List<dynamic>? _productsOffers;
  late int _currentPage;
  late bool _fetchMore;
  String? _idStore;
  DateTime _selectedDate = DateTime.now();
  String? _formattedDate;
  String? _discountType = 'percentage';
  int? _discountAmount;
  int? _discountPercentage;
  int? _offerStock;
  String? _discountAmountPercentage;

  bool? _isPercentage;

  // essential values for the UI
  late bool _loading;
  late bool _formsLoading;
  String? _offerId;
  // getters
  List<Product>? get products => _products;
  List<dynamic>? get productsOffers => _productsOffers;

  bool get fetchMore => _fetchMore;

  String? get idStore => _idStore;
  bool? get isPercentage => _isPercentage;
  bool get loading => _loading;
  bool get formsLoading => _formsLoading;
  String? get discountType => _discountType;
  int? get discountAmount => _discountAmount;
  int? get discountPercentage => _discountPercentage;
  int? get offerStock => _offerStock;
  Offer? _productOffer;
  Offer? get productOffer => _productOffer;
  DateTime get selectedDate => _selectedDate;
  String? get formattedDate => _formattedDate;
  String? get discountAmountPercentage => _discountAmountPercentage;
  // setters
  set idStore(String? idStore) {
    _idStore = idStore;
    notifyListeners();
  }

  set products(List<Product>? products) {
    _products = products;
    notifyListeners();
  }

  // constructor
  ProductService() {
    _currentPage = 1;
    _fetchMore = true;
    _idStore = idStore;
    _loading = false;
    _formsLoading = false;
    _isPercentage = _discountType == 'amount' ? false : true;
    getStoreProducts();
  }

  reloadList(ProductProxy productProxy) {
    if (_idStore != productProxy.idStore) {
      _currentPage = 1;
      _fetchMore = true;
      _idStore = productProxy.idStore;
      getStoreProducts();
    }
  }

  Future getStoreProducts({String? rayonId = null}) async {
    _products = null;
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      FormData _formData = FormData();
      if (rayonId != null) {
        _formData = FormData.fromMap({"rayonId": rayonId});
      }

      var res = await dio.post(BASE_API_URL + '/product/store/$idStore',
          data: _formData);
      _loading = false;

      notifyListeners();
      if (res.statusCode == 200) {
        _products = [];
        _products!.addAll(Product.productsFromJsonList(res.data));
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
  }

  List<Product>? getProductsWIthoutDiscount() {
    List<Product>? _productsWIthoutDiscount = [];
    for (Product product in _products!) {
      if (product.discount == 0.0) {
        _productsWIthoutDiscount!.add(product);
      }
    }

    return _productsWIthoutDiscount;
  }

  Future getProduct(String id) async {
    Future.delayed(const Duration(seconds: 4), () {
      notifyListeners();
    });
  }

  void changeDisountType(String value, int index) {
    _discountType = value;
    if (value == "percentage") {
      _isPercentage = true;
    } else {
      _isPercentage = false;
    }

    notifyListeners();
  }

  void changeDisountPercentage(String value, int index) {
    _discountPercentage = int.parse(value);

    notifyListeners();
  }

  void changeDiscountAmount(String value, int index) {
    _discountAmount = int.parse(value);
    _discountAmountPercentage = percentageValues[_discountAmount.toString()];

    notifyListeners();
  }

  void changeOfferStock(String value) {
    _offerStock = int.tryParse(value);
    notifyListeners();
  }

  Future getProductByIndex(int index) async {
    Future.delayed(const Duration(seconds: 4), () {
      notifyListeners();
    });
  }

  Future getSelectableProducts() async {
    if (_idStore == null) {
      _products = [];
      return;
    }
    Future.delayed(const Duration(seconds: 3), () {
      _products!.addAll(
          Product.products.where((product) => product.storeId == _idStore));
      notifyListeners();
    });
  }

  Future addProduct(BuildContext context, FormData formData) async {
    _formsLoading = true;
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
      formData.fields.add(MapEntry("sellerId", _id));
      var res = await dio.post(BASE_API_URL + '/product', data: formData);
      if (res.statusCode == 200) {
        /// Save new Store Data
        _products!.add(Product.fromJson(res.data));
        notifyListeners();

        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);
        Navigator.pop(context);
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
    _formsLoading = false;
    notifyListeners();
  }

  Future editProductDiscount(
      BuildContext context, int index, int? discount) async {
    _formsLoading = true;
    // _discountAmount = _discountAmount!;
    // discount = discount! / 100;
    FormData formData;
    notifyListeners();
    if (discount != null) {
      formData = FormData.fromMap({
        "discount": discount,
      });
    } else {
      formData = FormData.fromMap({
        "discount": _discountAmount,
      });
    }

    //"discountType": discountType});

    print('form data' + formData.fields.toString());

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";

      formData.fields.add(MapEntry("sellerId", _id));
      formData.fields.add(MapEntry("storeId", idStore!));

      var res = await dio.put(BASE_API_URL + '/product/${_products![index].id}',
          data: formData);

      print("res" + res.statusCode.toString());
      if (res.statusCode == 200) {
        /// Save new Store Data
        var id = _products![index].id;
        _products!.removeWhere((person) => person.id == id);
        _products!.add(Product.fromJson(res.data));

        notifyListeners();

        /// Display Results Message
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);

        /// Display Error Response
      } else {
        /// Display Error Message
      }
    }
    _formsLoading = false;
    notifyListeners();
  }

  Future editProduct(BuildContext context, int index, FormData formData) async {
    _formsLoading = true;
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

      formData.fields.add(MapEntry("sellerId", _id));
      var res = await dio.put(BASE_API_URL + '/product/${_products![index].id}',
          data: formData);

      if (res.statusCode == 200) {
        /// Save new Store Data
        _products![index] = Product.fromJson(res.data);

        notifyListeners();

        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);
        Navigator.pop(context);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);

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
    _formsLoading = false;
    notifyListeners();
  }

  Future<bool> deleteProduct(String id) async {
    /// open hive box
    var credentialsBox = Boxes.getCredentials();

    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      var res = await dio.delete(BASE_API_URL + '/product/$id');
      if (res.statusCode == 200) {
        /// Save new Store Data
        _products!.removeWhere((element) => element.id == id);
        notifyListeners();

        /// return True
        return true;
      }
    } on DioError catch (e) {
      if (e.response != null) {
      } else {}
    }
    return false;
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _formattedDate == DateFormat('yyyy-MM-dd').format(_selectedDate);
    notifyListeners();
  }

  FormData toFormData() {
    FormData _formData = FormData.fromMap({
      'discountType': _discountType,
      'offerDiscount': (_discountPercentage! / 100),
      'offerStock': _offerStock,
      'offerExpiration': _selectedDate
    });
    print({
      'discountType': _discountType,
      'offerDiscount': (_discountPercentage! / 100),
      'offerStock': _offerStock,
      'offerExpiration': _selectedDate
    });
    return _formData;
  }

  getOffer(String id) async {
    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();

      dio.options.headers["token"] = "Bearer $_token";
      // var res = await dio.get(BASE_API_URL + '/offer/all/$idStore');
      var res = await dio.get(BASE_API_URL + '/offer/$id');

      _loading = false;

      notifyListeners();
      if (res.statusCode == 200) {
        // print("res data : " + res.data);

        _productOffer = Offer.fromJson(res.data);
        if (_productOffer != null) {
          if (!_productOffer!.offerDeleted!) {
            _offerId = _productOffer!.id;
            _discountAmount = _productOffer!.offerDiscount;
            _discountType = _productOffer!.discountType;
            _offerStock = _productOffer!.offerStock;
            _formattedDate = DateFormat('yyyy-MM-dd')
                .format(_productOffer!.offerExpiration!);

            _discountAmountPercentage =
                percentageValues[_discountAmount.toString()];
          }

          //print("ds" + _discountAmountPercentage!);
        }

        print('get offer' + _discountAmount.toString());
        print('get offer' + _formattedDate.toString());
        print('get offer' + percentageValues['10']!);

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
  }

  updateOffer(FormData formData) async {
    /// open hive box
    _formsLoading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      debugPrint("Offer update form");

      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";

      var res = await dio.put(BASE_API_URL + '/offer/update/$_offerId',
          data: formData);

      if (res.statusCode == 200) {
        /// Save new Store Data

        //  stores!.add(Store.fromJson(res.data));

        _formsLoading = false;
        notifyListeners();

        Future.delayed(largeAnimationDuration, () {
          notifyListeners();
        });

        // Navigator.pop(context);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('errr');
        print(e.response);
      } else {
        print('errr');
      }
    }
    _formsLoading = false;
    notifyListeners();
  }

  archiveOffer(BuildContext context, String offerId, String id) async {
    /// open hive box
    _formsLoading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      debugPrint('offerid' + offerId.toString());

      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      print('offerarchive' + offerId.toString());
      var res = await dio.delete(BASE_API_URL + '/offer/delete/$offerId');
      print('offerarchive' + res.statusCode.toString());
      if (res.statusCode == 200) {
        /// Save new Store Data
        _discountAmount = null;
        _offerStock = null;

        _formsLoading = false;
        notifyListeners();
        getProduct(id);
        getStoreProducts();
        Navigator.pop(context);

        Future.delayed(largeAnimationDuration, () {
          notifyListeners();
        });

        // Navigator.pop(context);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
      } else {
        print('errr');

        // Display Error Message
      }
    }
    _formsLoading = false;
    notifyListeners();
  }

  Future createOffer(BuildContext context, FormData formData, String id) async {
    _formsLoading = true;
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
      /* formData.fields.add(MapEntry("sellerId", _id));
      formData.fields.add(MapEntry("storeId", _idStore!));*/
      formData.fields.add(MapEntry("productId", id));

      var res = await dio.post(BASE_API_URL + '/offer/create', data: formData);

      if (res.statusCode == 200) {
        notifyListeners();
        getProduct(id);
        getStoreProducts();
        Navigator.pop(context);
        _formsLoading = false;

        /// Display Results Message
        //  ToastSnackbar().init(context).showToast(
        //      message: "${res.statusMessage}", type: ToastSnackbarType.success);
        Future.delayed(largeAnimationDuration, () {
          notifyListeners();
        });

        // Navigator.pop(context);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);

        /// Display Error Response
        /* ToastSnackbar()
            .init(context)
            .showToast(message: "${e.response}", type: ToastSnackbarType.error);*/
      } else {
        print('errr');

        /// Display Error Message
        /* ToastSnackbar()
            .init(context)
            .showToast(message: "${e.message}", type: ToastSnackbarType.error);*/
      }
    }
    _formsLoading = false;
    notifyListeners();
  }
}
