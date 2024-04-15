import 'dart:convert';
import 'dart:math';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/src/boxes.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/product_sale.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/product_view.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/region_sale.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/region_view.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/store_sale.dart';
import 'package:proximity_commercant/domain/statistic_repository/models/store_view.dart';

import '../../store_repository/models/store_model.dart';

class StatisticService with ChangeNotifier {
  List<StoreView> _storeViews = [];
  List<ProductView> _productViews = [];
  List<RegionView> _regionsViews = [];
  int _totalViews = 0;
  List<StoreSale> _storeSales = [];
  List<ProductSale> _productSales = [];
  List<RegionSale> _regionsSales = [];
  int _totalSales = 0;
  String _period = "week";
  Map<String, int> _monthlyViews = {};

  // essential values for the UI
  late bool _loading;
  late bool _formsLoading;

  bool get loading => _loading;

  List<StoreView>? get storeViews => _storeViews;
  List<ProductView>? get productViews => _productViews;
  List<RegionView>? get regionsViews => _regionsViews;

  List<StoreSale>? get storeSales => _storeSales;
  List<ProductSale>? get productSales => _productSales;
  List<RegionSale>? get regionsSales => _regionsSales;
  Map<String, int> get monthlyViews => _monthlyViews;
  int get totalSales => _totalSales;
  int get totalViews => _totalViews;
  String get period => _period;

  set stores(List<Store>? stores) {
    //_stores = stores;
    notifyListeners();
  }

  StatisticService() {
    _loading = false;
    _formsLoading = false;
    getTotalViews();
    getStoresviews();
    getProductViews();
    getRegionsViews();
    getMonthlyviews();
    getTotalSales();
    getStoresSales();
    getProductSales();
    getRegionsSales();
  }

  void changeStatisticPeriod(String period, int index) {
    _period = period;
    print('_period');
    print(_period);
    getTotalViews();
    getStoresviews();
    getProductViews();
    getRegionsViews();

    notifyListeners();
  }

  Future<void> getTotalViews() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res =
          await dio.get(BASE_API_URL + '/view/$_id/?timePeriod=${_period}'); //
      _loading = false;
      print("stRvTot " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _totalViews = res.data["totalViews"];
        print("stRvTot " + _totalViews.toString());
        // _storesRevenues!.addAll();
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

  Future<void> getStoresviews() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res = await dio
          .get(BASE_API_URL + '/view/store/$_id/?timePeriod=${_period}');
      _loading = false;
      print("stRv " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _storeViews = [];
        _storeViews.addAll(StoreView.storeViewsFromJsonList(res.data));

        // _storesRevenues!.addAll();
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

  Future<void> getProductViews() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res = await dio
          .get(BASE_API_URL + '/view/product/$_id/?timePeriod=${_period}');
      _loading = false;
      print("stRv " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _productViews = [];
        _productViews.addAll(ProductView.productsViewFromJsonList(res.data));

        // _storesRevenues!.addAll();
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

// Function to calculate the average of a list of double values
  double calculateAverage(List<double> values) {
    if (values.isEmpty) {
      return 0.0; // Handle the case when the list is empty
    }
    double sum = values.reduce((a, b) => a + b);
    return sum / values.length;
  }

  Future<void> getRegionsViews() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res = await dio
          .get(BASE_API_URL + '/view/region/$_id/?timePeriod=${_period}');
      _loading = false;
      print("stRv " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _regionsViews = [];
        _regionsViews!.addAll(RegionView.regionsViewsFromJsonList(res.data));
        // _storesRevenues!.addAll();
        print("stRvreg" + res.toString());
        print("stRvreg" + regionsViews![1].regionName.toString());
        print(
            "stRv *///////////////////////////////////////////////////////////////////////////");
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

  Future<void> getMonthlyviews() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res = await dio.get(BASE_API_URL + '/view/monthly/$_id');
      _loading = false;
      print("mnt1 " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        Map<String, dynamic> jsonData = {};
        try {
          Map<String, dynamic> jsonData = res.data["totalViews"];

          jsonData.forEach((date, views) {
            _monthlyViews[date] =
                views as int; // Make sure 'views' is cast to int
          });

          print("mnt3" + _monthlyViews.entries.toString());
        } catch (e) {
          print("mnt" + e.toString());
        }
      }

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
    }
  }

  Future<void> getTotalSales() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res =
          await dio.get(BASE_API_URL + '/sale/$_id/?timePeriod=${_period}'); //
      _loading = false;
      print("stRv " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _totalSales = res.data["totalSales"];
        _storeSales.addAll(StoreSale.storeSalesFromJsonList(res.data));

        // _storesRevenues!.addAll();
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

  Future<void> getStoresSales() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res = await dio
          .get(BASE_API_URL + '/sale/store/$_id/?timePeriod=${_period}');
      _loading = false;
      print("stRv " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _storeSales = [];
        _storeSales.addAll(StoreSale.storeSalesFromJsonList(res.data));

        // _storesRevenues!.addAll();
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

  Future<void> getProductSales() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res = await dio
          .get(BASE_API_URL + '/sale/product/$_id/?timePeriod=${_period}');
      _loading = false;
      print("stRv " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _productSales = [];
        _productSales.addAll(ProductSale.productsSaleFromJsonList(res.data));

        // _storesRevenues!.addAll();
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

  // Function to calculate conversion rates for a list of ProductIncome objects
  /*double calculateProducyConversionRates() {
    List<double> conversionRates = [];

    for (ProductIncome product in _productsIncome!) {
      if (product.numberOfSales == 0) {
        conversionRates.add(
            0.0); // Avoid division by zero, you can handle this case accordingly
      } else {
        double conversionRate = product.numberOfSales / product.numberOfSales;
        conversionRates.add(conversionRate);
      }
    }
    if (conversionRates.isEmpty) {
      return 0.0; // Handle the case when the list is empty
    }
    double sum = conversionRates.reduce((a, b) => a + b);
    return sum / conversionRates.length;
  }*/

// Function to calculate the average of a list of double values

  /*Future<void> getProductsSales() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res = await dio.get(BASE_API_URL + '/sale/product/$_id');
      _loading = false;
      print("stRv " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _productSales = [];
        _productSales!.addAll(ProductSale.productsSaleFromJsonList(res.data));
        // _storesRevenues!.addAll();
        print("stRv" + res.toString());
        print("stRv" + _productSales!.length.toString());
        print(
            "stRv */ //////////////////////////////////////////////////////////////////////////");
  /*    notifyListeners();
    
    }on DioError catch (e) {
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
*/
  Future<void> getRegionsSales() async {
    _loading = true;
    notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    String _id = credentialsBox.get('id');
    print("_token : " + _token);

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      //var res = await dio.get(BASE_API_URL + '/store/seller/' + _id);
      var res = await dio
          .get(BASE_API_URL + '/sale/region/$_id/?timePeriod=${_period}');
      _loading = false;
      print("stRv " + res.toString());
      notifyListeners();
      if (res.statusCode == 200) {
        _regionsSales = [];
        _regionsSales!.addAll(RegionSale.regionsSalesFromJsonList(res.data));
        // _storesRevenues!.addAll();
        print("stRvreg" + res.toString());
        print("stRvreg" + regionsSales![1].regionName.toString());
        print(
            "stRv *///////////////////////////////////////////////////////////////////////////");
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
}
