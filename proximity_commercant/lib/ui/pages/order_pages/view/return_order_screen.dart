import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/ui/pages/pages.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';

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
    var _controller = TextEditingController();
    return ChangeNotifierProvider<ReturnScreenValidation>(
        create: (context) =>
            ReturnScreenValidation.initProducts(widget.order!.items ?? []),
        child: Scaffold(
            body: SafeArea(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
              const TopBar(title: 'Return Validation.'),
              Expanded(
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(15.0),
                    children: <Widget>[
                      Consumer2<ReturnScreenValidation, OrderService>(builder:
                          (context, returnScreenValidation, orderService,
                              child) {
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (var item
                                  in returnScreenValidation.returnedItems!)
                                ReturnItem(
                                  product: item,
                                  returnService: returnScreenValidation,
                                  reservation: null,
                                )
                            ]);
                      }),
                      Consumer2<ReturnScreenValidation, OrderService>(builder:
                          (context, returnValidation, orderService, child) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (returnValidation.getTotalToRefund() > 0.0)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "Refund Methode",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Consumer2<ReturnScreenValidation,
                                            OrderService>(
                                        builder: (context,
                                            returnScreenValidation,
                                            orderService,
                                            child) {
                                      return Container(
                                          padding:
                                              const EdgeInsets.all(tiny_50),
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.all(tinyRadius),
                                              color: Color.fromARGB(
                                                  255, 163, 8, 104)),
                                          child: Text(
                                            'Total to refund : ${returnScreenValidation.getTotalToRefund()} €',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    color: primaryTextDarkColor,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ));
                                    }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                  ],
                                )
                            ]);
                      }),
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
                                    if (returnScreenValidation.isFormValid()) {
                                      print("start action");
                                      print(returnScreenValidation
                                          .itemsToString());
                                      widget.actionReturn?.call(
                                          returnScreenValidation
                                              .itemsToString(),
                                          context);
                                    } else {
                                      ToastSnackbar().init(context).showToast(
                                          message: "The form is not valid ",
                                          type: ToastSnackbarType.error);
                                    }
                                  });
                            })))
                          ])),
                    ]),
              )
            ]))));
  }
}
