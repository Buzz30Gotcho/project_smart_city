// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:proximity/proximity.dart';
// import 'package:proximity_client/domain/order_repository/order_repository.dart';
// import 'package:proximity_client/domain/store_repository/models/models.dart';
// import 'package:proximity_client/ui/pages/pages.dart';
//
// class OrderConfirmationScreen extends StatelessWidget {
//   const OrderConfirmationScreen(
//       {Key? key,
//       required this.orderItems,
//       required this.totalPrice,
//       required this.policy})
//       : super(key: key);
//
//   final List<OrderItem> orderItems;
//   final double totalPrice;
//   final Policy policy;
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<OrderConfirmation>(
//       create: (_) => OrderConfirmation(),
//       builder: (context, child) {
//         final OrderConfirmation orderConfirmation =
//             Provider.of<OrderConfirmation>(context);
//
//         return Scaffold(
//             body: SafeArea(
//                 child: Stack(alignment: Alignment.bottomCenter, children: [
//           ListView(children: [
//             const TopBar(title: 'Order Confirmation.'),
//             SectionDivider(
//                 leadIcon: ProximityIcons.user,
//                 title: 'Personal Info.',
//                 color: redSwatch.shade500),
//             const PersonalInfoVisualizer(),
//             SectionDivider(
//                 leadIcon: ProximityIcons.shipping,
//                 title: 'Shipping Method.',
//                 color: redSwatch.shade500),
//             if (policy.shippingMethods!.length == 1)
//               const SizedBox()
//             else
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: small_100),
//                 child: Row(
//                     children: List.generate(
//                         policy.shippingMethods!.length,
//                         (index) => Expanded(
//                                 child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: small_100),
//                               child: LargeIconButton(
//                                   onPressed: () =>
//                                       orderConfirmation.changeShippingMethod(
//                                           policy.shippingMethods![index]),
//                                   selected: (orderConfirmation.shippingMethod ==
//                                       policy.shippingMethods![index]),
//                                   icon: DuotoneIcon(
//                                       primaryLayer:
//                                           ProximityIcons.self_pickup_duotone_1,
//                                       secondaryLayer:
//                                           ProximityIcons.self_pickup_duotone_2,
//                                       color: redSwatch.shade500),
//                                   title: 'Self Pickup'),
//                             )))),
//               ),
//             SectionDivider(
//                 leadIcon: ProximityIcons.credit_card,
//                 title: 'Payment Method.',
//                 color: redSwatch.shade500),
//             ListButton(
//                 title: '474503******8511',
//                 leadIcon: ProximityIcons.visa,
//                 color: blueSwatch.shade400,
//                 onPressed: () {}),
//             UnconfirmedOrderTile(
//               storeName: 'XIAOMI Store',
//               orderItems: orderItems,
//               totalPrice: totalPrice,
//             ),
//             const SizedBox(height: huge_100)
//           ]),
//           PayNowBottomBar(totalPrice: '€ $totalPrice', onPressed: () {})
//         ])));
//       },
//     );
//   }
// }
