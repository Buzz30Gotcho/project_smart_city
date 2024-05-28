import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/ui/pages/product_pages/product_pages.dart';

Future showProductModal(BuildContext context, String id, {String? variantId}) {
  // SizeConfig.getDeviceHeight();
  return showModalBottomSheet(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - large_200,
          minWidth: double.infinity),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => ChangeNotifierProvider(
            create: (_) => ProductModalController(variantId),
            child: AnimatedPadding(
                padding: MediaQuery.of(context).viewInsets,
                duration: smallAnimationDuration,
                curve: Curves.decelerate,
                child: ProductModal(id: id)),
          ));
}
