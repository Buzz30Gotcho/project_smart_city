import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';
import 'package:proximity_commercant/ui/pages/store_pages/store_pages.dart';

class StoreCreationButton extends StatelessWidget {
  const StoreCreationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// A [productProxy] is declared to update its value [idShop] whenever
    /// a new shop is selected
    final productProxy = Provider.of<ProductProxy>(context);

    /// get Card Image Width
    double _screenWidth = MediaQuery.of(context).size.width;
    double _cardImageWidth = _screenWidth - (large_150 + normal_100) * 2;
    return CardButton(
      onPressed: () {
        productProxy.idStore = null;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    // StoreCreationScreen(store: Store())
                    StoreCreationSliderScreen(store: Store())));
      },
      margin: const EdgeInsets.symmetric(horizontal: normal_100),
      child: SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(ProximityIcons.add),
                const SizedBox(height: small_100),
                Text(AppLocalizations.of(context)!.createANewShop,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center)
              ])),
    );
  }
}
