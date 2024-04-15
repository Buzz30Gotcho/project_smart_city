import 'dart:convert';

class Policy {
  // List<ShippingMethod>? shippingMethods;

  // WorkingTime? workingTimePolicy;
  PickupPolicy? pickupPolicy;
  DeliveryPolicy? deliveryPolicy;
  ReservationPolicy? reservationPolicy;
  ReturnPolicy? returnPolicy;
  OrderPolicy? orderPolicy;

  Policy({
    //  this.shippingMethods,
    //this.workingTimePolicy,
    this.pickupPolicy,
    this.deliveryPolicy,
    this.reservationPolicy,
    this.returnPolicy,
    this.orderPolicy,
  });

  Policy.fromJson(Map<String, dynamic> json) {
    /* workingTimePolicy = json['workingTime'] == null
        ? null
        : WorkingTime.fromJson(json['workingTime']);*/
    pickupPolicy =
        json['pickup'] == null ? null : PickupPolicy.fromJson(json['pickup']);
    deliveryPolicy = json['delivery'] == null
        ? null
        : DeliveryPolicy.fromJson(json['delivery']);
    returnPolicy =
        json['return'] == null ? null : ReturnPolicy.fromJson(json['return']);
    reservationPolicy = json['reservation'] == null
        ? null
        : ReservationPolicy.fromJson(json['reservation']);
    orderPolicy =
        json['order'] == null ? null : OrderPolicy.fromJson(json['order']);
  }

  String toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    /* data['workingTime'] =
        workingTimePolicy == null ? null : workingTimePolicy!.toJson();*/

    data['pickup'] = pickupPolicy == null ? null : pickupPolicy!.toJson();

    data['delivery'] = deliveryPolicy == null ? null : deliveryPolicy!.toJson();

    data['reservation'] =
        reservationPolicy == null ? null : reservationPolicy!.toJson();

    data['return'] = returnPolicy == null ? null : returnPolicy!.toJson();

    data['order'] = orderPolicy == null ? null : orderPolicy!.toJson();

    return json.encode(data);
  }
}

// workingTimeexpiration: const Duration(days: 15),
// tax: 1.8,
// selfPickUpPrice: 1.5);

class PickupPolicy {
  int? timeLimit;

  PickupPolicy({required this.timeLimit});
  factory PickupPolicy.fromJson(Map<String, dynamic> json) {
    return PickupPolicy(
      timeLimit: json['timeLimit'] != null ? json['timeLimit'].toInt() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeLimit'] = timeLimit;
    return data;
  }
}

class DeliveryPolicy {
  bool? delivery;
  DeliveryPolicy({
    required this.delivery,
  });
  factory DeliveryPolicy.fromJson(Map<String, dynamic> json) {
    return DeliveryPolicy(delivery: json['delivery']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['delivery'] = delivery;

    return data;
  }
}

class ReservationPolicy {
  final int? duration;
  final ReservationPayment payment;
  final ReservationCancelation? cancelation;

  ReservationPolicy(
      {this.duration, required this.payment, required this.cancelation});

