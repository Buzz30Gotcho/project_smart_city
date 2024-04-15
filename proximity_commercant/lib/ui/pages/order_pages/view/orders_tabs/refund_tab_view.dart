import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/order_pages/order_pages.dart';

class RefundTabView extends StatefulWidget {
  const RefundTabView({Key? key, this.page}) : super(key: key);

  final int? page;

  @override
  State<RefundTabView> createState() => _RefundTabViewState();
}

class _RefundTabViewState extends State<RefundTabView> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);

    if (ordersService.loadingOrders) {
      ordersService.getOrders("refund", "all");
    }
    return Column(children: [
      Expanded(
          child: (ordersService.loadingOrders)
              ? const Center(child: CircularProgressIndicator())
              : (ordersService.orders!.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: large_200, horizontal: large_100),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: huge_100,
                              width: huge_100,
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
                                                  "assets/img/refund_icon2.png",
                                                  color: Theme.of(context)
                                                      .dividerColor,
                                                )))),
                                  ])),
                          const SizedBox(height: normal_100),
                          Text("There are no Refund Orders.",
                              style: Theme.of(context).textTheme.subtitle2,
                              textAlign: TextAlign.center),
                          const SizedBox(height: huge_100),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: normal_100),
                      itemCount: ordersService.orders!.length,
                      itemBuilder: (_, i) => OrderTile(
                        order: ordersService.orders![i],
                        refundOrder: true,
                        actionCancel:
                            (String motif, BuildContext contextCancel) async {
                          // final bool _result = await PaymentDialogs.cancelOrder(
                          //     context,
                          //     ordersService.orders![i].id,
                          //     ordersService);
                          // if (_result == true) {
                          ordersService.cancelOrder(
                              contextCancel,
                              ordersService.orders![i].id ?? "",
                              motif,
                              null,
                              null,
                              false);
                          // }
                        },
                      ),
                    ))
    ]);
  }
}
