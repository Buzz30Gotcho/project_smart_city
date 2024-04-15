import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/product_repository/product_repository.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';
import 'package:proximity_commercant/ui/pages/store_pages/store_pages.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({Key? key, required this.store}) : super(key: key);

  final Store store;

  @override
  Widget build(BuildContext context) {
    /// A [productProxy] is declared to update its value [idShop] whenever
    /// a new shop is selected
    final productProxy = Provider.of<ProductProxy>(context);
    final storeService = Provider.of<StoreService>(context);

    /// get Card Image Width
    double _screenWidth = MediaQuery.of(context).size.width;
    double _cardImageWidth = _screenWidth - (large_150 + normal_100) * 2;

    return CardButton(
      onPressed: (store.isActive ?? true)
          ? () {
              productProxy.idStore = store.id!;
              storeService.getCategories(store.id!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoreScreen(id: store.id!)));
            }
          : null,
      margin: const EdgeInsets.symmetric(horizontal: normal_100),
      child: SizedBox(
          width: double.infinity,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(smallRadius),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        width: _cardImageWidth,
                        height: _cardImageWidth * 8 / 11,
                        child: Stack(
                          children: [
                            GoogleMapsAddress(
                                borderRadius: const BorderRadius.vertical(
                                    top: normalRadius),
                                latLng: LatLng(
                                    store.address!.lat!, store.address!.lng!)),
                            if (!(store.isActive ?? true)) ...[
                              Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .background
                                      .withOpacity(2 / 3)),
                              Center(
                                  child: Transform.rotate(
                                      angle: 0.3,
                                      child: Container(
                                          padding:
                                              const EdgeInsets.all(small_100),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      normalRadius),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  width: tiny_50)),
                                          child: Text('CLOSED',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .error)))))
                            ]
                          ],
                        )),
                    const Divider(height: tiny_50),
                    SizedBox(
                      height: normal_250,
                      child: Row(children: [
                        SizedBox(
                            width: normal_250,
                            height: normal_250,
                            child: (store.image == null)
                                ? Icon(ProximityIcons.store,
                                    color: Theme.of(context).primaryColor)
                                : AspectRatio(
                                    aspectRatio: 1.0,
                                    child: (store.image is File)
                                        ? Image.file(store.image)
                                        : Image.network(store.image,
                                            errorBuilder: (
                                            BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace,
                                          ) {
                                            return const AspectRatio(
                                                aspectRatio: 1.0,
                                                child: SizedBox(
                                                    width: large_100,
                                                    height: large_100));
                                          }),
                                  )),
                        const VerticalDivider(
                            width: tiny_50, thickness: tiny_50),
                        const SizedBox(width: small_50),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(store.name!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis),
                              StarRating(rating: store.rating!)
                            ])),
                      ]),
                    ),

                    // Expanded(
                    //     child: Padding(
                    //         padding: const EdgeInsets.all(small_100),
                    //         child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             crossAxisAlignment: CrossAxisAlignment.stretch,
                    //             children: [
                    //               Expanded(
                    //                   child: FittedBox(
                    //                       fit: BoxFit.fitHeight,
                    //                       alignment: Alignment.centerLeft,
                    //                       child: Text(store.name!,
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .subtitle1!
                    //                               .copyWith(height: 1.2),
                    //                           maxLines: 1,
                    //                           overflow: TextOverflow.ellipsis))),
                    //               Text('Store Category',
                    //                   style:
                    //                   Theme.of(context).textTheme.subtitle2,
                    //                   maxLines: 1,
                    //                   overflow: TextOverflow.ellipsis)
                    //             ])))
                  ]))),
    );
  }
}

class StoreInVerificationCard extends StatelessWidget {
  const StoreInVerificationCard({Key? key, required this.store})
      : super(key: key);

  final Store store;

  @override
  Widget build(BuildContext context) {
    /// A [productProxy] is declared to update its value [idShop] whenever
    /// a new shop is selected
    final productProxy = Provider.of<ProductProxy>(context);
    final storeService = Provider.of<StoreService>(context);

    /// get Card Image Width
    double _screenWidth = MediaQuery.of(context).size.width;
    double _cardImageWidth = _screenWidth - (large_150 + normal_100) * 2;

    return CardButton(
      onPressed: (store.isActive ?? true)
          ? () {
              productProxy.idStore = store.id!;
              storeService.getCategories(store.id!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoreScreen(id: store.id!)));
            }
          : null,
      margin: const EdgeInsets.symmetric(horizontal: normal_100),
      child: SizedBox(
          width: double.infinity,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(smallRadius),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                        width: _cardImageWidth,
                        height: _cardImageWidth * 8 / 11,
                        child: Stack(
                          children: [
                            GoogleMapsAddress(
                                borderRadius: const BorderRadius.vertical(
                                    top: normalRadius),
                                latLng: LatLng(
                                    store.address!.lat!, store.address!.lng!)),
                            if (!(store.isActive ?? true)) ...[
                              Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .background
                                      .withOpacity(2 / 3)),
                              Center(
                                  child: Transform.rotate(
                                      angle: 0.3,
                                      child: Container(
                                          padding:
                                              const EdgeInsets.all(small_100),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      normalRadius),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  width: tiny_50)),
                                          child: Text('Freezed',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .error)))))
                            ]
                          ],
                        )),
                    const Divider(height: tiny_50),
                    SizedBox(
                      height: normal_250,
                      child: Row(children: [
                        SizedBox(
                            width: normal_250,
                            height: normal_250,
                            child: (store.image == null)
                                ? Icon(ProximityIcons.store,
                                    color: Theme.of(context).primaryColor)
                                : AspectRatio(
                                    aspectRatio: 1.0,
                                    child: (store.image is File)
                                        ? Image.file(store.image)
                                        : Image.network(store.image,
                                            errorBuilder: (
                                            BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace,
                                          ) {
                                            return const AspectRatio(
                                                aspectRatio: 1.0,
                                                child: SizedBox(
                                                    width: large_100,
                                                    height: large_100));
                                          }),
                                  )),
                        const VerticalDivider(
                            width: tiny_50, thickness: tiny_50),
                        const SizedBox(width: small_50),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(store.name!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis),
                              StarRating(rating: store.rating!)
                            ])),
                      ]),
                    ),

                    // Expanded(
                    //     child: Padding(
                    //         padding: const EdgeInsets.all(small_100),
                    //         child: Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             crossAxisAlignment: CrossAxisAlignment.stretch,
                    //             children: [
                    //               Expanded(
                    //                   child: FittedBox(
                    //                       fit: BoxFit.fitHeight,
                    //                       alignment: Alignment.centerLeft,
                    //                       child: Text(store.name!,
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .subtitle1!
                    //                               .copyWith(height: 1.2),
                    //                           maxLines: 1,
                    //                           overflow: TextOverflow.ellipsis))),
                    //               Text('Store Category',
                    //                   style:
                    //                   Theme.of(context).textTheme.subtitle2,
                    //                   maxLines: 1,
                    //                   overflow: TextOverflow.ellipsis)
                    //             ])))
                  ]))),
    );
  }
}
