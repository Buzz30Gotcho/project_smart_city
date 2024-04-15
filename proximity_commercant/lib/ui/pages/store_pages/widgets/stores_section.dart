import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';
import 'package:proximity_commercant/ui/pages/store_pages/store_pages.dart';
import 'package:proximity_commercant/ui/pages/store_pages/widgets/loading_skeletons/stores_skeleton.dart';
import 'package:showcaseview/showcaseview.dart';

/// A widget to display the Shops part of the [HomeScreen]
///
class StoresSection extends StatefulWidget {
  final GlobalKey globalKey;
  const StoresSection({Key? key, required this.globalKey}) : super(key: key);

  @override
  _StoresSectionState createState() => _StoresSectionState();
}

class _StoresSectionState extends State<StoresSection> {
  late int _selectedShop;

  @override
  void initState() {
    super.initState();

    _selectedShop = 0;
  }

  @override
  Widget build(BuildContext context) {
    /// calculate card height to avoid PageView overflow
    double _screenWidth = MediaQuery.of(context).size.width;
    double _viewPortFraction = (_screenWidth - large_150 * 2) / _screenWidth;
    double _pageWidth = _screenWidth - large_200 * 2;
    double _cardImageWidth = _pageWidth - (normal_100) * 2;
    double _cardImageHeight = _pageWidth * 8 / 11;
    double _cardHeight = _cardImageHeight + tiny_50 * 2 + normal_250;
    return Builder(builder: (context) {
      final storeService = Provider.of<StoreService>(context);
      final localizations = AppLocalizations.of(context);

      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Shops Section title
            SectionDivider(
                leadIcon: ProximityIcons.store,
                title: localizations!.yourShops,
                color: blueSwatch.shade400),

            /// shops carousel
            if (storeService.stores == null)
              SizedBox(height: _cardHeight, child: const StoresCardSkeleton())
            else ...[
              SizedBox(
                  height: _cardHeight,
                  child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: storeService.stores!.length + 1,
                      controller: PageController(
                          initialPage: 0, viewportFraction: _viewPortFraction),
                      onPageChanged: (index) =>
                          setState(() => _selectedShop = index),
                      itemBuilder: (context, i) => Opacity(
                          opacity: _selectedShop == i ? 1.0 : 0.6,
                          child: i == storeService.stores!.length
                              ? Showcase(
                                  key: widget.globalKey,
                                  title: localizations!.createANewShop,
                                  //  todo: a modifier
                                  description: localizations!.newShopMessage,
                                  child: StoreCreationButton(),
                                )
                              : storeService.stores![i].isActive!
                                  ? StoreCard(store: storeService.stores![i])
                                  : StoreInVerificationCard(
                                      store: storeService.stores![i])))),
              const SizedBox(height: normal_100),
              if (storeService.stores != null)
                updateIndicators(storeService.stores!.length),
              if (_selectedShop == storeService.stores!.length)
                InfoMessage(
                  message: localizations.newShopMessage,
                )
              else
                Column(children: [
                  ListButton(
                      title: localizations!.editShop,
                      leadIcon: ProximityIcons.edit,
                      enabled: storeService.stores![_selectedShop].isActive!,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoreEditScreen(
                                    index: _selectedShop,
                                    store:
                                        storeService.stores![_selectedShop])));
                      }),
                  ListButton(
                      title: 'Start a Promotion.',
                      leadIcon: ProximityIcons.promotion,
                      enabled:
                          false, // storeService.stores![_selectedShop].isActive,
                      onPressed: () {}),
                  if (storeService.stores![_selectedShop].isActive! == true)
                    ListButton(
                        title: localizations!.freezeShop,
                        leadIcon: ProximityIcons.freeze,
                        onPressed: () {
                          StoreDialogs.freezeStore(context, _selectedShop,
                              activated: storeService
                                  .stores![_selectedShop].isActive!);
                        }),
                  if (storeService.stores![_selectedShop].isActive! == false)
                    ListButton(
                        title: 'Unfreeze Store.',
                        leadIcon: ProximityIcons.freeze,
                        onPressed: () {
                          StoreDialogs.freezeStore(context, _selectedShop,
                              activated: storeService
                                  .stores![_selectedShop].isActive!);
                        }),
                  ListButton(
                      title: localizations!.deleteShop,
                      leadIcon: ProximityIcons.remove,
                      onPressed: () {
                        StoreDialogs.deleteStore(context, _selectedShop);
                      }),
                  // if (!storeService.stores![_selectedShop].frozen ?? false) ...[
                  //   const SizedBox(height: normal_100),
                  //   FormTile(
                  //       leadingText: AppLocalizations.of(context).editShop,
                  //       icon: Iconly.iconly_light_edit,
                  //       onPressed: () => Navigate().toShopEditScreen(
                  //           context, shopService.shops[_selectedShop].id)),
                  //   FormTile(
                  //       leadingText:
                  //       AppLocalizations.of(context).createSalesPromotion,
                  //       icon: Iconly.iconly_light_discount,
                  //       onPressed: () => Navigate().toSalesPromotionAdderScreen(
                  //           context, shopService.shops[_selectedShop].id, []))
                  // ],
                  // FormTile(
                  //     leadingText: (shopService.shops[_selectedShop].frozen)
                  //         ? AppLocalizations.of(context).unfreezeShop
                  //         : AppLocalizations.of(context).freezeShop,
                  //     icon: Iconly.iconly_light_lock,
                  //     onPressed: () => ShopDialogs.freezeShop(
                  //         context, shopService.shops[_selectedShop].id,
                  //         frozen: shopService.shops[_selectedShop].frozen)),
                  // FormTile(
                  //     leadingText: AppLocalizations.of(context).deleteShop,
                  //     icon: Iconly.iconly_light_delete,
                  //     onPressed: () => ShopDialogs.deleteShop(
                  //         context, shopService.shops[_selectedShop].id)),
                  const SizedBox(height: normal_100)
                ])
            ]
          ]);
    });
  }

  Widget updateIndicators(int length) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: (() {
          List<Widget> _list = [];
          for (int i = 0; i < length + 1; i++) {
            _list.add(Container(
                width: small_75,
                height: small_75,
                margin: const EdgeInsets.symmetric(horizontal: small_50),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedShop == i
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).dividerColor)));
          }
          return _list;
        }()));
  }
}
