import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';

class OrderService with ChangeNotifier {
  List<Order>? _orders = [];

  // essential values for the UI
  late bool _loading;
  late bool _loadingOrders;
  late bool _loadingReturn;
  Map<String, double> _storeRevenueMap = {};

  List<Order>? get orders => _orders;

  bool get loading => _loading;
  bool get loadingOrders => _loadingOrders;
  bool get loadingReturn => _loadingReturn;
  Map<String, double> get storeRevenueMap => _storeRevenueMap;

  OrderService() {
    _loading = false;
    getStoreRevenu();
    print('///////////_storeRevenueMap.entries ');
    print(_storeRevenueMap.entries);
  }

  /// Pay Order
  Future payOrder(BuildContext context, FormData formData) async {
    _loading = true;
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
      var res = await dio.post(BASE_API_URL + '/order/', data: formData);
      notifyListeners();
      if (res.statusCode == 200) {
        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "Order successfully paid!",
            type: ToastSnackbarType.success);

        _loading = false;
        notifyListeners();
        return true;
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
    return false;
  } /*/*********** */ */

  void getStoreRevenu() async {
    await getOrders("delivery", "all");
    if (_orders != null) {
      calculateStoreRevenue(_orders!);
    }

    await getOrders("pickup", "all");
    if (_orders != null) {
      calculateStoreRevenue(_orders!);
    }
  }

  Map<String, double> calculateStoreRevenue(
    List<Order> orders,
  ) {
    for (Order order in orders) {
      // Check if the order's DateTime is within the desired time frame

      // If the order is from today, add its revenue to the respective store
      double price = order.totalPrice ?? 0;
      _storeRevenueMap[order.storeName!] =
          (_storeRevenueMap[order.storeName] ?? 0) + price;

      // You can similarly handle this week and this month scenarios using DateTime methods.
    }

    return _storeRevenueMap;
  }

