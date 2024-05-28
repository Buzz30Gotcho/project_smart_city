import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/models/infosContact_model.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/domain/product_repository/models/models.dart';

import 'package:proximity_client/ui/pages/order_pages/order_pages.dart';

class CartSliderScreen extends StatefulWidget {
  CartSliderScreen(
      {Key? key,
      required this.products,
      this.cartId,
      this.storeId,
      this.storeAddress,
      this.maxDeliveryFixe,
      this.maxDeliveryKm,
      this.reservation,
      this.pickupPersons,
      this.cards,
      this.orderId})
      : super(key: key);
  List<ProductCart> products;
  String? cartId;
  String? storeId;
  String? orderId;
  Address? storeAddress;
  double? maxDeliveryFixe;
  double? maxDeliveryKm;
  bool? reservation;
  List<PickupPerson>? pickupPersons;
  List<InfosContact>? cards;

  @override
  State<CartSliderScreen> createState() => _CartSliderScreenState();
}

class _CartSliderScreenState extends State<CartSliderScreen> {
  @override
  int _currentStep = 0;
  bool isLastStep = false;

  void onPay(int value) {
    setState(() {
      _currentStep = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    print("CartSliderScreen");
    return ChangeNotifierProvider<OrderSliderValidation>(
        // create: (context) => orderSliderValidation.setStore(store),

        create: (context) => OrderSliderValidation.initProducts(
            widget.products,
            widget.cartId,
            widget.storeId,
            widget.storeAddress,
            widget.maxDeliveryFixe,
            widget.maxDeliveryKm,
            widget.orderId,
            widget.pickupPersons,
            widget.cards),
        child: Consumer2<OrderSliderValidation, OrderService>(
            builder: (context, orderSliderValidation, orderService, child) {
          print("widget.pickupPersons");
          print(widget.pickupPersons);
          return Scaffold(
              appBar: AppBar(
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: TopBar(
                      title: widget.reservation == true
                          ? localizations!.reservation
                          : localizations!.order),
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: SafeArea(
                child: Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Stepper(
                        physics: const ClampingScrollPhysics(),
                        elevation: 0.0,
                        currentStep: _currentStep,
                        type: StepperType.horizontal,
                        onStepContinue: () {
                          if (_currentStep == 0) {
                            bool pickup =
                                orderSliderValidation.getPickupItemsTotal() !=
                                    0.0;
                            bool delivery = orderSliderValidation
                                .getDeliveryItems()
                                .isNotEmpty;

                            bool pickupValidation = orderSliderValidation
                                .pickupPersons!
                                .where((element) => element.selected)
                                .isNotEmpty;
                            bool deliveryValidation = orderSliderValidation
                                .deliveryAddresses!
                                .where((element) => element.selected)
                                .isNotEmpty;

                            if (!((pickup && !pickupValidation) ||
                                (delivery && !deliveryValidation))) {
                              setState(() {
                                _currentStep = _currentStep + 1;
                              });
                            }
                          } else {
                            _currentStep == 2
                                ? null
                                : _currentStep == 3
                                    ? () {
                                        orderService.getOrders(
                                            "reservation", "all");
                                        Navigator.pop(context);
                                      }()
                                    : setState(() {
                                        _currentStep = _currentStep + 1;
                                      });
                          }
                        },
                        onStepCancel: () {
                          _currentStep == 0
                              ? null
                              : setState(() {
                                  _currentStep -= 1;
                                  print(_currentStep);
                                });
                        },
                        controlsBuilder: (context, details) {
                          return Padding(
                            padding: const EdgeInsets.all(small_100),
                            child: Row(
                              mainAxisAlignment:
                                  _currentStep != 0 && _currentStep != 3
                                      ? MainAxisAlignment.spaceBetween
                                      : _currentStep == 3
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (_currentStep != 0 && _currentStep < 3)
                                  SecondaryButton(
                                      onPressed: details.onStepCancel,
                                      title:
                                          AppLocalizations.of(context)!.back),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (_currentStep != 2)
                                      PrimaryButton(
                                        buttonState: ButtonState.enabled,
                                        onPressed: details.onStepContinue,
                                        title: _currentStep == 3
                                            ? localizations.done
                                            : localizations.next,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        steps: [
                          getOrderItemsStep(orderSliderValidation, context),
                          getBillsStep(orderSliderValidation, context),
                          getPaymentStep(
                              orderSliderValidation, orderService, context),
                          getDoneStep(orderSliderValidation, context),
                        ],
                      )),
                ),
              ));
        }));
  }

  Step getOrderItemsStep(
      OrderSliderValidation orderSliderValidation, BuildContext context) {
    print(orderSliderValidation.products);
    double productPickupTotal = orderSliderValidation.getPickupItemsTotal();
    int deliveryProducts = orderSliderValidation.getDeliveryItems().length;
    return Step(
        isActive: _currentStep >= 0,
        title: Text(AppLocalizations.of(context)!.items),
        content: Column(
          children: [
            Column(children: [
              for (var item in orderSliderValidation.products)
                CardItem(
                  product: item,
                  orderSliderValidation: orderSliderValidation,
                  reservation: widget.reservation!,
                ),
              if (deliveryProducts > 0)
                ShippingAddressOrderScreen(
                    orderSliderValidation: orderSliderValidation),
              if (productPickupTotal != 0.0)
                PickupPersonScreen(
                    orderSliderValidation: orderSliderValidation),
            ]),
          ],
        ));
  }

  Step getBillsStep(
      OrderSliderValidation orderSliderValidation, BuildContext context) {
    double productReservationTotal =
        orderSliderValidation.getReservationItemsTotal();
    bool productDeliveryTotal =
        orderSliderValidation.getDeliveryItems().isNotEmpty;
    double productPickupTotal = orderSliderValidation.getPickupItemsTotal();
    return Step(
        isActive: _currentStep >= 1,
        title: Text(AppLocalizations.of(context)!.bills),
        content: Column(
          children: [
            Column(children: [
              if (productReservationTotal != 0.0 && !widget.reservation!)
                BillItem(
                    orderSliderValidation: orderSliderValidation,
                    reservationBill: true,
                    deliveryBill: false,
                    pickupBill: false,
                    payment: false,
                    reservation: widget.reservation ?? false),
              if (productDeliveryTotal)
                BillItem(
                  orderSliderValidation: orderSliderValidation,
                  reservationBill: false,
                  deliveryBill: true,
                  pickupBill: false,
                  payment: false,
                  reservation: widget.reservation ?? false,
                ),
              if (productPickupTotal != 0.0)
                BillItem(
                  orderSliderValidation: orderSliderValidation,
                  reservationBill: false,
                  deliveryBill: false,
                  pickupBill: true,
                  payment: false,
                  reservation: widget.reservation ?? false,
                ),
              BillItem(
                orderSliderValidation: orderSliderValidation,
                reservationBill: false,
                deliveryBill: false,
                pickupBill: false,
                payment: false,
                reservation: widget.reservation ?? false,
              ),
            ]),
          ],
        ));
  }

  Step getPaymentStep(OrderSliderValidation orderSliderValidation,
      OrderService orderService, BuildContext context) {
    return Step(
        isActive: _currentStep >= 2,
        title: Text(AppLocalizations.of(context)!.payment),
        content: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: small_100),
                child: PaymentMethodScreen(
                    orderSliderValidation: orderSliderValidation,
                    orderService: orderService,
                    onPay: onPay)),
            // PaymentMethodScreenCard(
            //     orderSliderValidation: orderSliderValidation,
            //     orderService: orderService,
            //     onPay: onPay)),
          ],
        ));
  }

  Step getDoneStep(
      OrderSliderValidation orderSliderValidation, BuildContext context) {
    return Step(
        isActive: _currentStep >= 3,
        title: Text(AppLocalizations.of(context)!.done),
        content: Column(
          children: [
            Column(children: [
              BillItem(
                  orderSliderValidation: orderSliderValidation,
                  reservationBill: false,
                  deliveryBill: false,
                  pickupBill: false,
                  payment: true),
              const Icon(ProximityIcons.check_filled,
                  size: huge_200, color: Colors.green),

              // FittedBox(
              //   child: Image.asset("assets/img/welcome.png"),
              //   fit: BoxFit.fill,
              // ),
            ]),
            InfoMessage(message: AppLocalizations.of(context)!.orderSuccess),
            const SizedBox(height: 40),
          ],
        ));
  }
}