  factory ReservationPolicy.fromJson(Map<String, dynamic> json) {
    return ReservationPolicy(
      duration: json['duration'],
      payment:
          ReservationPayment.fromJson(json['payment'] as Map<String, dynamic>),
      cancelation: ReservationCancelation.fromJson(
          json['cancelation'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['payment'] = payment.toJson();
    if (cancelation != null) {
      data['cancelation'] = cancelation!.toJson();
    }

    return data;
  }
}

class ReservationCancelation {
  Restrictions? restrictions;

  ReservationCancelation({this.restrictions});

  ReservationCancelation.fromJson(Map<String, dynamic> json) {
    restrictions = Restrictions.fromJson(json['restrictions']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (restrictions != null) {
      data['restrictions'] = restrictions!.toJson();
    }
    return data;
  }
}

class Restrictions {
  double? fix;
  double? percentage;

  Restrictions({this.fix, this.percentage});

  Restrictions.fromJson(Map<String, dynamic> json) {
    fix = json['fixe'] != null ? json['fixe'].toDouble() : null;
    percentage =
        json['percentage'] != null ? json['percentage'].toDouble() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['fixe'] = fix;
    data['percentage'] = percentage;
    return data;
  }
}

class ReservationPayment {
  final bool? free;
  Partial? partial;
  bool? total;

  ReservationPayment({this.free, this.partial, required total});

  factory ReservationPayment.fromJson(Map<String, dynamic> json) {
    return ReservationPayment(
      free: json['free'],
      partial: Partial.fromJson(json['partial']),
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['free'] = free;
    if (partial != null) {
      data['partial'] = partial!.toJson();
    }

    data['total'] = total;
    return data;
  }
}

class Partial {
  double? fixe;
  double? percentage;

  Partial({required this.fixe, required this.percentage});

  factory Partial.fromJson(Map<String, dynamic> json) {
    return Partial(
      fixe: json['fixe'] != null ? json['fixe'].toDouble() : null,
      percentage:
          json['percentage'] != null ? json['percentage'].toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'fixe': fixe,
        'percentage': percentage,
      };
}

class ReturnPolicy {
  int? duration;
  String? productStatus;
  String? returnMethod;
  Refund refund;

  ReturnPolicy({
    required this.duration,
    required this.productStatus,
    required this.returnMethod,
    required this.refund,
  });

  factory ReturnPolicy.fromJson(Map<String, dynamic> json) {
    return ReturnPolicy(
      duration: json['duration'],
      productStatus: json['productStatus'],
      returnMethod: json['returnMethod'],
      refund: Refund.fromJson(json['refund']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = duration;
    data['productStatus'] = productStatus;
    data['returnMethod'] = returnMethod;
    data['refund'] = refund.toJson();
    return data;
  }
}

class Refund {
  OrderRefund order;
  ShippingRefund? shipping;

  Refund({
    required this.order,
    required this.shipping,
  });

  factory Refund.fromJson(Map<String, dynamic> json) {
    return Refund(
      order: OrderRefund.fromJson(json['order']),
      shipping: ShippingRefund.fromJson(json['shipping']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order'] = order.toJson();
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }

    return data;
  }
}

class OrderRefund {
  double? fixe;
  double? percentage;

  OrderRefund({
    this.fixe,
    this.percentage,
  });

  factory OrderRefund.fromJson(Map<String, dynamic> json) {
    return OrderRefund(
      fixe: json['fixe'] != null ? json['fixe'].toDouble() : null,
      percentage:
          json['percentage'] != null ? json['percentage'].toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fixe'] = fixe;
    data['percentage'] = percentage;
    return data;
  }
}

class ShippingRefund {
  double? fixe;
  double? percentage;

  ShippingRefund({
    this.fixe,
    this.percentage,
  });

  factory ShippingRefund.fromJson(Map<String, dynamic> json) {
    return ShippingRefund(
      fixe: json['fixe'] != null ? json['fixe'].toDouble() : null,
      percentage:
          json['percentage'] != null ? json['percentage'].toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fixe'] = fixe;
    data['percentage'] = percentage;
    return data;
  }
}
/*
class WorkingTime {
  TimeOfDay? openTime; // Initialize with default values
  TimeOfDay? closeTime; // Initialize with default values

  WorkingTime({TimeOfDay? openTime, TimeOfDay? closeTime}) {
    this.openTime = openTime ?? TimeOfDay(hour: 0, minute: 0);
    this.closeTime = closeTime ?? TimeOfDay(hour: 0, minute: 0);
  }

  factory WorkingTime.fromJson(Map<String, dynamic> json) {
    return WorkingTime(
      openTime: json['openTime'],
      closeTime: json['closeTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }
}*/

class OrderPolicy {
  OrderNotification? notification;

  OrderPolicy({this.notification});

  factory OrderPolicy.fromJson(Map<String, dynamic> json) {
    return OrderPolicy(
      notification: json['notification'] != null
          ? OrderNotification.fromJson(json['notification'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    return data;
  }
}

class OrderNotification {
  bool? realtime;
  int? time;
  int? perOrdersNbr;
  SendMode? sendMode;

  OrderNotification(
      {this.realtime, this.time, this.perOrdersNbr, this.sendMode});

  factory OrderNotification.fromJson(Map<String, dynamic> json) {
    return OrderNotification(
      realtime: json['realtime'] as bool?,
      time: json['time'] as int?,
      perOrdersNbr: json['perOrdersNbr'] as int?,
      sendMode: SendMode.fromJson(json['sendMode']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['realtime'] = realtime;
    data['time'] = time;
    data['perOrdersNbr'] = perOrdersNbr;
    if (sendMode != null) {
      data['sendMode'] = sendMode!.toJson();
    }
    return data;
  }
}

class SendMode {
  bool? mail;
  bool? sms;
  bool? popup;
  bool? vibration;
  bool? ringing;

  SendMode({this.mail, this.sms, this.popup, this.vibration, this.ringing});

  factory SendMode.fromJson(Map<String, dynamic> json) {
    return SendMode(
      mail: json['mail'] as bool?,
      sms: json['sms'] as bool?,
      popup: json['popup'] as bool?,
      vibration: json['vibration'] as bool?,
      ringing: json['ringing'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mail'] = mail;
    data['sms'] = sms;
    data['popup'] = popup;
    data['vibration'] = vibration;
    data['ringing'] = ringing;
    return data;
  }
}
