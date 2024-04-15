import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/order_pages/order_pages.dart';

class ReturnTabView extends StatefulWidget {
  const ReturnTabView({Key? key, this.page}) : super(key: key);

  final int? page;

  @override
  State<ReturnTabView> createState() => _ReturnTabViewState();
}

class _ReturnTabViewState extends State<ReturnTabView> {
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
      ordersService.getOrders("return", "all");
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
                    ordersService.getOrders("return", "all");
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
                    ordersService.getOrders("return", "pending");
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
                              Text(localizations!.pending,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text(localizations!.pending,
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
                    ordersService.getOrders("return", "waitingForReturn");
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
                              Text('Waiting for return',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text('Waiting for return',
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
                    ordersService.getOrders("return", "returned");
                    _index = 3;
                  }),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: normal_100),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 3) ...[
                              Text('Returned',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: redSwatch.shade500)),
                            ] else
                              Text('Returned',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          height: 0.9,
                                          color: Color.fromARGB(
                                              255, 150, 150, 150))),
                          ])),
                )),
              ]))),
      Expanded(child: () {
        switch (_index) {
          case 0:
            return (ordersService.loadingOrders)
                ? const Center(child: CircularProgressIndicator())
                : (ordersService.orders!.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: large_200, horizontal: large_100),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: huge_100,
                                width: huge_100,
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
                                                  child: Image.asset(
                                                    "assets/img/return_icon.png",
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                  )))),
                                    ])),
                            const SizedBox(height: normal_100),
                            Text(AppLocalizations.of(context)!.noRefundOrders,
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center),
                            const SizedBox(height: huge_100),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
                        itemCount: ordersService.orders!.length,
                        itemBuilder: (_, i) => OrderTile(
                            returnOrder: true,
                            order: ordersService.orders![i],
                            actionCancel: (String motif,
                                BuildContext contextCancel) async {
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
                            action: () async {
                              ordersService.updateStatus(
                                  ordersService.orders![i].id ?? "",
                                  ordersService.orders![i].waitingforReturn !=
                                          true
                                      ? "WaitingForReturn"
                                      : ordersService.orders![i].returned !=
                                              true
                                          ? "Returned"
                                          : "",
                                  "return",
                                  "all",
                                  true);
                            },
                            actionReturn: (String items,
                                BuildContext contextReturn) async {
                              ordersService.refundOrder(
                                  contextReturn,
                                  ordersService.orders![i].id ?? "",
                                  items,
                                  null,
                                  null,
                                  false);
                            }),
                      );
          case 1:
            return (ordersService.loadingOrders)
                ? const Center(child: CircularProgressIndicator())
                : (ordersService.orders!.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: large_200, horizontal: large_100),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: huge_100,
                                width: huge_100,
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
                                                  child: Image.asset(
                                                    "assets/img/return_icon.png",
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                  )))),
                                    ])),
                            const SizedBox(height: normal_100),
                            Text("There are no Return Orders.",
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center),
                            const SizedBox(height: huge_100),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
                        itemCount: ordersService.orders!.length,
                        itemBuilder: (_, i) => OrderTile(
                          returnOrder: true,
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
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: large_200, horizontal: large_100),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: huge_100,
                                width: huge_100,
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
                                                  child: Image.asset(
                                                    "assets/img/return_icon.png",
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                  )))),
                                    ])),
                            const SizedBox(height: normal_100),
                            Text("There are no - Waiting for return - Orders.",
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center),
                            const SizedBox(height: huge_100),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
                        itemCount: ordersService.orders!.length,
                        itemBuilder: (_, i) => OrderTile(
                            returnOrder: true,
                            order: ordersService.orders![i],
                            actionCancel: (String motif,
                                BuildContext contextCancel) async {
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
                            actionReturn: (String items,
                                BuildContext contextReturn) async {
                              ordersService.refundOrder(
                                  contextReturn,
                                  ordersService.orders![i].id ?? "",
                                  items,
                                  null,
                                  null,
                                  false);
                            }),
                      );
          case 3:
            return (ordersService.loadingOrders)
                ? const Center(child: CircularProgressIndicator())
                : (ordersService.orders!.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: large_200, horizontal: large_100),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: huge_100,
                                width: huge_100,
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
                                                  child: Image.asset(
                                                    "assets/img/return_icon.png",
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                  )))),
                                    ])),
                            const SizedBox(height: normal_100),
                            Text("There are no Returned Orders.",
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center),
                            const SizedBox(height: huge_100),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
                        itemCount: ordersService.orders!.length,
                        itemBuilder: (_, i) => OrderTile(
                          returnOrder: true,
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
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: large_200, horizontal: large_100),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: huge_100,
                                width: huge_100,
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
                                                  child: Image.asset(
                                                    "assets/img/return_icon.png",
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                  )))),
                                    ])),
                            const SizedBox(height: normal_100),
                            Text(AppLocalizations.of(context)!.noRefundOrders,
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center),
                            const SizedBox(height: huge_100),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding:
                            const EdgeInsets.symmetric(vertical: normal_100),
                        itemCount: ordersService.orders!.length,
                        itemBuilder: (_, i) => OrderTile(
                          returnOrder: true,
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
