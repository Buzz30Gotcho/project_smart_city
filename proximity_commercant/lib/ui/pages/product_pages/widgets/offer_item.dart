import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

import 'package:proximity_commercant/domain/product_repository/models/offer_model.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({Key? key, this.offer}) : super(key: key);
  final Offer? offer;
  @override
  Widget build(BuildContext context) {
    final f = DateFormat('yyyy-MM-dd');

    return !offer!.offerDeleted! == true
        ? Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(smallRadius),
                color: Color.fromARGB(255, 243, 243, 243)),
            margin: const EdgeInsets.symmetric(vertical: small_100),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        ' Offer : ${offer!.id}',
                        style: const TextStyle(
                            fontSize: 13.0,
                            color: Color.fromARGB(255, 90, 89, 89)),
                      ),
                      const SizedBox(height: 16.0),
                      Column(children: [
                        const Divider(),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: large_100,
                              right: large_100,
                              bottom: small_100),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Text("Discount",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      offer!.offerDiscount.toString() + '%',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 10.0,
                                          color: Color(0xFF136DA5))),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: large_100,
                              right: large_100,
                              bottom: small_100),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Text("Expiration date ",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(f.format(offer!.offerExpiration!),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: large_100,
                              right: large_100,
                              bottom: small_100),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Text("Stock",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(offer!.offerStock.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                              ]),
                        ),
                      ]),
                      const Divider(),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            width: large_200,
                            padding: const EdgeInsets.symmetric(
                                horizontal: small_50, vertical: tiny_50),
                            decoration: BoxDecoration(
                                color: greenSwatch.shade300,
                                borderRadius:
                                    const BorderRadius.all(normalRadius),
                                border:
                                    Border.all(color: greenSwatch.shade200)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Active",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: greenSwatch.shade900)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ])))
        : Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(smallRadius),
                color: Color.fromARGB(255, 193, 193, 193)),
            margin: const EdgeInsets.symmetric(vertical: small_100),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        ' Offer ID : ${offer!.id}',
                        style: const TextStyle(
                            fontSize: 13.0,
                            color: Color.fromARGB(255, 90, 89, 89)),
                      ),
                      const SizedBox(height: 16.0),
                      Column(children: [
                        const Divider(),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: large_100,
                              right: large_100,
                              bottom: small_100),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Text("Discount",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      offer!.offerDiscount.toString() + '%',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 10.0,
                                          color: Color(0xFF136DA5))),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: large_100,
                              right: large_100,
                              bottom: small_100),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Text("Expiration date ",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(f.format(offer!.offerExpiration!),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: large_100,
                              right: large_100,
                              bottom: small_100),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Text("Stock",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(offer!.offerStock.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xFF136DA5))),
                                ),
                              ]),
                        ),
                      ]),
                      const Divider(),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            width: large_200,
                            padding: const EdgeInsets.symmetric(
                                horizontal: small_50, vertical: tiny_50),
                            decoration: BoxDecoration(
                                color: redSwatch.shade300,
                                borderRadius:
                                    const BorderRadius.all(normalRadius),
                                border: Border.all(color: redSwatch.shade500)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('archived',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: greenSwatch.shade900)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ])));
  }
}

class $ {}
