import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/ui/pages/pages.dart';


import 'package:proximity_client/domain/order_repository/order_repository.dart';

class ReturnOrderScreen extends StatefulWidget {
  const ReturnOrderScreen({Key? key, this.order, this.actionReturn})
      : super(key: key);
  final Order? order;
  final Function? actionReturn;
  @override
  State<ReturnOrderScreen> createState() => _ReturnOrderScreenState();
}

class _ReturnOrderScreenState extends State<ReturnOrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.order != null);
    var controller = TextEditingController();
    return ChangeNotifierProvider<ReturnScreenValidation>(
        create: (context) =>
            ReturnScreenValidation.initProducts(widget.order!.items ?? []),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  const TopBar(title: 'Return Validation.'),
                  Consumer2<ReturnScreenValidation, OrderService>(builder:
                      (context, returnScreenValidation, orderService, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (var item in returnScreenValidation.returnedItems!)
                          ReturnItem(
                            product: item,
                            returnService: returnScreenValidation,
                            reservation: null,
                          ),
                      ],
                    );
                  }),
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Please add a reason for this return",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      EditText(
                        controller: controller,
                        hintText: 'Motif.',
                        borderType: BorderType.bottom,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(normal_100),
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Expanded(
                                child: SecondaryButton(
                                    title: 'Cancel.',
                                    onPressed: () async {
                                      Navigator.pop(context, false);
                                    })),
                            const SizedBox(width: normal_100),
                            Expanded(child: Expanded(child:
                                Consumer2<ReturnScreenValidation, OrderService>(
                                    builder: (context, returnScreenValidation,
                                        orderService, child) {
                              return PrimaryButton(
                                  title: 'Confirm.',
                                  onPressed: () {
                                    print("_controller.text");
                                    print(controller.text);
                                    widget.actionReturn?.call(
                                        controller.text,
                                        returnScreenValidation.itemsToString(),
                                        context);
                                  });
                            })))
                          ])),
                    ],
                  )
                ]))));
  }
}
