import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/domain/store_repository/models/models.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen(
      {Key? key,
      required this.orderItems,
      required this.totalPrice,
      required this.policy})
      : super(key: key);

  final List<OrderItem> orderItems;
  final double totalPrice;
  final Policy policy;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderConfirmation>(
      create: (_) => OrderConfirmation(),
      builder: (context, child) {
        final OrderConfirmation orderConfirmation =
            Provider.of<OrderConfirmation>(context);

        return Consumer<OrderService>(builder: (context, orderService, child) {
          return Scaffold(
              body: SafeArea(
                  child: Stack(alignment: Alignment.bottomCenter, children: [
            ListView(children: const [
              TopBar(title: 'Order Confirmation.'),
              // SectionDivider(
              //     leadIcon: ProximityIcons.user,
              //     title: 'Personal Info.',
              //     color: redSwatch.shade500),
              // const PersonalInfoVisualizer(),
              // SectionDivider(
              //     leadIcon: ProximityIcons.shipping,
              //     title: 'Shipping Method.',
              //     color: redSwatch.shade500),
              // if (policy.shippingMethods!.length == 1)
              //   const SizedBox()
              // else
              //   Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: small_100),
              //     child: Row(
              //         children: List.generate(
              //             policy.shippingMethods!.length,
              //             (index) => Expanded(
              //                     child: Padding(
              //                   padding: const EdgeInsets.symmetric(
              //                       horizontal: small_100),
              //                   child: LargeIconButton(
              //                       onPressed: () =>
              //                           orderConfirmation.changeShippingMethod(
              //                               policy.shippingMethods![index]),
              //                       selected:
              //                           (orderConfirmation.shippingMethod ==
              //                               policy.shippingMethods![index]),
              //                       icon: DuotoneIcon(
              //                           primaryLayer: (index == 0)
              //                               ? ProximityIcons
              //                                   .self_pickup_duotone_1
              //                               : ProximityIcons.delivery_duotone_1,
              //                           secondaryLayer: (index == 0)
              //                               ? ProximityIcons
              //                                   .self_pickup_duotone_2
              //                               : ProximityIcons.delivery_duotone_2,
              //                           color: redSwatch.shade500),
              //                       title: (index == 0)
              //                           ? 'Self Pickup'
              //                           : 'Delivery'),
              //                 )))),
              //   ),
              // SectionDivider(
              //     leadIcon: ProximityIcons.credit_card,
              //     title: 'Payment Method.',
              //     color: redSwatch.shade500),
              // ListButton(
              //     title: '4242********4242',
              //     leadIcon: ProximityIcons.visa,
              //     color: blueSwatch.shade400,
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => const PaymentMethodScreen()));
              //     }),
              // UnconfirmedOrderTile(
              //   storeName: 'XIAOMI Store',
              //   orderItems: orderItems,
              //   totalPrice: totalPrice,
              // ),
              // const SizedBox(height: huge_100)
            ]),
            // PayNowBottomBar(
            //     totalPrice: '€ $totalPrice',
            //     buttonState: orderService.loading
            //         ? ButtonState.loading
            //         : (true)
            //             ? ButtonState.enabled
            //             : ButtonState.disabled,
            //     onPressed: () {
            //       orderService.payOrder(
            //           context,
            //           FormData.fromMap({
            //             "storeId": "62ea7dceb54f5844e0278dfa",
            //             "email": "hm_merabet@esi.dz",
            //             "way":" total",
            //             "billingAdress": {
            //               "name": "Mohamed malih merabet",
            //               "street2": "75 avenue Fliche Augustin ",
            //               "street1": "Cité U Triolet D21 ",
            //               "phone": "0749140358",
            //               "postalCode": "34000",
            //               "city": "Montpellier"
            //             },
            //             "cardNumber": "4242 4242 4242 4242",
            //             "cvc": "345",
            //             "expMonth": "12",
            //             "expYear": "2024"
            //           }));
            //     })
          ])));
        });
      },
    );
  }
}
