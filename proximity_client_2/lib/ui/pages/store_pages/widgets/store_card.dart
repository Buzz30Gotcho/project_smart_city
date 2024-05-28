import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/store_repository/models/workingTime_model.dart';
import 'package:proximity_client/domain/store_repository/store_repository.dart';
import 'package:proximity_client/ui/pages/product_pages/view/product_screen.dart';
import 'package:proximity_client/ui/pages/store_pages/store_pages.dart';
import 'package:intl/intl.dart';

class StoreCard extends StatefulWidget {
  const StoreCard({Key? key, required this.store}) : super(key: key);

  final Store store;

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  final bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    void handleRaiting(rating, parentContext) {
      showDialogPopup(
          barrierDismissible: false,
          context: context,
          pageBuilder: (ctx, anim1, anim2) => StatefulBuilder(
              builder: (context, setState) => DialogPopup(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width - normal_200 * 2,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        const SizedBox(height: normal_100),
                        const Padding(
                            padding: EdgeInsets.only(
                                top: normal_100,
                                left: normal_100,
                                right: normal_100),
                            child: StarRatingStore()),
                        Padding(
                            padding: const EdgeInsets.all(normal_100),
                            child:
                                Row(mainAxisSize: MainAxisSize.max, children: [
                              Expanded(
                                  child: SecondaryButton(
                                      title: 'Cancel.',
                                      onPressed: () =>
                                          Navigator.of(context).pop())),
                              const SizedBox(
                                width: small_100,
                              ),
                              Expanded(
                                  child: SecondaryButton(
                                      title: 'Valider.',
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      })),
                            ]))
                      ])))));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ...[
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: small_100),
          child: Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(children: [
                    if (widget.store.image != null)
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
                                        child: (widget.store.image != null)
                                            ? Image.network(
                                                widget.store.image ?? "")
                                            : Image.network(
                                                "https://cdn-icons-png.flaticon.com/512/5853/5853761.png")))),
                          ])),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.store.name!,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start),
                  ]),
                  Row(
                    children: [
                      /*InkWell(
                        onTap: () {
                          handleRaiting(widget.store!.rating, context);
                        },
                        //child: StarRating(rating: widget.store!.rating!),
                      ),*/
                      widget.store.isNew()
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: small_50, vertical: tiny_50),
                              decoration: BoxDecoration(
                                  color: greenSwatch.shade300,
                                  borderRadius:
                                      const BorderRadius.all(normalRadius),
                                  border: Border.all(
                                      color: greenSwatch.shade200)),
                              child: Text("New",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: greenSwatch.shade900)),
                            )
                          : Container()
                    ],
                  )
                ])),
            TertiaryButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoreSearchedScreen(
                              store: widget.store,
                            ))),
                title: 'Go to Store.')
          ])),
      const SizedBox(height: small_100),
      Card(
          margin: const EdgeInsets.symmetric(horizontal: normal_100),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Theme.of(context).dividerColor, width: tiny_50),
              borderRadius: const BorderRadius.all(smallRadius)),
          child: SizedBox(
              height: huge_300,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                GoogleMapsAddress(
                    borderRadius: const BorderRadius.all(normalRadius),
                    latLng: LatLng(widget.store.address!.lat!,
                        widget.store.address!.lng!)),
                Container(
                    width: double.infinity,
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(2 / 3),
                    padding: const EdgeInsets.all(small_100)
                        .copyWith(right: huge_100),
                    child: Text(widget.store.address!.streetName ?? '',
                        style: Theme.of(context).textTheme.bodyLarge))
              ]))),
      const SizedBox(
          height: normal_100,
          child: Divider(height: tiny_50, thickness: tiny_50)),
    ]
    ]);
  }
}

class StoreSearchedScreen extends StatefulWidget {
  StoreSearchedScreen({Key? key, required this.store}) : super(key: key);
  Store store;

  @override
  State<StoreSearchedScreen> createState() => _StoreSearchedScreenState();
}

class _StoreSearchedScreenState extends State<StoreSearchedScreen> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget getWorkingTime(WorkingTime workingTime) {
      if (workingTime.option == '1' &&
          workingTime.fixedHours != null &&
          workingTime.fixedHours!.isNotEmpty) {
        // Fixed working hours for all days
        final timeRanges = workingTime.fixedHours!.map((range) {
          final startTime = range.openTime!.format(context);
          final endTime = range.closeTime!.format(context);
          return '$startTime - $endTime';
        }).toList();

        final days = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ];

