import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key, required this.details}) : super(key: key);

  final Map<String, String> details;

  List<Widget> _detailsBuilder(BuildContext context, Map<String, String> _map) {
    List<Widget> _list = [];
    _map.forEach((key, value) {
      _list.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(key, style: Theme.of(context).textTheme.bodyText2),
        const SizedBox(width: small_100),
        Expanded(
            child: Text(
          value,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.end,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
      ]));
    });
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(small_100),
      child: Column(
        children: _detailsBuilder(context, details),
      ),
    );
  }
}
