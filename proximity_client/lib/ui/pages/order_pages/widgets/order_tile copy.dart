import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/ui/pages/pages.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(
      {Key? key,
      required this.order,
      this.action,
      this.actionCancel,
      this.actionReturn})
      : super(key: key);

  final Order order;
  final VoidCallback? action;
  final Function? actionCancel;
  final Function? actionReturn;

  @override
  Widget build(BuildContext context) {
    /// get Locale
    final Locale locale = Localizations.localeOf(context);
    final ordersService = Provider.of<OrderService>(context);
    final orderId = order.id;
    return Container(
        margin: const EdgeInsets.all(normal_100),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(normalRadius),
            border: Border.all(
                width: tiny_50, color: Theme.of(context).dividerColor)),
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
                            if (order.storeImage != null)
                              SizedBox(
                                  height: large_150,
                                  width: large_150,
                                  child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Positioned.fill(
                                            child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        normalRadius),
                                                child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: (order.storeImage !=
                                                            null)
                                                        ? Image.network(
                                                            order.storeImage!)
                                                        : Image.network(
                                                            "https://cdn-icons-png.flaticon.com/512/5853/5853761.png")))),
                                      ])),
                            if (order.storeImage == null)
                              SmallIconButton(
                                  onPressed: () {},
                                  icon: Icon(ProximityIcons.store,
                                      color: Theme.of(context).primaryColor)),
                            const SizedBox(width: small_100),
                            Expanded(
                                child: Text('${order.storeName}',
                                    style:
                                        Theme.of(context).textTheme.headlineMedium)),
                          ])))),

          const Divider(thickness: tiny_50, height: tiny_50),

          /// Order Details
          OrderDetails(details: {
            'Your Order ID': '#${order.id}',
            'Order Date': (order.orderDate != null)
                ? DateFormat.yMMMEd(
                        '${locale.languageCode}_${locale.countryCode!}')
                    .format(order.orderDate!)
                : '--:--:----',
          }),
          if (order.delivery == true)
            OrderDetails(details: {
              'Delivery Date': (order.deliveryDate != null)
                  ? DateFormat.yMMMEd(
                          '${locale.languageCode}_${locale.countryCode!}')
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
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: 150,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
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
                                  : Colors.deepOrange,
                  borderRadius: const BorderRadius.only(
                      topLeft: normalRadius, bottomLeft: normalRadius)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  () {
                    RegExp regExp = RegExp(r"([A-Z])");
                    String replaced = order.orderStatus!.replaceAllMapped(
                        regExp, (match) => " ${match.group(0) ?? ""}");
                    return order.canceled == true
                        ? "Canceled [ $replaced ]"
                        : replaced;
                  }(),
                  style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEFEFEF)),
                ),
              ]),
            ),
          ]),

          /// Order Items (Ordered Products)
          ...List.generate(order.items!.length,
              (index) => OrderItemTile(orderItem: order.items![index])),
          const Divider(height: tiny_50, thickness: tiny_50),
          if (order.delivery == true)
            Padding(
                padding: const EdgeInsets.all(small_100),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery:',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium),
                      const Spacer(),
                      /*Text(
                          ' € ${(order.paymentInfo!.deliveryAmount ?? 0.0).toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(fontSize: 16))*/
                    ])),

          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: Theme.of(context).dividerColor),
                child: Padding(
                    padding: const EdgeInsets.all(small_100),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(tinyRadius),
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
                                      const SizedBox(width: 12.0),
                                      const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            /* Text(
                                              '***${order.paymentInfo!.card!.cardNumber!.substring(order.paymentInfo!.card!.cardNumber!.length - 4, order.paymentInfo!.card!.cardNumber!.length)}',
                                              style: TextStyle(
                                                  fontSize: 7.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFEFEFEF)),
                                            ),
                                            Text(
                                              '${order.paymentInfo!.card!.expdate}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 5.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFEFEFEF)),
                                            ),*/
                                          ])
                                    ])),
                          ),
                          const Spacer(),
                          Text(
                              ' € ${(order.totalPrice ?? 0.0).toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Colors.black, fontSize: 17))
                        ])),
              ),
            ),
          ]),
          if (order.returnOrder == true)
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Return",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFEFEFEF)),
                              ),
                            ]),
                      ],
                    )),
              )
            ]),

          if (order.returnOrder == true)
            ...List.generate(
                order.returnedItems!.length,
                (index) => OrderItemTile(
                      orderItem: order.returnedItems![index],
                      returnedItem: true,
                    )),
          const Divider(height: tiny_50, thickness: tiny_50),

          if (order.orderStatus != 'Canceled')
            Padding(
                padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (["Recovered", "Delivered"].indexWhere(
                                  (item) => item == order.orderStatus) !=
                              -1 &&
                          order.returnOrder == false) ...[
                        Expanded(
                            child: TertiaryButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReturnOrderScreen(
                                                order: order,
                                                actionReturn: actionReturn,
                                              )));
                                },
                                title: "Ask for Return")),
                      ],
                      if ([
                            "Reserved"
                          ].indexWhere((item) => item == order.orderStatus) !=
                          -1) ...[
                        Expanded(
                            child: TertiaryButton(
                                onPressed: () {
                                  action!.call();
                                  // PaymentDialogs.cancelOrder(
                                  //     context, order.id)
                                },
                                title: "finalize your reservation")),
                      ],
                      if ([
                                "Recovered",
                                "Delivered",
                                "Reserved",
                              ].indexWhere(
                                  (item) => item == order.orderStatus) ==
                              -1 &&
                          order.canceled != true) ...[
                        Expanded(
                            child: TertiaryButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CancelOrderScreen(
                                                orderId: orderId,
                                                actionCancel: actionCancel,
                                              )));
                                },
                                title: "Cancel.")),
                        // Expanded(
                        //     child: TertiaryButton(
                        //         onPressed: () => {action!.call()},
                        //         title: order.orderStatus == "Pending"
                        //             ? "Approve."
                        //             : "Next")),
                      ],
                    ])),
          if (order.canceled == true) ...[
            Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: normalRadius, bottomRight: normalRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(small_100),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (order.canceledBy!["image"] != null)
                          SizedBox(
                              height: large_150,
                              width: large_150,
                              child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Positioned.fill(
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    normalRadius),
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: (order.canceledBy![
                                                            "image"] !=
                                                        null)
                                                    ? Image.network(order
                                                        .canceledBy!["image"]!)
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
                              '${order.canceledBy!["name"]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: small_100,
                            ),
                            Text(
                              '${order.canceledBy!["motif"]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                      ]),
                ))
          ]
        ]));
  }
}