        final workingTimeRows = days.map((day) {
          const isOpen = true; // All days are open for option '1'

          final dayWidget = Text(
            day,
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
          );

          final switchWidget = Switch(
            value: isOpen,
            activeColor: Colors.blue,
            onChanged: (newValue) {
              // Handle toggle switch state change
              // You can update the 'isOpen' state here
            },
          );

          final workingHoursWidgets = timeRanges.map((timeRange) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                timeRange,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }).toList();

          return Row(
            children: [
              SizedBox(width: 100, child: dayWidget),
              switchWidget,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: workingHoursWidgets,
                ),
              ),
            ],
          );
        }).toList();

        return Column(
          children: workingTimeRows,
        );
      } else if (workingTime.option == '2' &&
          workingTime.customizedHours != null &&
          workingTime.customizedHours!.isNotEmpty) {
        // Customized working hours for specific days
        final days = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ];

        final workingTimeRows = days.map((day) {
          final isOpen = workingTime.customizedHours!.containsKey(day);
          final timeRanges = isOpen
              ? workingTime.customizedHours![day]!.map((range) {
                  final startTime = range.openTime!.format(context);
                  final endTime = range.closeTime!.format(context);
                  return '$startTime - $endTime';
                }).toList()
              : ['Closed'];

          final dayWidget = Text(
            day,
            style:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
          );

          final switchWidget = Switch(
            value: isOpen,
            activeColor: Colors.blue,
            onChanged: (newValue) {
              // Handle toggle switch state change
              // You can update the 'isOpen' state here
            },
          );

          final workingHoursWidgets = timeRanges.map((timeRange) {
            return Padding(
              padding: const EdgeInsets.all(small_50),
              child: Text(
                timeRange,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }).toList();

          return Row(
            children: [
              SizedBox(width: huge_100, child: dayWidget),
              switchWidget,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: workingHoursWidgets,
                ),
              ),
            ],
          );
        }).toList();

        return Column(
          children: workingTimeRows,
        );
      }

      return const Text('No working hours available');
    }

    /// a boolean to help fetch data ONLY if necessary

    return Scaffold(
        body: (widget.store != null)
            ? SafeArea(
                child: Expanded(
                    child: ListView(children: [
                StoreMap(address: widget.store.address!),
                /*  StoreDetails(
                    image: widget.store!.image!,
                    name: widget.store!.name!,
                    rating: widget.store!.rating!),*/
                StoreDescription(description: widget.store.description!),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: small_100),
                  child: ExpansionPanelList(
                    elevation: 0,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (panelIndex, isExpanded) {
                      setState(() {
                        _isExpanded = !isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        backgroundColor: Colors.white,
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(
                                isStoreOpenNow(widget.store.workingTime!)
                                    ? 'Open'
                                    : 'Closed',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: isStoreOpenNow(
                                              widget.store.workingTime!)
                                          ? greenSwatch.shade900
                                          : redSwatch.shade900,
                                    )),
                          );
                        },
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.store.workingTime != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: normal_100),
                                child:
                                    getWorkingTime(widget.store.workingTime!),
                              ),
                          ],
                        ),
                        isExpanded: _isExpanded,
                      ),
                    ],
                  ),
                ),
                //StoreProducts
                /* SectionDivider(
                      leadIcon: ProximityIcons.product,
                      title: 'Store Products.',
                      color: Theme.of(context).primaryColor),
                (widget.store.products == null)
                      ? const ProductCardsSkeleton()
                      : MasonryGrid(
                          column: 2,
                          padding:
                              const EdgeInsets.symmetric(horizontal: small_100),
                          children: List.generate(
                              storeService.products!.length,
                              (i) => ProductCard(
                                  product: storeService.products![i]))),*/
                if (widget.store.policy != null)
                  Column(
                    children: [
                      SectionDivider(
                          leadIcon: ProximityIcons.policy,
                          title: 'Store Policy.',
                          color: Theme.of(context).primaryColor),
                      // MasonryGrid(
                      //delivery policy
                      widget.store.policy!.deliveryPolicy != null
                          ? const PolicyCard(
                              leadIcon: ProximityIcons.shipping,
                              title: "Shipping",
                              subTitle:
                                  "Estimated delivery time is  days. Shipping fees are will negociate for this product",
                            )
                          : Container(),

                      // pickup policy
                      widget.store.policy!.pickupPolicy != null &&
                              widget.store.policy!.pickupPolicy!.timeLimit !=
                                  null
                          ? PolicyCard(
                              leadIcon: ProximityIcons.self_pickup,
                              title: "Pick UP",
                              subTitle:
                                  "Remember to pick up your order from our store within ${widget.store.policy!.pickupPolicy!.timeLimit} days, or it will be returned to the shelves. Don't miss out on the chance to make it yours!.",
                            )
                          : Container(),
                      // reservation policy
                      widget.store.policy!.reservationPolicy != null
                          ? widget.store.policy!.reservationPolicy!.payment
                                  .free!
                              ? PolicyCard(
                                  leadIcon: Icons.book_online,
                                  title: "Reservation",
                                  subTitle:
                                      "Once your reservation is confirmed, you may pick up your item from our store within ${widget.store.policy!.reservationPolicy!.duration} days",
                                )
                              : widget.store.policy!.reservationPolicy!
                                          .payment.partial !=
                                      null
                                  ? PolicyCard(
                                      leadIcon: Icons.book_online,
                                      title: "Reservation",
                                      subTitle:
                                          "A deposit of ${widget.store.policy!.reservationPolicy!.payment.partial!.fixe} may be required to secure your reservation.Once your reservation is confirmed, you may pick up your item from our store within ${widget.store.policy!.reservationPolicy!.duration} days.",
                                    )
                                  : widget.store.policy!.reservationPolicy!
                                          .payment.free!
                                      ? widget.store.policy!.reservationPolicy!
                                              .payment.total!
                                          ? PolicyCard(
                                              leadIcon: Icons.book_online,
                                              title: "Reservation",
                                              subTitle:
                                                  "a full price payement is  required to secure your reservation.Once your reservation is confirmed, you may pick up your item from our store within ${widget.store.policy!.reservationPolicy!.duration} days.",
                                            )
                                          : Container()
                                      : Container()
                          : Container(),
// Return  Policy
                      widget.store.policy!.returnPolicy != null
                          ? widget.store.policy!.returnPolicy!.refund
                                          .shipping !=
                                      null
                              ? PolicyCard(
                                  leadIcon: Icons.settings_backup_restore,
                                  title: "Return and Refund  ",
                                  subTitle:
                                      "You may return your item within${widget.store.policy!.returnPolicy!.duration} days of receipt for a refund, provided that the item is${widget.store.policy!.returnPolicy!.productStatus}. in case the return is accepted , the store will refund shipping fees and ${widget.store.policy!.returnPolicy!.refund.order.fixe} % of the price  ",
                                )
                              : widget.store.policy!.returnPolicy!.refund
                                              .shipping ==
                                          null
                                  ? PolicyCard(
                                      leadIcon: Icons.settings_backup_restore,
                                      title: "Return and Refund  ",
                                      subTitle:
                                          "You may return your item within${widget.store.policy!.returnPolicy!.duration} days of receipt for a refund, provided that the item is${widget.store.policy!.returnPolicy!.productStatus}. in case the return is accepted , the store will refund ${widget.store.policy!.returnPolicy!.refund.order.fixe} % of the price , shipping fees are not refunded ",
                                    )
                                  : widget.store.policy!.returnPolicy!.refund
                                                  .shipping !=
                                              null &&
                                          widget.store.policy!.returnPolicy!
                                                  .refund.order ==
                                              null
                                      ? PolicyCard(
                                          leadIcon:
                                              Icons.settings_backup_restore,
                                          title: "Return and Refund  ",
                                          subTitle:
                                              "You may return your item within${widget.store.policy!.returnPolicy!.duration} days of receipt for a refund, provided that the item is${widget.store.policy!.returnPolicy!.productStatus}. in case the return is accepted , the store will refund shipping fees ",
                                        )
                                      : Container()
                          : Container(),
                    ],
                  )
                /*(storeService.products == null)
                      ? const ProductCardsSkeleton()
                      : MasonryGrid(
                          column: 2,
                          padding: const EdgeInsets.symmetric(horizontal: small_100),
                          children: List.generate(storeService.products!.length,
                              (i) => ProductCard(product: storeService.products![i]))),
                  const SizedBox(height: huge_200),*/
              ])))
            : const Column(
                children: [],
              ));
  }

  bool isStoreOpenNow(WorkingTime workingTime) {
    final currentDateTime = DateTime.now();

    if (workingTime.option == '1' &&
        workingTime.fixedHours != null &&
        workingTime.fixedHours!.isNotEmpty) {
      // Fixed working hours for all days
      for (final range in workingTime.fixedHours!) {
        final openTime = DateTime(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          range.openTime!.hour,
          range.openTime!.minute,
        );

        final closeTime = DateTime(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          range.closeTime!.hour,
          range.closeTime!.minute,
        );

        if (currentDateTime.isAfter(openTime) &&
            currentDateTime.isBefore(closeTime)) {
          return true;
        }
      }
    } else if (workingTime.option == '2' &&
        workingTime.customizedHours != null &&
        workingTime.customizedHours!.isNotEmpty) {
      // Customized working hours for specific days
      final currentDay = currentDateTime.weekday;
      final dayName = DateFormat('EEEE').format(currentDateTime);

      if (workingTime.customizedHours!.containsKey(dayName)) {
        final dayRanges = workingTime.customizedHours![dayName]!;
        for (final range in dayRanges) {
          final openTime = DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            range.openTime!.hour,
            range.openTime!.minute,
          );

          final closeTime = DateTime(
            currentDateTime.year,
            currentDateTime.month,
            currentDateTime.day,
            range.closeTime!.hour,
            range.closeTime!.minute,
          );

          if (currentDateTime.isAfter(openTime) &&
              currentDateTime.isBefore(closeTime)) {
            return true;
          }
        }
      }
    }

    return false;
  }
}
