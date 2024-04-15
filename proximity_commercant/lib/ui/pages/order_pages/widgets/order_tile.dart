import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/pages.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(
      {Key? key,
      required this.order,
      this.action,
      this.secondaryAction,
      this.actionCancel,
      this.actionReturn,
      this.returnOrder = false,
      this.refundOrder = false})
      : super(key: key);

  final Order order;
  final VoidCallback? action;
  final VoidCallback? secondaryAction;
  final Function? actionCancel;
  final Function? actionReturn;
  final bool? returnOrder;
  final bool? refundOrder;

  @override
  Widget build(BuildContext context) {
    /// get Locale
    print("order tile");
    final Locale _locale = Localizations.localeOf(context);

    final ordersService = Provider.of<OrderService>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderPage(
                      order: order,
                      returnOrder: returnOrder,
                      refundOrder: refundOrder,
                      action: action,
                      secondaryAction: secondaryAction,
                      actionCancel: actionCancel,
                      actionReturn: actionReturn,
                    )));
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: normal_100)
              .copyWith(bottom: 50),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(normalRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // shadow color
                  spreadRadius: 2, // spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(0, 3), // changes position of shadow
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(1), // shadow color
                  spreadRadius: 0, // spread radius
                  blurRadius: 0, // blur radius
                  offset: Offset(0, 0), // changes position of shadow
                )
              ],
              color: Colors.white24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Material(
                color: Colors.transparent,
                child: InkWell(
                    // onTap: () =>
                    //     cartService.checkAllOrderedProducts(cart.storeId!),
                    child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: normalRadius, topRight: normalRadius),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(small_100),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SmallIconButton(
                            //     onPressed: () {},
                            //     icon: Icon(ProximityIcons.user,
                            //         color: Theme.of(context).primaryColor)),
                            Expanded(
                                child: Text('#${order.id}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontSize: 12))),
                          ])),
                ))),

            /// Order Details
            OrderDetails(details: {
              'Client': '${order.userName}',
              'Order Date': (order.orderDate != null)
                  ? DateFormat.yMMMEd(
                          _locale.languageCode + '_' + _locale.countryCode!)
                      .format(order.orderDate!)
                  : '--:--:----'
            }),
            if (order.delivery == true)
              OrderDetails(details: {
                'Delivery Date': (order.deliveryDate != null)
                    ? DateFormat.yMMMEd(
                            _locale.languageCode + '_' + _locale.countryCode!)
                        .format(order.deliveryDate!)
                    : '--:--:----',
                'Shipping Address': order.shippingAddress!.getAddressLine,
              }),

            if (order.pickup == true)
              OrderDetails(details: {
                'Pickup By': (order.pickupPerson != null &&
                        order.pickupPerson?["name"] != null)
                    ? order.pickupPerson!["name"] ?? ""
                    : '',
              }),

            Padding(
              padding: const EdgeInsets.all(small_100),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Status"),
                    if (returnOrder != true && refundOrder != true)
                      Text(
                        () {
                          RegExp regExp = RegExp(r"([A-Z])");
                          String replaced = order.orderStatus!.replaceAllMapped(
                              regExp, (match) => " " + (match.group(0) ?? ""));
                          if (order.canceled == true) {
                            return "Canceled";
                          }
                          return replaced;
                        }(),
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: order.canceled == true
                                ? Colors.red
                                : order.orderStatus == "InPreparation"
                                    ? Colors.cyan
                                    : order.orderStatus == "AwaitingRecovery" ||
                                            order.orderStatus == "OnTheWay"
                                        ? Colors.deepPurple
                                        : order.orderStatus == "Recovered" ||
                                                order.orderStatus ==
                                                    "Delivered" ||
                                                order.orderStatus == "Reserved"
                                            ? Colors.green
                                            : Colors.deepOrange),
                      ),
                    if (refundOrder == true)
                      Text(
                        order.refund == true ? "Refunded" : "",
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 14, 170, 97)),
                      ),
                    if (returnOrder == true)
                      Text(
                        order.returned == true
                            ? "Returned"
                            : order.waitingforReturn == true
                                ? "Waiting For Return"
                                : "Return Request",
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 13, 172, 117)),
                      ),
                  ]),
            ),

            if (order.canceled == true)
              Padding(
                padding: const EdgeInsets.all(small_100),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Old status"),
                      if (returnOrder != true && refundOrder != true)
                        Text(
                          () {
                            RegExp regExp = RegExp(r"([A-Z])");
                            String replaced = order.orderStatus!
                                .replaceAllMapped(regExp,
                                    (match) => " " + (match.group(0) ?? ""));

                            return replaced;
                          }(),
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (returnOrder == true || refundOrder == true)
                        const Text(
                          "Return Request",
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),
                        ),
                    ]),
              ),

            if ((returnOrder == true || refundOrder == true) &&
                order.returnOrder == true &&
                order.returnMotif != null &&
                order.returnMotif != "")
              OrderDetails(details: {
                'Return motif': order.returnMotif ?? "",
              }),

            Padding(
              padding: const EdgeInsets.all(small_100),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (returnOrder != true && refundOrder != true)
                      const Text("Order items"),
                    if (returnOrder != true && refundOrder != true)
                      Text(order.items!.length.toString() +
                          " item" +
                          (order.items!.length > 1 ? "s" : "")),
                    if (returnOrder == true) const Text("Return items"),
                    if (returnOrder == true)
                      Text(order.items!.length.toString() +
                          " item" +
                          (order.returnedItems!.length > 1 ? "s" : "")),
                  ]),
            ),

            /// Order Items (Ordered Products)
            ///
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor.withOpacity(0.4),
                ),
                child: Column(
                  children: [
                    if (returnOrder != true)
                      ...List.generate(
                          order.items!.length,
                          (index) => OrderDetails(details: {
                                '${order.items![index].name}':
                                    '${((order.items![index].price ?? 1) * (order.items![index].orderedQuantity ?? 1) * (1 - (order.items![index].discount > 0 ? (order.items![index].discount) : 0))).toString()}',
                                '${order.items![index].price! * (1 - (order.items![index].discount > 0 ? (order.items![index].discount) : 0))} x${order.items![index].orderedQuantity}':
                                    '',
                              })

                          // OrderItemTile(orderItem: order.items![index])
                          ),
                    if (returnOrder == true)
                      ...List.generate(
                          order.returnedItems!.length,
                          (index) => OrderDetails(details: {
                                '${order.returnedItems![index].name}':
                                    '${((order.returnedItems![index].price ?? 1) * (order.returnedItems![index].returnQuantity ?? 1) * (1 - (order.returnedItems![index].discount > 0 ? (order.returnedItems![index].discount) : 0))).toString()}',
                                '${order.returnedItems![index].price! * (1 - (order.returnedItems![index].discount > 0 ? (order.returnedItems![index].discount) : 0))} x${order.returnedItems![index].returnQuantity}':
                                    '',
                              })

                          // OrderItemTile(orderItem: order.items![index])
                          ),
                  ],
                )),

            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(small_100),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(' Total',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.black, fontSize: 17)),
                          if (returnOrder != true && refundOrder != true)
                            Text(
                                ' € ${(order.totalPrice ?? 0.0).toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: Colors.black, fontSize: 17)),
                          if (returnOrder == true || refundOrder == true)
                            Text(() {
                              var returnTotal = 0.0;
                              for (var element in order.returnedItems!) {
                                returnTotal += (element.price!) *
                                    (element.returnQuantity!);
                              }
                              return ' € ${(returnTotal ?? 0.0).toStringAsFixed(2)}';
                            }(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: Colors.black, fontSize: 17))
                        ])),
              ),
            ]),
            if ((returnOrder == true || refundOrder == true) &&
                order.returned == true)
              Padding(
                padding: const EdgeInsets.all(small_100),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Return accepted items"),
                      Text(order.acceptedReturnedItems!.length.toString() +
                          " item" +
                          (order.acceptedReturnedItems!.length > 1 ? "s" : "")),
                    ]),
              ),

            /// Order Items (Ordered Products)
            ///
            if ((returnOrder == true || refundOrder == true) &&
                order.returned == true)
              Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor.withOpacity(0.4),
                  ),
                  child: Column(
                    children: [
                      ...List.generate(
                          order.acceptedReturnedItems!.length,
                          (index) => OrderDetails(details: {
                                '${order.acceptedReturnedItems![index].name}':
                                    '${((order.acceptedReturnedItems![index].price ?? 1) * (order.acceptedReturnedItems![index].returnQuantity ?? 1) * (1 - (order.acceptedReturnedItems![index].discount > 0 ? (order.acceptedReturnedItems![index].discount) : 0)) * (order.acceptedReturnedItems![index].policy == null ? 0 : (order.acceptedReturnedItems![index].policy!.returnPolicy!.refund.order.percentage ?? 0.0))).toString()}',
                                '${order.acceptedReturnedItems![index].price} x${order.acceptedReturnedItems![index].returnQuantity}':
                                    '',
                                'Refund': () {
                                  if (order.acceptedReturnedItems![index]
                                          .policy !=
                                      null) {
                                    return '${(((order.acceptedReturnedItems![index].policy!.returnPolicy!.refund.order.percentage ?? 0.0) * 100) ?? (order.acceptedReturnedItems![index].policy!.returnPolicy?.refund.order.fixe ?? 0.0))}' +
                                        (order
                                                    .acceptedReturnedItems![
                                                        index]
                                                    .policy!
                                                    .returnPolicy!
                                                    .refund
                                                    .order
                                                    .percentage !=
                                                null
                                            ? "%"
                                            : "");
                                  }
                                  return "";
                                }(),
                              })),
                    ],
                  )),

            if ((returnOrder == true || refundOrder == true) &&
                order.returned == true)
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(small_100),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(' Total Refund',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: Colors.black, fontSize: 17)),
                            Text(() {
                              var returnTotal = 0.0;
                              for (var element
                                  in order.acceptedReturnedItems!) {
                                returnTotal += (element.price!) *
                                    (element.returnQuantity!) *
                                    (1 -
                                        (element.discount > 0
                                            ? element.discount
                                            : 0)) *
                                    (element.policy == null
                                        ? 0.0
                                        : (element.policy!.returnPolicy!.refund
                                                    .order.percentage ??
                                                0.0) ??
                                            (element.policy!.returnPolicy
                                                    ?.refund.order.fixe ??
                                                1));
                              }
                              return ' € ${(returnTotal ?? 0.0).toStringAsFixed(2)}';
                            }(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: Colors.black, fontSize: 17))
                          ])),
                ),
              ]),
            if (order.canceled != true && (order.returned != true))
              Padding(
                  padding: const EdgeInsets.all(small_50).copyWith(top: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (["Recovered", "Delivered", "Reserved"].indexWhere(
                                    (item) => item == order.orderStatus) ==
                                -1 ||
                            (order.returnOrder == true &&
                                returnOrder == true) ||
                            order.waitingforReturn == true &&
                                returnOrder == true) ...[
                          Expanded(
                              child: TertiaryButton(
                                  onPressed: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CancelOrderScreen(
                                                      orderId: order.id,
                                                      actionCancel:
                                                          actionCancel,
                                                    )))
                                      },
                                  title: "Cancel.")),
                          Expanded(
                              child: TertiaryButton(
                                  onPressed: () {
                                    if (returnOrder == true &&
                                        order.waitingforReturn == true) {
                                      print(order.items!.length);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReturnOrderScreen(
                                                    order: order,
                                                    actionReturn: actionReturn,
                                                  )));
                                    } else {
                                      action!.call();
                                    }
                                  },
                                  title: order.orderStatus == "Pending"
                                      ? "Approve."
                                      : "Next")),
                        ],
                      ])),
          ])),
    );
  }
}
