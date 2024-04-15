import 'package:flutter/material.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/l10n/app_localizations_ar.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/ui/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key, this.page}) : super(key: key);

  final int? page;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const TopBar(title: 'My Orders.'),
      Material(
          color: Colors.transparent,
          child: Container(
              height: large_200,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: tiny_50))),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        ordersService.getOrders("all", "Pending");
                        setState(() {
                          _index = 0;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 0) ...[
                              DuotoneIcon(
                                primaryLayer: ProximityIcons.unpaid_duotone_1,
                                secondaryLayer: ProximityIcons.unpaid_duotone_1,
                                color: redSwatch.shade500,
                              ),
                              Text(localizations!.pending,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(height: 0.9, fontSize: 7)),
                              const SizedBox(height: tiny_50),
                              Container(
                                  height: tiny_50,
                                  width: normal_150,
                                  decoration: BoxDecoration(
                                      color: redSwatch.shade500,
                                      borderRadius:
                                          const BorderRadius.all(tinyRadius)))
                            ] else
                              const Icon(ProximityIcons.credit_card),
                          ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        ordersService.getOrders("pickup", "all");
                        setState(() {
                          _index = 1;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 1) ...[
                              DuotoneIcon(
                                primaryLayer:
                                    ProximityIcons.self_pickup_duotone_1,
                                secondaryLayer:
                                    ProximityIcons.self_pickup_duotone_2,
                                color: redSwatch.shade500,
                              ),
                              Text(localizations!.selfPickup,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(height: 0.9, fontSize: 7)),
                              const SizedBox(height: tiny_50),
                              Container(
                                  height: tiny_50,
                                  width: normal_150,
                                  decoration: BoxDecoration(
                                      color: redSwatch.shade500,
                                      borderRadius:
                                          const BorderRadius.all(tinyRadius)))
                            ] else
                              const Icon(ProximityIcons.self_pickup),
                          ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        ordersService.getOrders("delivery", "all");
                        setState(() {
                          _index = 2;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 2) ...[
                              DuotoneIcon(
                                primaryLayer: ProximityIcons.delivery_duotone_1,
                                secondaryLayer:
                                    ProximityIcons.delivery_duotone_2,
                                color: redSwatch.shade500,
                              ),
                              Text(localizations!.delivery,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(height: 0.9, fontSize: 7)),
                              const SizedBox(height: tiny_50),
                              Container(
                                  height: tiny_50,
                                  width: normal_150,
                                  decoration: BoxDecoration(
                                      color: redSwatch.shade500,
                                      borderRadius:
                                          const BorderRadius.all(tinyRadius)))
                            ] else
                              const Icon(ProximityIcons.delivery),
                          ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        ordersService.getOrders("reservation", "all");
                        setState(() {
                          _index = 3;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 3) ...[
                              DuotoneIcon(
                                primaryLayer: ProximityIcons.history_duotone_1,
                                secondaryLayer:
                                    ProximityIcons.history_duotone_2,
                                color: redSwatch.shade500,
                              ),
                              Text('Reservation',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(height: 0.9, fontSize: 7)),
                              const SizedBox(height: tiny_50),
                              Container(
                                  height: tiny_50,
                                  width: normal_150,
                                  decoration: BoxDecoration(
                                      color: redSwatch.shade500,
                                      borderRadius:
                                          const BorderRadius.all(tinyRadius)))
                            ] else
                              const Icon(ProximityIcons.history),
                          ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        ordersService.getOrders("return", "all");
                        setState(() {
                          _index = 5;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 5) ...[
                              SizedBox(
                                  height: 25,
                                  width: 25,
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
                                                        "assets/img/return_icon2.png")))),
                                      ])),
                              Text(localizations!.returnOrder,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(height: 0.9, fontSize: 7)),
                              const SizedBox(height: tiny_50),
                              Container(
                                  height: tiny_50,
                                  width: normal_150,
                                  decoration: BoxDecoration(
                                      color: redSwatch.shade500,
                                      borderRadius:
                                          const BorderRadius.all(tinyRadius)))
                            ] else
                              SizedBox(
                                  height: 25,
                                  width: 25,
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
                                                        "assets/img/return_icon.png")))),
                                      ])),
                          ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        ordersService.getOrders("refund", "all");
                        setState(() {
                          _index = 6;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 6) ...[
                              SizedBox(
                                  height: 25,
                                  width: 25,
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
                                                        "assets/img/refund_icon.png")))),
                                      ])),
                              Text(localizations!.refund,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(height: 0.9, fontSize: 7)),
                              const SizedBox(height: tiny_50),
                              Container(
                                  height: tiny_50,
                                  width: normal_150,
                                  decoration: BoxDecoration(
                                      color: redSwatch.shade500,
                                      borderRadius:
                                          const BorderRadius.all(tinyRadius)))
                            ] else
                              SizedBox(
                                  height: 25,
                                  width: 25,
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
                                                        "assets/img/refund_icon2.png")))),
                                      ])),
                          ]),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        ordersService.getOrders("all", "Canceled");
                        setState(() {
                          _index = 4;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_index == 4) ...[
                              DuotoneIcon(
                                primaryLayer: ProximityIcons.rejected_duotone_1,
                                secondaryLayer:
                                    ProximityIcons.rejected_duotone_2,
                                color: Color(0xFFFC185A),
                              ),
                              Text(localizations!.rejected,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(height: 0.9, fontSize: 7)),
                              const SizedBox(height: tiny_50),
                              Container(
                                  height: tiny_50,
                                  width: normal_150,
                                  decoration: BoxDecoration(
                                      color: redSwatch.shade500,
                                      borderRadius:
                                          const BorderRadius.all(tinyRadius)))
                            ] else
                              const Icon(ProximityIcons.rejected),
                          ]),
                    )),
                  ]))),
      Expanded(child: () {
        switch (_index) {
          case 0:
            return const PendingTabView();
          case 1:
            return const SelfPickupTabView();
          case 2:
            return const DeliveryTabView();
          case 3:
            return const ReservationTabView();
          case 4:
            return const RejectedTabView();
          case 5:
            return const ReturnTabView();
          case 6:
            return const RefundTabView();
          default:
            return const PendingTabView();
        }
      }())
    ])));
  }
}
