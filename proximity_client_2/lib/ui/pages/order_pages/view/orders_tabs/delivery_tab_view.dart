import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/ui/pages/order_pages/order_pages.dart';

class DeliveryTabView extends StatefulWidget {
  const DeliveryTabView({Key? key, this.page}) : super(key: key);

  final int? page;

  @override
  State<DeliveryTabView> createState() => _DeliveryTabViewState();
}

class _DeliveryTabViewState extends State<DeliveryTabView> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    if (ordersService.orders == null && _index == 0) {
      ordersService.getOrders("delivery", "all");
    }
    return Column(children: [
      Material(
          color: Colors.transparent,
          child: Container(
              height: large_100,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.shade300, width: tiny_50))),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    ordersService.getOrders("delivery", "all");
                    setState(() {
                      _index = 0;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 0) ...[
                              Text(AppLocalizations.of(context)!.all,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(AppLocalizations.of(context)!.all,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: const Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    ordersService.getOrders("delivery", "Pending");
                    setState(() {
                      _index = 1;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 1) ...[
                              Text(AppLocalizations.of(context)!.pending,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(AppLocalizations.of(context)!.pending,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: const Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    ordersService.getOrders("delivery", "InPreparation");
                    setState(() {
                      _index = 2;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 2) ...[
                              Text(AppLocalizations.of(context)!.inPreparation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(AppLocalizations.of(context)!.inPreparation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: const Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    ordersService.getOrders("delivery", "OnTheWay");
                    setState(() {
                      _index = 3;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 3) ...[
                              Text(AppLocalizations.of(context)!.onTheWay,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(AppLocalizations.of(context)!.onTheWay,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: const Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    ordersService.getOrders("delivery", "Delivered");
                    setState(() {
                      _index = 4;
                    });
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 4) ...[
                              Text(AppLocalizations.of(context)!.delivered,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(AppLocalizations.of(context)!.delivered,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          height: 0.9,
                                          color: const Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
              ]))),
      Expanded(
        child: (ordersService.loadingOrders)
            ? const Center(child: CircularProgressIndicator())
            : (ordersService.orders!.isEmpty)
                ? NoResults(
                    icon: ProximityIcons.delivery_duotone_1,
                    message: _index == 2
                        ? AppLocalizations.of(context)!.noInPreparationOrders
                        : _index == 3
                            ? AppLocalizations.of(context)!.noOnTheWayOrders
                            : _index == 4
                                ? AppLocalizations.of(context)!
                                    .noDeliveredOrders
                                : AppLocalizations.of(context)!
                                    .noDeliveryOrders)
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: normal_100),
                    itemCount: ordersService.orders!.length,
                    itemBuilder: (_, i) => OrderTile(
                      order: ordersService.orders![i],
                      actionCancel:
                          (String motif, BuildContext contextCancel) async {
                        // final bool _result = await PaymentDialogs.cancelOrder(
                        //     context,
                        //     ordersService.orders![i].id,
                        //     ordersService);
                        // if (_result == true) {
                        ordersService.cancelOrder(
                            contextCancel,
                            ordersService.orders![i].id ?? "",
                            motif,
                            null,
                            null,
                            false);
                        // }
                      },
                      actionReturn: (String motif, String items,
                          BuildContext contextReturn) async {
                        // final bool _result = await PaymentDialogs.cancelOrder(
                        //     context,
                        //     ordersService.orders![i].id,
                        //     ordersService);
                        // if (_result == true) {
                        ordersService.returnOrder(
                            contextReturn,
                            ordersService.orders![i].id ?? "",
                            motif,
                            items,
                            null,
                            null,
                            false);
                        // }
                      },
                      action: () {} // index 4
                      ,
                    ),
                  ),
      )
    ]);
  }
}
