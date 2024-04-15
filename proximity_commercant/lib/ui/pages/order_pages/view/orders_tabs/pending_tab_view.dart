import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/order_repository/order_repository.dart';
import 'package:proximity_commercant/ui/pages/order_pages/order_pages.dart';

class PendingTabView extends StatelessWidget {
  const PendingTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersService = Provider.of<OrderService>(context);
    if (ordersService.loadingOrders) {
      ordersService.getOrders("all", "Pending");
    }

    return (ordersService.loadingOrders)
        ? const Center(child: CircularProgressIndicator())
        : (ordersService.orders!.isEmpty)
            ? NoResults(
                icon: ProximityIcons.product,
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
                  action: () {
                    ordersService.updateStatus(
                        ordersService.orders![i].id ?? "",
                        ordersService.orders![i].pickup == true
                            ? "InPreparation"
                            : ordersService.orders![i].delivery == true
                                ? "InPreparation"
                                : ordersService.orders![i].reservation == true
                                    ? "Reserved"
                                    : "",
                        "all",
                        "Pending",
                        true);
                  },
                  secondaryAction: () {},
                ),
              );
  }
}
