import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:pay/pay.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
//import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen(
      {Key? key,
      required this.returnScreenValidation,
      required this.orderService,
      this.onPay})
      : super(key: key);

  final ReturnScreenValidation returnScreenValidation;
  final OrderService orderService;
  final ValueChanged<int>? onPay;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Color(0xFF000000),
      minimumSize: Size(double.infinity, 50),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    );

    double total = 0.0;
    final _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '$total',
        status: PaymentItemStatus.final_price,
      )
    ];
    const String defaultGooglePay = '''{
      "provider": "google_pay",
      "data": {
        "environment": "TEST",
        "apiVersion": 2,
        "apiVersionMinor": 0,
        "allowedPaymentMethods": [
          {
            "type": "CARD",
            "tokenizationSpecification": {
              "type": "PAYMENT_GATEWAY",
              "parameters": {
                "gateway": "example",
                "gatewayMerchantId": "gatewayMerchantId"
              }
            },
            "parameters": {
              "allowedCardNetworks": ["VISA", "MASTERCARD"],
              "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
              "billingAddressRequired": true,
              "billingAddressParameters": {
                "format": "FULL",
                "phoneNumberRequired": true
              }
            }
          }
        ],
        "merchantInfo": {
          "merchantId": "01234567890123456789",
          "merchantName": "Store Name"
        },
        "transactionInfo": {
          "countryCode": "FR",
          "currencyCode": "EUR"
        }
      }
    }''';

    void onGooglePayResult(paymentResult) {
      // Send the resulting Google Pay token to your server / PSP
      print(paymentResult);
    }

    var _controller =
        new TextEditingController(text: returnScreenValidation.expdate);
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Material(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(4.0),
        //   child: InkWell(
        //     onTap: () => {
        //                 onPay!.call(
        //                   3
        //                 )},
        //     child: Container(
        //       height: 48.0,
        //       padding: EdgeInsets.symmetric(horizontal: 16.0),
        //       child: Row(
        //         children: [
        //           Image.asset(
        //           'assets/google-pay.png' ,
        //           width: 24.0,
        //           height: 24.0),
        //           SizedBox(width: 16.0),
        //           Expanded(
        //             child: Text(
        //               'Pay with Google',
        //               style: TextStyle(
        //                 color: Colors.black87,
        //                 fontSize: 16.0,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 20),
        // Material(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(4.0),
        //   child: InkWell(
        //     onTap: () => {
        //                 onPay!.call(
        //                   3
        //                 )},
        //     child: Container(
        //       height: 48.0,
        //       padding: EdgeInsets.symmetric(horizontal: 16.0),
        //       child: Row(
        //         children: [
        //           Image.asset(
        //           'assets/apple-pay.png' ,
        //           width: 24.0,
        //           height: 24.0),
        //           SizedBox(width: 16.0),
        //           Expanded(
        //             child: Text(
        //               'Pay with Apple',
        //               style: TextStyle(
        //                 color: Colors.black87,
        //                 fontSize: 16.0,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 20),
        SizedBox(height: 20),
        GooglePayButton(
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultGooglePay),
            paymentItems: _paymentItems,
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onGooglePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
            width: double.infinity),

        SectionDivider(
            leadIcon: ProximityIcons.credit_card,
            title: 'Or Pay with Card.',
            color: blueSwatch.shade500),
        SizedBox(height: 16),
        EditText(
          hintText: "Card Number",
          keyboardType: TextInputType.number,
          onChanged: returnScreenValidation.changecardNumber,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: normal_100),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _controller, //<-- Add controller here
                          onChanged: (value) {
                            returnScreenValidation.changeexpdate(value);
                          },
                          keyboardType: TextInputType.number,
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).dividerColor),
                                borderRadius:
                                    const BorderRadius.all(smallRadius),
                              ),
                              focusedBorder:
                                  OutlineInputBorder(borderSide: BorderSide(
                                color: (() {
                                  return Theme.of(context).primaryColor;
                                })(),
                              )),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      const BorderRadius.all(normalRadius)),
                              label: Text(
                                "Expiry MM/YY",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: (() {
                                          return Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .color;
                                        })()),
                              ),
                              contentPadding: null),
                        ),
                      ]),
                  // EditText(
                  //   hintText : "Expiry MM/YY",
                  //   keyboardType: TextInputType.number,
                  //   onChanged:
                  //       returnScreenValidation.changeexpdate,
                  // ),
                )),
            Expanded(
              flex: 1,
              child: EditText(
                hintText: "CVC",
                keyboardType: TextInputType.number,
                onChanged: returnScreenValidation.changecvc,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        SectionDivider(
            leadIcon: ProximityIcons.address,
            title: 'Billing Address.',
            color: blueSwatch.shade500),

        EditText(
          hintText: "Name",
          onChanged: returnScreenValidation.changename,
        ),
        SizedBox(height: 16),

        EditText(
          hintText: "Phone",
          onChanged: returnScreenValidation.changephone,
        ),
        SizedBox(height: 16),

        EditText(
          hintText: "city",
          onChanged: returnScreenValidation.changecity,
        ),
        SizedBox(height: 16),

        EditText(
          hintText: "street",
          onChanged: returnScreenValidation.changestreet,
        ),
        SizedBox(height: 16),

        EditText(
          hintText: "street2",
          onChanged: returnScreenValidation.changestreet2,
        ),
        SizedBox(height: 16),

        EditText(
          hintText: "Postal code",
          onChanged: returnScreenValidation.changepostalCode,
        ),
        SizedBox(height: 16),

        ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://i.ibb.co/zmn2F5b/Vector-Visa-Credit-Card.png',
                  width: 24.0,
                  height: 24.0),
              SizedBox(width: 16.0),
              Text(
                'Pay with Card',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          style: raisedButtonStyle,
          onPressed: () async {
            if (returnScreenValidation.cardNumber!.isNotEmpty &&
                returnScreenValidation.expdate!.isNotEmpty &&
                returnScreenValidation.expdate!.length == 5 &&
                returnScreenValidation.cvc!.isNotEmpty &&
                returnScreenValidation.cvc!.length == 3 &&
                returnScreenValidation.name!.isNotEmpty &&
                returnScreenValidation.phone!.isNotEmpty &&
                returnScreenValidation.city!.isNotEmpty &&
                returnScreenValidation.street!.isNotEmpty &&
                returnScreenValidation.postalCode!.isNotEmpty) {
              //pay order
              // var payed = await orderService.payOrder(
              //     context, returnScreenValidation.toFormData());
              // if (payed == true) {
              //   onPay!.call(3);
              // }
            }
            ;
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