  bool isSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }
  /**** */

  Future getOrders(String orderType, String status) async {
    print("ws lanched : $orderType [ $status ]");
    _orders = [];
    _loadingOrders = true;
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
      var res =
          await dio.get(BASE_API_URL + '/order/$orderType/$_id/status/$status');
      notifyListeners();
      if (res.statusCode == 200) {
        print("res.data.length");
        print(res.data);
        print(Order.ordersFromJsonList(res.data));
        _orders = [];
        _orders!.addAll(Order.ordersFromJsonList(res.data));
        notifyListeners();
      }
      _loadingOrders = false;
      notifyListeners();
    } on DioError catch (e) {
      _loadingOrders = false;
      notifyListeners();
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

  Future updateStatus(String orderId, String status, String? type,
      String? oldStatus, bool? reload) async {
    print("ws lanched : $orderId [ $status ]");

    // _loadingOrders = true;
    // notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      FormData _formData =
          FormData.fromMap({"status": status, "orderId": orderId});
      var res =
          await dio.post(BASE_API_URL + '/order/update/$_id', data: _formData);
      notifyListeners();
      if (res.statusCode == 200) {
        // print(res.data.length);
        if (reload == true) {
          getOrders(type ?? "", oldStatus ?? "");
        } else {
          _orders!.removeWhere((item) => item.id == orderId);
          notifyListeners();
        }
      }
      // _loadingOrders = false;
      // notifyListeners();
    } on DioError catch (e) {
      // _loadingOrders = false;
      // notifyListeners();
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

  Future returnOrderValidate(String orderId, String status, String? type,
      String? oldStatus, bool? reload) async {
    print("ws lanched : $orderId [ $status ]");

    // _loadingOrders = true;
    // notifyListeners();

    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      FormData _formData =
          FormData.fromMap({"status": status, "orderId": orderId});
      var res =
          await dio.post(BASE_API_URL + '/order/update/$_id', data: _formData);
      notifyListeners();
      if (res.statusCode == 200) {
        // print(res.data.length);
        if (reload == true) {
          getOrders(type ?? "", oldStatus ?? "");
        } else {
          _orders!.removeWhere((item) => item.id == orderId);
          notifyListeners();
        }
      }
      // _loadingOrders = false;
      // notifyListeners();
    } on DioError catch (e) {
      // _loadingOrders = false;
      // notifyListeners();
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

  /// PUT Methods
  Future confirmOrder(BuildContext context, String id) async {
    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      var res = await dio.put(BASE_API_URL + '/order/billStatus/$id');
      notifyListeners();
      if (res.statusCode == 200) {
        notifyListeners();

        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        ToastSnackbar()
            .init(context)
            .showToast(message: "${e.response}", type: ToastSnackbarType.error);
      } else {
        /// Error due to setting up or sending the request
        ToastSnackbar()
            .init(context)
            .showToast(message: "${e.message}", type: ToastSnackbarType.error);
      }
    }
  }

  Future deliverOrder(BuildContext context, String id) async {
    /// open hive box
    var credentialsBox = Boxes.getCredentials();
    // String _id = credentialsBox.get('id');
    String _token = credentialsBox.get('token');

    /// dataForm is already a parameter

    /// post the dataForm via dio call
    try {
      Dio dio = Dio();
      dio.options.headers["token"] = "Bearer $_token";
      var res = await dio.put(BASE_API_URL + '/order/billStatus/delivered/$id');
      notifyListeners();
      if (res.statusCode == 200) {
        notifyListeners();

        /// Display Results Message
        ToastSnackbar().init(context).showToast(
            message: "${res.statusMessage}", type: ToastSnackbarType.success);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        /// Toast Message to print the message
        ToastSnackbar()
            .init(context)
            .showToast(message: "${e.response}", type: ToastSnackbarType.error);
      } else {
        /// Error due to setting up or sending the request
        ToastSnackbar()
            .init(context)
            .showToast(message: "${e.message}", type: ToastSnackbarType.error);
      }
    }
  }

  Future cancelOrder(BuildContext context, String orderId, String motif,
      String? type, String? oldStatus, bool? reload) async {
    print("ws lanched : $orderId [ $motif ]");

    // _loadingCancel = true;
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
      FormData _formData =
          FormData.fromMap({"userId": _id, "orderId": orderId, "motif": motif});
      var res = await dio.post(BASE_API_URL + '/order/cancel', data: _formData);
      notifyListeners();
      if (res.statusCode == 200) {
        // print(res.data.length);
        if (reload == true) {
          getOrders(type ?? "", oldStatus ?? "");
        } else {
          _orders!.removeWhere((item) => item.id == orderId);
          notifyListeners();
        }
      }
      // _loadingCancel = false;
      notifyListeners();
    } on DioError catch (e) {
      // _loadingCancel = false;
      notifyListeners();
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }
    }

    Navigator.pop(context, true);
  }

  Future returnOrder(BuildContext context, String orderId, String motif,
      String returnItems, String? type, String? oldStatus, bool? reload) async {
    print("ws return lanched : $orderId [ $motif ] [ $returnItems ]");

    _loadingReturn = true;
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
      FormData _formData = FormData.fromMap({
        "userId": _id,
        "orderId": orderId,
        "motif": motif,
        "returnItems": returnItems
      });
      var res = await dio.post(BASE_API_URL + '/order/return', data: _formData);
      notifyListeners();
      if (res.statusCode == 200) {
        // print(res.data.length);
        if (reload == true) {
          getOrders(type ?? "", oldStatus ?? "");
        } else {
          _orders!.removeWhere((item) => item.id == orderId);
          notifyListeners();
        }
      }
      _loadingReturn = false;
      notifyListeners();
    } on DioError catch (e) {
      _loadingReturn = false;
      notifyListeners();
      if (e.response != null) {
        /// Toast Message to print the message
        print('${e.response!}');
      } else {
        /// Error due to setting up or sending the request
        print('Error sending request!');
        print("${e.message}");
      }
    }

    Navigator.pop(context, true);
  }

  Future refundOrder(BuildContext context, String orderId, String returnItems,
      String? type, String? oldStatus, bool? reload) async {
    print("ws refund lanched : $orderId [ $returnItems ]");

    _loadingReturn = true;
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
      FormData _formData = FormData.fromMap(
          {"userId": _id, "orderId": orderId, "returnItems": returnItems});
      var res = await dio.post(BASE_API_URL + '/order/refund', data: _formData);
      notifyListeners();
      if (res.statusCode == 200) {
        // print(res.data.length);
        if (reload == true) {
          getOrders(type ?? "", oldStatus ?? "");
        } else {
          _orders!.removeWhere((item) => item.id == orderId);
          notifyListeners();
        }

        Navigator.pop(context, true);
      }
      _loadingReturn = false;
      notifyListeners();
    } on DioError catch (e) {
      _loadingReturn = false;
      notifyListeners();
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
