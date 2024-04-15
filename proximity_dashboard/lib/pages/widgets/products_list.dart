import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_dashboard/models/models.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> _products = [
      Product(
          id: '02331813210',
          name: 'XIAOMI Smart-watch',
          price: 14.99,
          quantity: 280,
          image: 'assets/img/products/product-1.png'),
      Product(
          id: '85154532165',
          name: 'Google Pixel 6',
          price: 569.99,
          quantity: 47,
          image: 'assets/img/products/product-8.png'),
      Product(
          id: '75313565116',
          name: 'Redmi Airdots',
          price: 39.99,
          quantity: 14,
          image: 'assets/img/products/product-9.png'),
      Product(
          id: '13453213218',
          name: 'G-force RGB Keyboard with all the interesting features',
          price: 73.49,
          quantity: 78,
          image: 'assets/img/products/product-2.png')
    ];

    return Card(
      margin: const EdgeInsets.all(normal_100),
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width < 1300
              ? MediaQuery.of(context).size.width - 100
              : MediaQuery.of(context).size.width - 330,
          padding: const EdgeInsets.only(bottom: small_100),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: tiny_50, color: Theme.of(context).dividerColor))),
          child: Table(
            columnWidths: <int, TableColumnWidth>{
              0: FixedColumnWidth((MediaQuery.of(context).size.width / 12)),
              1: FixedColumnWidth((MediaQuery.of(context).size.width / 12)),
              2: FixedColumnWidth((MediaQuery.of(context).size.width / 3)),
              3: FixedColumnWidth((MediaQuery.of(context).size.width / 12)),
              4: FixedColumnWidth((MediaQuery.of(context).size.width / 12)),
              5: FixedColumnWidth((MediaQuery.of(context).size.width / 12)),
            },
            children: [
              TableRow(decoration: const BoxDecoration(), children: [
                Container(
                    padding: const EdgeInsets.all(normal_100),
                    child: Text("ID.",
                        style: Theme.of(context).textTheme.subtitle2)),
                Container(
                    padding: const EdgeInsets.all(normal_100),
                    child: Text("Image.",
                        style: Theme.of(context).textTheme.subtitle2)),
                Container(
                    padding: const EdgeInsets.all(normal_100),
                    child: Text("Name.",
                        style: Theme.of(context).textTheme.subtitle2)),
                Container(
                    padding: const EdgeInsets.all(normal_100),
                    child: Text("Price.",
                        style: Theme.of(context).textTheme.subtitle2)),
                Container(
                    padding: const EdgeInsets.all(normal_100),
                    child: Text("Quantity.",
                        style: Theme.of(context).textTheme.subtitle2)),
                const SizedBox()
              ]),
            ],
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
              width: MediaQuery.of(context).size.width < 1300
                  ? MediaQuery.of(context).size.width - 100
                  : MediaQuery.of(context).size.width - 330,
              // padding: EdgeInsets.all(32),
              child: Table(
                  columnWidths: <int, TableColumnWidth>{
                    0: FixedColumnWidth(
                        (MediaQuery.of(context).size.width / 12)),
                    1: FixedColumnWidth(
                        (MediaQuery.of(context).size.width / 12)),
                    2: FixedColumnWidth(
                        (MediaQuery.of(context).size.width / 3)),
                    3: FixedColumnWidth(
                        (MediaQuery.of(context).size.width / 12)),
                    4: FixedColumnWidth(
                        (MediaQuery.of(context).size.width / 12)),
                    5: FixedColumnWidth(
                        (MediaQuery.of(context).size.width / 12)),
                  },
                  children: List<TableRow>.generate(
                      growable: true, _products.length, (i) {
                    return TableRow(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: tiny_50,
                                    color: Theme.of(context).dividerColor))),
                        children: [
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: Text(_products[i].id,
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Card(
                                  child: Padding(
                                      padding: const EdgeInsets.all(tiny_50),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              innerBorderRadius),
                                          child: Image.asset(
                                            _products[i].image,
                                            fit: BoxFit.fill,
                                          ))),
                                ),
                              )),
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: Text(_products[i].name,
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: Text(_products[i].price.toString(),
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: Text(_products[i].quantity.toString(),
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          Padding(
                            padding: const EdgeInsets.all(small_100),
                            child: SmallIconButton(
                                onPressed: () {},
                                icon: const Icon(ProximityIcons.edit)),
                          )
                        ]);
                  }))),
        ))
      ]),
    );
  }
}
