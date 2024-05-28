import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/ui/pages/order_pages/order_pages.dart';
import 'package:provider/provider.dart';

import 'package:proximity_client/ui/widgets/address_picker/address_selection_screen.dart';

class ShippingAddressOrderScreen extends StatefulWidget {
  const ShippingAddressOrderScreen(
      {Key? key, required this.orderSliderValidation})
      : super(key: key);

  final OrderSliderValidation orderSliderValidation;
  @override
  _ShippingAddressOrderScreenState createState() =>
      _ShippingAddressOrderScreenState();
}

class _ShippingAddressOrderScreenState
    extends State<ShippingAddressOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SectionDivider(
            leadIcon: ProximityIcons.delivery,
            title: 'Delivery Infos.',
            color: blueSwatch.shade500),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
          child: GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressSelectionScreen(
                              currentAddress: Address(),
                              navigation: null,
                            )));
                widget.orderSliderValidation.addDeliveryAddresses(result);
              },
              /*  print("""/////""" + _result);
                              print(AddressItem.fromAdress(_result));,*/
              child: const Text("Add Delivery Area.",
                  style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5)))),

          // TertiaryButton(
          //     onPressed: () async {
          //       try {
          //         final Address _result = await Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => AreaSelectionScreen(
          //                     currentAddress: widget
          //                         .orderSliderValidation.deliveryAdresse)));

          //         widget.orderSliderValidation.addDeliveryAddresses(_result);
          //       } catch (e) {
          //         print(e);
          //       }

          //       //  policyCreationValidation
          //       //  .changeAddress(_result);
          //     },
          //     title: 'Set Delivery Area.'),
        ),
        Consumer<OrderSliderValidation>(
            builder: (context, orderSliderValidation, child) {
          return Column(
            children: [
              ...orderSliderValidation.deliveryAddresses!
                  .map((deliveryAddress) {
                return Row(children: [
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 18,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      orderSliderValidation
                          .deleteDeliveryAddresse(deliveryAddress.id);
                    },
                  ),
                  Expanded(
                      child: CheckboxListTile(
                    title: Padding(
                      padding:
                          const EdgeInsets.all(normal_100).copyWith(top: 0),
                      child: OrderDetails(details: {
                        'City': deliveryAddress.address!.city ?? "",
                        'Region': deliveryAddress.address!.region ?? "",
                        'Full Address':
                            deliveryAddress.address!.fullAddress ?? "",
                      }),
                    ),
                    value: deliveryAddress.selected,
                    onChanged: (value) {
                      setState(() {
                        orderSliderValidation.changeSelectDeliveryAddress(
                            value, deliveryAddress.id);
                      });
                    },
                  ))
                ]);
              }),
              // _buildNewStoreCategoryField(orderSliderValidation),
            ],
          );
        }),
        if (widget.orderSliderValidation.deliveryAdresse != null)
          Padding(
            padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
            child: OrderDetails(details: {
              'City': widget.orderSliderValidation.deliveryAdresse!.city ?? "",
              'Region':
                  widget.orderSliderValidation.deliveryAdresse!.region ?? "",
              'Full Address':
                  widget.orderSliderValidation.deliveryAdresse!.fullAddress ??
                      "",
            }),
          ),
        if (widget.orderSliderValidation.maxDeliveryFixe != null &&
            widget.orderSliderValidation.maxDeliveryFixe != 0.0)
          Padding(
            padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Delivery Price Fixed at ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF136DA5),
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: small_100),
                  Expanded(
                      child: Text(
                    ' € ${widget.orderSliderValidation.maxDeliveryFixe.toString()}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: const Color(0xFF136DA5), fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ]),
          )
        else if (widget.orderSliderValidation.distance != null &&
            widget.orderSliderValidation.distance != 0.0)
          Padding(
            padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
            child: Column(children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Distance ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF136DA5),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: small_100),
                    Expanded(
                        child: Text(
                      '${(widget.orderSliderValidation.distance ?? 1.0).toStringAsFixed(2)} Km ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF136DA5),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Km Price ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF136DA5),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: small_100),
                    Expanded(
                        child: Text(
                      '${(widget.orderSliderValidation.maxDeliveryKm ?? 1.0).toStringAsFixed(2)} Km ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF136DA5),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ]),
              const SizedBox(height: 20),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Delivery Price ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF136DA5),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: small_100),
                    Expanded(
                        child: Text(
                      ' € ${((widget.orderSliderValidation.maxDeliveryKm ?? 1.0) * (widget.orderSliderValidation.distance ?? 1.0)).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF136DA5),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ])
            ]),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
