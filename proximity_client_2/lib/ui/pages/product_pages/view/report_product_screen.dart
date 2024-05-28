import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';

class ReportProductScreen extends StatefulWidget {
  const ReportProductScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ReportProductScreen> createState() => _ReportProductScreenState();
}

class _ReportProductScreenState extends State<ReportProductScreen> {
  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(alignment: Alignment.bottomCenter, children: [
      ListView(children: [
        const TopBar(title: 'Report Product.'),
        EditText(
            hintText: "Write your report message here.",
            maxLines: 6,
            onChanged: (value) {
              setState(() {
                _message = value;
              });
            }),
        const InfoMessage(message: "When reporting a Product, make sure the Product is truly against our community guidelines."),
        const SizedBox(height: huge_100)
      ]),
      Consumer<ProductService>(builder: (_, productService, __) {
        return BottomActionsBar(buttons: [
          PrimaryButton(
              onPressed: () {
                productService.reportProduct(context, widget.id, _message);
              },
              buttonState: _message.isNotEmpty
                  ? ButtonState.enabled
                  : ButtonState.disabled,
              title: 'Report.')
        ]);
      })
    ])));
  }
}
