import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';

/// This class has a couple of DialogWidgets to avoid BoilerPlate between Widgets
///
/// The [id] indicates the index of the store
class ProductDialogs {
  /// A method to display the delete dialog
  static void deleteProduct(BuildContext context, String id) => showDialogPopup(
      context: context,
      pageBuilder: (ctx, anim1, anim2) => StatefulBuilder(
          builder: (context, setState) => DialogPopup(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width - normal_200 * 2,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(height: normal_100),
                    Stack(children: [
                      ImageFiltered(
                          imageFilter: blurFilter,
                          child: Icon(ProximityIcons.remove,
                              color: Theme.of(context).colorScheme.error,
                              size: normal_300)),
                      Icon(ProximityIcons.remove,
                          color: Theme.of(context).colorScheme.error,
                          size: normal_300)
                    ]),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: normal_100,
                            left: normal_100,
                            right: normal_100),
                        child: Text('Delete Product Message.',
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center)),
                    Padding(
                        padding: const EdgeInsets.all(normal_100),
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                              child: SecondaryButton(
                                  title: 'Cancel.',
                                  onPressed: () => Navigator.pop(context))),
                          const SizedBox(width: normal_100),
                          Expanded(
                              child: Consumer<ProductService>(
                                  builder: (context, productService, child) =>
                                      Expanded(
                                          child: PrimaryButton(
                                              title: 'Delete.',
                                              onPressed: () async {
                                                int count = 0;
                                                bool _bool =
                                                    await productService
                                                        .deleteProduct(id);
                                                if (_bool) {
                                                  Navigator.popUntil(context,
                                                      (route) {
                                                    return count++ == 2;
                                                  });
                                                }
                                              }))))
                        ]))
                  ])))));
}
