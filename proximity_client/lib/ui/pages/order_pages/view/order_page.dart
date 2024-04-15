import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/ui/pages/pages.dart';
import 'package:proximity_client/domain/order_repository/order_repository.dart';

class OrderPage extends StatefulWidget {
  OrderPage(
      {Key? key,
      this.order,
      this.action,
      this.secondaryAction,
      this.actionCancel,
      this.actionReturn,
      this.returnOrder = false,
      this.refundOrder = false})
      : super(key: key);
  Order? order;
  final VoidCallback? action;
  final VoidCallback? secondaryAction;
  final Function? actionCancel;
  final Function? actionReturn;
  final bool? returnOrder;
  final bool? refundOrder;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const TopBar(title: 'Order Page.'),
      Expanded(
          child: (widget.order == null)
              ? const NoResults(
                  icon: ProximityIcons.product, message: 'Order not found.')
              : OrderTilePage(
                  order: widget.order!,
                  returnOrder: widget.returnOrder,
                  refundOrder: widget.refundOrder,
                  action: widget.action,
                  secondaryAction: widget.secondaryAction,
                  actionCancel: widget.actionCancel,
                  actionReturn: widget.actionReturn,
                ))
    ])));
  }
}
