import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/l10n/app_localizations_ar.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/order_pages/order_pages.dart';

class RejectedTabView extends StatefulWidget {
  const RejectedTabView({Key? key, this.page}) : super(key: key);

  final int? page;

  @override
  State<RejectedTabView> createState() => _RejectedTabViewState();
}

class _RejectedTabViewState extends State<RejectedTabView> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    final localizations = AppLocalizations.of(context);
    if (ordersService.orders == null && _index == 0) {
      ordersService.getOrders("all", "Canceled");
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
                    ordersService.getOrders("all", "Canceled");
                    setState(() {
                      _index = 0;
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 0) ...[
                              Text(localizations!.all,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(localizations!.all,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    ordersService.getOrders("pickup", "Canceled");
                    setState(() {
                      _index = 1;
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 1) ...[
                              Text(localizations!.selfPickup,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(localizations!.selfPickup,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    ordersService.getOrders("delivery", "Canceled");
                    setState(() {
                      _index = 2;
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 2) ...[
                              Text(localizations!.delivery,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(localizations!.delivery,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    ordersService.getOrders("reservation", "Canceled");
                    setState(() {
                      _index = 3;
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 3) ...[
                              Text('Reservation',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text('Reservation',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () => setState(() {
                    _index = 4;
                  }),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 4) ...[
                              Text(localizations!.returnOrder,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(localizations!.returnOrder,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                ))
              ]))),
      Expanded(child: () {
        switch (_index) {
          case 0:
            return (ordersService.loadingOrders)
                ? const Center(child: CircularProgressIndicator())
                : (ordersService.orders!.isEmpty)
                    ? const NoResults(
                        icon: ProximityIcons.rejected,
                        message: 'There are no Rejected Orders.')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
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
                        ),
                      );
          case 1:
            return (ordersService.loadingOrders)
                ? const Center(child: CircularProgressIndicator())
                : (ordersService.orders!.isEmpty)
                    ? const NoResults(
                        icon: ProximityIcons.rejected,
                        message: 'There are no Rejected Orders.')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
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
                        ),
                      );
          case 2:
            return (ordersService.loadingOrders)
                ? const Center(child: CircularProgressIndicator())
                : (ordersService.orders!.isEmpty)
                    ? const NoResults(
                        icon: ProximityIcons.rejected,
                        message: 'There are no Rejected Orders.')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
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
                        ),
                      );
          default:
            return (ordersService.loadingOrders)
                ? const Center(child: CircularProgressIndicator())
                : (ordersService.orders!.isEmpty)
                    ? const NoResults(
                        icon: ProximityIcons.rejected,
                        message: 'There are no Rejected Orders.')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
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
                        ),
                      );
        }
      }())
    ]);
  }
}
