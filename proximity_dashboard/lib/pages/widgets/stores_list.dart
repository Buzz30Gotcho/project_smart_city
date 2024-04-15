import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_dashboard/models/models.dart';

class StoresList extends StatelessWidget {
  const StoresList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Store> _stores = [
      Store(
          id: '02331813210',
          name: 'XIAOMI Smart-watch',
          address: 'Avenue de Montmartre, Montpellier 34070',
          seller: 'merabet@gmail.com',
          verified: false),
      Store(
          id: '02331813210',
          name: 'XIAOMI Smart-watch',
          address: 'Avenue de Montmartre, Montpellier 34070',
          seller: 'merabet@gmail.com',
          verified: false),
      Store(
          id: '02331813210',
          name: 'XIAOMI Smart-watch',
          address: 'Avenue de Montmartre, Montpellier 34070',
          seller: 'merabet@gmail.com',
          verified: true),
      Store(
          id: '02331813210',
          name: 'XIAOMI Smart-watch',
          address: 'Avenue de Montmartre, Montpellier 34070',
          seller: 'merabet@gmail.com',
          verified: true),
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
              1: FixedColumnWidth((MediaQuery.of(context).size.width / 9)),
              2: FixedColumnWidth((MediaQuery.of(context).size.width / 9)),
              3: FixedColumnWidth((MediaQuery.of(context).size.width / 9)),
              4: FixedColumnWidth((MediaQuery.of(context).size.width / 9)),
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
                    child: Text("Name.",
                        style: Theme.of(context).textTheme.subtitle2)),
                Container(
                    padding: const EdgeInsets.all(normal_100),
                    child: Text("Address.",
                        style: Theme.of(context).textTheme.subtitle2)),
                Container(
                    padding: const EdgeInsets.all(normal_100),
                    child: Text("Seller.",
                        style: Theme.of(context).textTheme.subtitle2)),
                Container(
                    padding: const EdgeInsets.all(normal_100),
                    child: Text("Verified.",
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
                    0: FixedColumnWidth((MediaQuery.of(context).size.width / 12)),
                    1: FixedColumnWidth((MediaQuery.of(context).size.width / 9)),
                    2: FixedColumnWidth((MediaQuery.of(context).size.width / 9)),
                    3: FixedColumnWidth((MediaQuery.of(context).size.width / 9)),
                    4: FixedColumnWidth((MediaQuery.of(context).size.width / 9)),
                    5: FixedColumnWidth((MediaQuery.of(context).size.width / 12)),
                  },
                  children: List<TableRow>.generate(
                      growable: true, _stores.length, (i) {
                    return TableRow(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: tiny_50,
                                    color: Theme.of(context).dividerColor))),
                        children: [
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: Text(_stores[i].id,
                                  style:
                                  Theme.of(context).textTheme.bodyText1)),
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: Text(_stores[i].name,
                                  style:
                                  Theme.of(context).textTheme.bodyText1)),
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: Text(_stores[i].address,
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              child: Text(_stores[i].seller,
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          Container(
                              padding: const EdgeInsets.all(normal_100),
                              alignment: Alignment.centerLeft,
                              child: _stores[i].verified? Icon(
                                Icons.check_rounded,
                                color: greenSwatch.shade300,
                              ) : Icon(
                                ProximityIcons.remove,
                                color: redSwatch.shade400,
                              )),
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
