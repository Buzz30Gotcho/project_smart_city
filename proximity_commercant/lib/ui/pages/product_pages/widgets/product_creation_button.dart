import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';
import 'package:proximity_commercant/ui/pages/product_pages/product_pages.dart';

class ProductCreationButton extends StatelessWidget {
  const ProductCreationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Selector<ProductProxy, String?>(
        selector: (_, productProxy) => productProxy.idStore,
        builder: (context, idStore, child) {
          return CardButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductCreationScreen(
                          product: Product(storeId: idStore))));
            },
            margin: const EdgeInsets.only(
                left: small_100, bottom: normal_100, right: small_100),
            child: AspectRatio(
                aspectRatio: 1,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(ProximityIcons.add),
                      const SizedBox(height: small_100),
                      Text(localizations!.createNewProduct,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center),
                      const SizedBox(height: small_100)
                    ])),
          );
        });
  }
}
