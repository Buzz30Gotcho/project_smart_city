import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';
import 'package:proximity_client/ui/pages/order_pages/order_pages.dart';

class PendingView extends StatefulWidget {
  const PendingView({Key? key, this.page}) : super(key: key);

  final int? page;

  @override
  State<PendingView> createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    if (ordersService.orders == null) {
      ordersService.getOrders("all", "Pending");
    }
    return Column(children: [
      Expanded(
          child: (ordersService.orders == null)
              ? const Center(child: CircularProgressIndicator())
              : (ordersService.orders!.isEmpty)
                  ? NoResults(
                      icon: ProximityIcons.self_pickup_duotone_1,
                      message: AppLocalizations.of(context)!.noPendingOrders)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: normal_100),
                      itemCount: ordersService.orders!.length,
                      itemBuilder: (_, i) => OrderTile(
                        order: ordersService.orders![i],
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
