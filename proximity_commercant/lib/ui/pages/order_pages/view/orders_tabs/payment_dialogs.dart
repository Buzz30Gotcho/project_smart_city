import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/models/bill_card_model.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

/// This class has a couple of DialogWidgets to avoid BoilerPlate between Widgets
///
/// The [id] indicates the index of the store
class PaymentDialogs {
  static void showInfos(BuildContext context, BillCard? infos) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    showDialogPopup(
        context: context,
        pageBuilder: (ctx, anim1, anim2) => StatefulBuilder(
            builder: (context, setState) => DialogPopup(
                child: SizedBox(
                    height: screenHeight * 2 / 3,
                    width: screenWidth * 0.8,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(smallRadius),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: small_100),
                        child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Payment Infos',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF136DA5)),
                                  ),
                                  Divider(),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Payment Methode',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        'Pay by card',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              tinyRadius),
                                          color: Color(0xFF104D72)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            infos!.name ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFEFEFEF)),
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.network(
                                                    'https://i.ibb.co/zmn2F5b/Vector-Visa-Credit-Card.png',
                                                    width: 50.0,
                                                    height: 50.0),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        infos!.cardNumber ?? "",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFFEFEFEF)),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        (infos!.expdate ?? '') +
                                                            '      ' +
                                                            (infos!.cvc ?? ''),
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            fontSize: 10.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xFFEFEFEF)),
                                                      ),
                                                    ])
                                              ]),
                                        ],
                                      )),
                                  SectionDivider(
                                      leadIcon: ProximityIcons.address,
                                      title: 'Billing Address.',
                                      color: blueSwatch.shade500),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.name ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'City',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.city ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Street',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.street ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Street 2',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.street2 ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Postal Code',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.postalCode ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(normal_100),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                                child: SecondaryButton(
                                                    title: 'Cancel.',
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context))),
                                          ]))
                                ])))))));
  }

  /// A method to display the freeze dialog
  static void showInfos2(BuildContext context, BillCard? infos) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    showDialogPopup(
        context: context,
        pageBuilder: (ctx, anim1, anim2) => StatefulBuilder(
            builder: (context, setState) => DialogPopup(
                child: SizedBox(
                    height: screenHeight * 2 / 3,
                    width: screenWidth * 0.8,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(smallRadius),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: small_100),
                        child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Contact Infos',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF136DA5)),
                                  ),
                                  Divider(),
                                  SizedBox(height: 20),
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              tinyRadius),
                                          color: Color(0xFF104D72)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            infos!.name!.toUpperCase() ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFEFEFEF)),
                                          )
                                        ],
                                      )),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.name ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Phone',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.phone ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'City',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.city ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Street',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.street ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Street 2',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.street2 ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Postal Code',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).dividerColor),
                                      )),
                                      Expanded(
                                          child: Text(
                                        infos!.postalCode ?? "",
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(normal_100),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                                child: SecondaryButton(
                                                    title: 'Cancel.',
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context))),
                                          ]))
                                ])))))));
  }

  static Future cancelOrder(
          BuildContext context, String? orderId, OrderService? ordersService) =>
      showDialogPopup(
          context: context,
          pageBuilder: (ctx, anim1, anim2) => StatefulBuilder(
              builder: (context, setState) => DialogPopup(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width - normal_200 * 2,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        const SizedBox(height: normal_100),
                        Stack(children: [
                          ImageFiltered(
                              imageFilter: blurFilter,
                              child: Icon(ProximityIcons.remove,
                                  color: Theme.of(context).errorColor,
                                  size: normal_300)),
                          Icon(ProximityIcons.remove,
                              color: Theme.of(context).errorColor,
                              size: normal_300)
                        ]),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: normal_100,
                                left: normal_100,
                                right: normal_100),
                            child: Text(
                                'Are you really want cancel the order ?',
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center)),
                        EditText(
                          hintText: 'Motif.',
                          borderType: BorderType.bottom,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(normal_100),
                            child:
                                Row(mainAxisSize: MainAxisSize.max, children: [
                              Expanded(
                                  child: SecondaryButton(
                                      title: 'Cancel.',
                                      onPressed: () =>
                                          Navigator.pop(context, false))),
                              const SizedBox(width: normal_100),
                              Expanded(
                                  child: Consumer<StoreService>(
                                      builder: (context, storeService, child) =>
                                          Expanded(
                                              child: PrimaryButton(
                                                  title: 'Confirm.',
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true)))))
                            ]))
                      ])))));
}
