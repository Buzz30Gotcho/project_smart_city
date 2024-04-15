import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/pages.dart';
import 'package:intl/intl.dart';

class OrderTilePage extends StatelessWidget {
  const OrderTilePage(
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
    final Locale _locale = Localizations.localeOf(context);

    final ordersService = Provider.of<OrderService>(context);

    return Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Material(
          color: Colors.transparent,
          child: InkWell(
              // onTap: () =>
              //     cartService.checkAllOrderedProducts(cart.storeId!),
              child: Padding(
                  padding: const EdgeInsets.all(small_100),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: large_150,
                            width: large_150,
                            child:
                                Stack(alignment: Alignment.topRight, children: [
                              Positioned.fill(
                                  child: ClipRRect(
                                      borderRadius:
                                          const BorderRadius.all(normalRadius),
                                      child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: (order.userProfilePic! != null)
                                              ? Image.network(
                                                  order.userProfilePic!)
                                              : Image.network(
                                                  "https://cdn-icons-png.flaticon.com/512/5853/5853761.png")))),
                            ])),
                        // SmallIconButton(
                        //     onPressed: () {},
                        //     icon: Icon(ProximityIcons.user,
                        //         color: Theme.of(context).primaryColor)),
                        const SizedBox(width: small_100),
                        Expanded(
                            child: Text('${order.userName}',
                                style: Theme.of(context).textTheme.headline4)),
                      ])))),

      /// Order Details
      OrderDetails(details: {
        'Your Order ID': '#${order.id}',
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
                                          order.orderStatus == "Delivered" ||
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
      if (order.canceled == true) ...[
        Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
            ),
            child: Padding(
              padding: const EdgeInsets.all(small_100),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                if (order.canceledBy!["image"] != null)
                  SizedBox(
                      height: large_150,
                      width: large_150,
                      child: Stack(alignment: Alignment.topRight, children: [
                        Positioned.fill(
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(normalRadius),
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: (order.canceledBy!["image"] != null)
                                        ? Image.network(
                                            order.canceledBy!["image"]!)
                                        : Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/5853/5853761.png")))),
                      ])),
                if (order.canceledBy!["image"] == null)
                  SmallIconButton(
                      onPressed: () {},
                      icon: Icon(ProximityIcons.store,
                          color: Theme.of(context).primaryColor)),
                const SizedBox(width: small_100),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      'Canceled By ',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${order.canceledBy!["name"]}',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
              ]),
            ))
      ],

      if ((returnOrder == true || refundOrder == true) &&
          order.returnOrder == true &&
          order.returnMotif != null &&
          order.returnMotif != "")
        OrderDetails(details: {
          'Return motif': order.returnMotif ?? "",
        }),

      if (order.canceled == true && order.canceledBy!["motif"] != null)
        OrderDetails(details: {
          'Cancel motif': order.canceledBy!["motif"] ?? "",
        }),

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
                      String replaced = order.orderStatus!.replaceAllMapped(
                          regExp, (match) => " " + (match.group(0) ?? ""));

                      return replaced;
                    }(),
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (returnOrder == true || refundOrder == true)
                  const Text(
                    "Return Request",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
              ]),
        ),
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
              if (returnOrder == true || refundOrder == true)
                const Text("Return items"),
              if (returnOrder == true || refundOrder == true)
                Text(order.items!.length.toString() +
                    " item" +
                    (order.returnedItems!.length > 1 ? "s" : "")),
            ]),
      ),

      /// Order Items (Ordered Products)
      ///
      ...List.generate(order.items!.length,
          (index) => OrderItemTile(orderItem: order.items![index])),
      const Divider(height: tiny_50, thickness: tiny_50),

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
                      Text(' € ${(order.totalPrice ?? 0.0).toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black, fontSize: 17)),
                    if (returnOrder == true || refundOrder == true)
                      Text(() {
                        var returnTotal = 0.0;
                        for (var element in order.returnedItems!) {
                          returnTotal +=
                              (element.price!) * (element.returnQuantity!);
                        }
                        return ' € ${(returnTotal ?? 0.0).toStringAsFixed(2)}';
                      }(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black, fontSize: 17))
                  ])),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withOpacity(0.4)),
            child: Padding(
                padding: const EdgeInsets.all(small_100),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Contact informations',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black, fontSize: 12)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(tinyRadius),
                            color: Color(0xFF104D72)),
                        child: InkWell(
                            onTap: () => {
                                  PaymentDialogs.showInfos(
                                      context, order.paymentInfo!.card!)
                                },
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                      'https://i.ibb.co/zmn2F5b/Vector-Visa-Credit-Card.png',
                                      width: 20.0,
                                      height: 20.0),
                                  SizedBox(width: 12.0),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Show',
                                          style: TextStyle(
                                              fontSize: 7.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEFEFEF)),
                                        ),
                                      ])
                                ])),
                      ),
                    ])),
          ),
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
              color: Theme.of(context).dividerColor.withOpacity(0.1),
            ),
            child: Column(
              children: [
                ...List.generate(
                    order.acceptedReturnedItems!.length,
                    (index) => OrderDetails(details: {
                          '${order.acceptedReturnedItems![index].name}':
                              '${((order.acceptedReturnedItems![index].price ?? 1) * (order.acceptedReturnedItems![index].returnQuantity ?? 1) * (1 - (order.acceptedReturnedItems![index].discount > 0 ? (order.acceptedReturnedItems![index].discount) : 0)) * (order.acceptedReturnedItems![index].policy == null ? 0 : (order.acceptedReturnedItems![index].policy!.returnPolicy!.refund.order.percentage ?? 0.0) ?? (order.acceptedReturnedItems![index].policy!.returnPolicy?.refund.order.fixe ?? 1))).toString()}',
                          '${order.acceptedReturnedItems![index].price} x${order.acceptedReturnedItems![index].returnQuantity}':
                              '',
                          'Refund': () {
                            if (order.acceptedReturnedItems![index].policy !=
                                null) {
                              return '${(((order.acceptedReturnedItems![index].policy!.returnPolicy!.refund.order.percentage ?? 0.0) * 100) ?? (order.acceptedReturnedItems![index].policy!.returnPolicy?.refund.order.fixe ?? 0.0))}' +
                                  (order
                                              .acceptedReturnedItems![index]
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
                              .copyWith(color: Colors.black, fontSize: 17)),
                      Text(() {
                        var returnTotal = 0.0;
                        for (var element in order.acceptedReturnedItems!) {
                          returnTotal += (element.price!) *
                              (element.returnQuantity!) *
                              (1 -
                                  (element.discount > 0
                                      ? element.discount
                                      : 0)) *
                              (element.policy == null
                                  ? 0.0
                                  : (element.policy!.returnPolicy!.refund.order
                                              .percentage ??
                                          0.0) ??
                                      (element.policy!.returnPolicy?.refund
                                              .order.fixe ??
                                          1));
                        }
                        return ' € ${(returnTotal ?? 0.0).toStringAsFixed(2)}';
                      }(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black, fontSize: 17))
                    ])),
          ),
        ]),

      // if (order.returnOrder == true)
      //   Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      //     Expanded(
      //       child: Container(
      //           padding: const EdgeInsets.symmetric(vertical: 10),
      //           decoration: BoxDecoration(
      //             color: Colors.orangeAccent,
      //           ),
      //           child: Column(
      //             children: [
      //               Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //                 Text(
      //                   "Return Request",
      //                   style: TextStyle(
      //                       fontSize: 12.0,
      //                       fontWeight: FontWeight.bold,
      //                       color: Color(0xFFEFEFEF)),
      //                 ),
      //               ]),
      //               const SizedBox(
      //                 height: small_100,
      //               ),
      //               ...List.generate(
      //                   order.returnedItems!.length,
      //                   (index) => OrderItemTile(
      //                         orderItem: order.returnedItems![index],
      //                         returnedItem: true,
      //                       )),
      //             ],
      //           )),
      //     )
      //   ]),
      // if (order.returnOrder == true &&
      //     order.returnMotif != null &&
      //     order.returnMotif != "") ...[
      //   Container(
      //       decoration: BoxDecoration(
      //         color: Colors.orangeAccent,
      //         borderRadius: const BorderRadius.only(
      //             bottomLeft: normalRadius, bottomRight: normalRadius),
      //       ),
      //       child: Padding(
      //         padding: const EdgeInsets.all(small_100),
      //         child:
      //             Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      //           const SizedBox(width: small_100),
      //           Expanded(
      //               child: Column(
      //             children: [
      //               Text(
      //                 "Return Motif",
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .bodyText1!
      //                     .copyWith(color: Colors.white, fontSize: 12.0),
      //                 textAlign: TextAlign.center,
      //               ),
      //               const SizedBox(width: small_100),
      //               Text(
      //                 order.returnMotif ?? "",
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .bodyText1!
      //                     .copyWith(color: Colors.black),
      //                 textAlign: TextAlign.center,
      //               )
      //             ],
      //           )),
      //           const SizedBox(width: small_100),
      //         ]),
      //       ))
      // ],

      // if (order.canceled != true && (order.returned != true))
      //   Padding(
      //       padding: const EdgeInsets.all(small_50).copyWith(top: 0),
      //       child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             if ([
      //                       "Recovered",
      //                       "Delivered",
      //                       "Reserved"
      //                     ].indexWhere((item) => item == order.orderStatus) ==
      //                     -1 ||
      //                 order.returnOrder == true ||
      //                 order.waitingforReturn == true) ...[
      //               Expanded(
      //                   child: TertiaryButton(
      //                       onPressed: () => {
      //                             Navigator.push(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                     builder: (context) =>
      //                                         CancelOrderScreen(
      //                                           orderId: order.id,
      //                                           actionCancel: actionCancel,
      //                                         )))
      //                           },
      //                       title: "Cancel.")),
      //               Expanded(
      //                   child: TertiaryButton(
      //                       onPressed: () {
      //                         if (returnOrder == true &&
      //                             order.waitingforReturn == true) {
      //                           Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (context) => ReturnOrderScreen(
      //                                         order: order,
      //                                         actionReturn: actionReturn,
      //                                       )));
      //                         } else {
      //                           action!.call();
      //                         }
      //                       },
      //                       title: order.orderStatus == "Pending"
      //                           ? "Approve."
      //                           : "Next")),
      //             ],
      //           ])),
    ]));
  }
}
