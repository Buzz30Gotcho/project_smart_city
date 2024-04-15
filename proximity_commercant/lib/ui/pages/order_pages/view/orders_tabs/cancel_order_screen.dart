import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';

import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';

import 'package:proximity_commercant/domain/order_repository/order_repository.dart';

class CancelOrderScreen extends StatefulWidget {
  const CancelOrderScreen({Key? key, this.orderId, this.actionCancel})
      : super(key: key);
  final String? orderId;
  final Function? actionCancel;
  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    var _controller = new TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 20, top: 20 + 20, right: 20, bottom: 20),
                    margin: EdgeInsets.only(top: 150),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Are you really want cancel the order ?",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        EditText(
                          controller: _controller,
                          hintText: 'Motif.',
                          borderType: BorderType.bottom,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(normal_100),
                            child:
                                Row(mainAxisSize: MainAxisSize.max, children: [
                              Expanded(
                                  child: SecondaryButton(
                                      title: 'Cancel.',
                                      onPressed: () async {
                                        Navigator.pop(context, false);
                                      })),
                              const SizedBox(width: normal_100),
                              Expanded(
                                  child: Expanded(
                                      child: PrimaryButton(
                                          title: 'Confirm.',
                                          onPressed: () {
                                            print("_controller.text");
                                            print(_controller.text);
                                            widget.actionCancel?.call(
                                                _controller.text, context);
                                          })))
                            ])),
                      ],
                    ),
                  ),
                ],
              )
            ])));
  }
}
