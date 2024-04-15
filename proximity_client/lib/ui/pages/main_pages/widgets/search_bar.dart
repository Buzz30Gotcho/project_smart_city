import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/product_repository/product_repository.dart';
import 'package:proximity_client/domain/store_repository/models/store_category.dart';
import 'package:proximity_client/domain/store_repository/store_repository.dart';
import 'package:proximity_client/ui/pages/main_pages/widgets/single_select.dart';
import 'package:proximity_client/ui/pages/pages.dart';
import 'package:proximity_client/ui/pages/product_pages/widgets/product_card.dart';
import 'package:proximity_client/ui/pages/store_pages/widgets/store_card.dart';
import 'package:proximity_client/ui/widgets/address_picker/address_picker.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Future<void> _showSearch() async {
    await previewSearch(
      context: context,
      delegate: Search(),
      query: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showSearch,
      child: Container(
        padding: const EdgeInsets.all(small_100).copyWith(left: normal_100),
        margin: const EdgeInsets.symmetric(
            horizontal: normal_100, vertical: small_100),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(smallRadius),
            gradient: LinearGradient(
              colors: (Theme.of(context).brightness == Brightness.light)
                  ? lightSearchBarGradient
                  : darkSearchBarGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
        child: Row(
          children: [
            Expanded(
                child: Text(AppLocalizations.of(context)!.search,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium!.color))),
            const SizedBox(width: normal_100),
            const Icon(ProximityIcons.search)
          ],
        ),
      ),
    );
  }
}

/// A custom search delegate for proper handling and custom UI
class Search extends CustomSearchDelegate<Product> {
  @override
  Widget buildResults(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final storeService = Provider.of<StoreService>(context);

    if (productService.query != query) {
      productService.getProximityProducts(name: query);
      productService.filterProductByCategorie();
    }
    if (storeService.query != query) {
      storeService.searchStores(name: query);
      storeService.filterStoresByCategorie();
    }

    List<Widget> productswidgetList = [];
    List<Widget> storeswidgetList = [];
    List<String> searchedProducts = [
      "Electronics",
      "Clothing",
      "Shoes",
      "Accessories",
      "Home Decor",
      "Beauty",
      "Toys",
      "Books",
      "Sports",
      "Health",
      "Fitness",
      "Jewelry",
      "Tech Gadgets",
      "Kitchen Appliances",
    ];
    if (query.isEmpty) {
      return Wrap(
        spacing: 8,
        children: searchedProducts
            .map((search) => ChoiceChip(
                  label: Text(search),
                  selected: false,
                  onSelected: (isSelected) {},
                ))
            .toList(),
      );
    }
    if (query.isNotEmpty) {
      if (productService.searchFilter == "") {
        for (int i = 0; i < productService.searchResults.length; i++) {
          productswidgetList
              .add(ProductCard(product: productService.searchResults[i]));
        }
      } else {
        for (int i = 0; i < productService.filterSearchResults.length; i++) {
          productswidgetList
              .add(ProductCard(product: productService.filterSearchResults[i]));
        }
      }
      print('storeService.searchFilter.toString()${storeService.searchFilter}');
      if (storeService.searchFilter == null &&
          storeService.searchAddress.city == null) {
        for (int i = 0; i < storeService.searchResults.length; i++) {
          storeswidgetList
              .add(StoreCard(store: storeService.searchResults[i]));
        }
      } else {
        for (int i = 0; i < storeService.filterSearchResults.length; i++) {
          storeswidgetList
              .add(StoreCard(store: storeService.filterSearchResults[i]));
        }
      }
    }
    /*  if (_productswidgetList.isEmpty && _storeswidgetList.isEmpty) {
      return const NoResults(
          icon: ProximityIcons.no_results_illustration,
          message: 'No results were found.');
      /*if (_storeswidgetList.isEmpty) {
        return const NoResults(
            icon: ProximityIcons.no_results_illustration,
            message: 'No stores were found.');
      } else {
        return const NoResults(
            icon: ProximityIcons.no_results_illustration,
            message: 'No products were found.');
      }*/
    } else {*/
    return SearchResults(
      productsWidgetList: productswidgetList,
      storesWidgetList: storeswidgetList,
      productService: productService,
      storeService: storeService,
    );
    // }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Widget> widgetList = [];
    int i = 0;
    if (query != '') {
      // final productService = Provider.of<ProductService>(context);
      // productService.searchProducts(query);
      // for (Product element in productService.searchResults) {
      //   if (element.name!.toLowerCase().contains(query.toLowerCase())) {
      //     _widgetList.add(GestureDetector(
      //         onTap: () {
      //           query = element.name!;
      //           showResults(context);
      //         },
      //         child: Container(
      //             padding: const EdgeInsets.all(normal_100),
      //             child: Text(element.name!,
      //                 style: Theme.of(context).textTheme.bodyText1))));
      //     _widgetList.add(Divider(
      //         height: tiny_50,
      //         thickness: tiny_50,
      //         color: Theme.of(context).dividerColor));
      //     i++;
      //     if (i >= 7) break;
      //   }
      // }
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetList);
  }
}

class SearchResults extends StatefulWidget {
  const SearchResults(
      {Key? key,
      required List<Widget> productsWidgetList,
      required List<Widget> storesWidgetList,
      required ProductService productService,
      required StoreService storeService})
      : _productsWidgetList = productsWidgetList,
        _storeswidgetList = storesWidgetList,
        _productService = productService,
        _storeService = storeService,
        super(key: key);

  final ProductService _productService;
  final StoreService _storeService;
  final List<Widget> _productsWidgetList;
  final List<Widget> _storeswidgetList;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  String filterOption = "";

  void showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('change the city '),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: widget._storeService.cityController,
                textAlignVertical: TextAlignVertical.center,
                onFieldSubmitted: (String value) {
                  widget._storeService.changeCity(value);
                  //widget._storeService.filterStoresByAdresse();
                  Navigator.of(context).pop();
                },
                //keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Customize the border radius
                    borderSide: const BorderSide(
                      color: Colors.blue, // Customize the border color
                      width: 2.0, // Customize the border width
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: dividerLightColor,
                      width: 1.0,
                    ),
                  ),
                  hintText: widget._storeService.getSearchAddresse()!,
                  hintStyle: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                height: tiny_50,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Theme.of(context)
                                          .dividerColor
                                          .withOpacity(0.0),
                                      Theme.of(context).dividerColor,
                                    ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)))),
                        const SizedBox(width: normal_100),
                        Text(
                          "Or",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headlineSmall!.copyWith(),
                        ),
                        const SizedBox(width: normal_100),
                        Expanded(
                            child: Container(
                                height: tiny_50,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Theme.of(context)
                                          .dividerColor
                                          .withOpacity(0.0),
                                      Theme.of(context).dividerColor,
                                    ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft))))
                      ])),
              Padding(
                padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
                child: TertiaryButton(
                    onPressed: () async {
                      final Address result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressSelectionScreen(
                                  currentAddress: Address())));
                      widget._storeService.changeSearchAddresse(result);
                      Navigator.pop(context);
                      //    policyCreationValidation
                      //           .changeDeliveryCenterdress(_result);

                      //  policyCreationValidation
                      //  .changeAddress(_result);
                    },
                    title: 'Choose city from map .'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  var _selected_item;
  final _items = storeCategories
      .map((categorie) =>
          SingleSelectItem<StoreCategory>(categorie, categorie.name))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildChoiceShip(context),
      widget._productService.searchProduct
          ? Padding(
              padding: const EdgeInsets.all(normal_100),
              child: buildSignleChoice(
                context,
              ))
          : Container(),
      (widget._productService.searchProduct ||
              widget._productService.searchBoth)
          ? widget._productsWidgetList.isNotEmpty
              ? Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Products",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall!),
                          const SizedBox(width: normal_100),
                          Expanded(
                              child: Container(
                                  height: tiny_50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Theme.of(context)
                                            .dividerColor
                                            .withOpacity(0.0),
                                        Theme.of(context).dividerColor,
                                      ],
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft))))
                        ]),
                    MasonryGrid(
                      column: 2,
                      padding: const EdgeInsets.symmetric(
                        horizontal: small_100,
                        vertical: normal_100,
                      ),
                      children: widget._productService.searchProduct
                          ? widget._productsWidgetList
                          : widget._productsWidgetList.take(4).toList(),
                    ),
                    !widget._productService.searchProduct
                        ? Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget._productService
                                          .setSearchProducts();
                                    });
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: small_100, right: normal_100),
                                      child: Text('See More',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color:
                                                      blueSwatch.shade500)))),
                            ],
                          )
                        : Container()
                  ],
                )
              : const NoResults(
                  icon: ProximityIcons.no_results_illustration,
                  message: 'No results were found.')
          : Container(),
      widget._productService.searchStores
          ? Padding(
              padding: const EdgeInsets.all(normal_100),
              child: buildSignleChoice(
                context,
              ))
          : Container(),
      (widget._productService.searchStores || widget._productService.searchBoth)
          ? widget._storeswidgetList.isNotEmpty
              ? Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Store",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall!),
                          const SizedBox(width: normal_100),
                          Expanded(
                              child: Container(
                                  height: tiny_50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Theme.of(context)
                                            .dividerColor
                                            .withOpacity(0.0),
                                        Theme.of(context).dividerColor,
                                      ],
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft))))
                        ]),
                    MasonryGrid(
                      column: 1,
                      padding: const EdgeInsets.symmetric(
                        horizontal: small_100,
                        vertical: normal_100,
                      ),
                      children: widget._productService.searchStores
                          ? widget._storeswidgetList
                          : widget._storeswidgetList.take(4).toList(),
                    ),
                    !widget._productService.searchStores
                        ? Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget._productService.setSearchStores();
                                    });
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: small_100, right: normal_100),
                                      child: Text('See More',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color:
                                                      blueSwatch.shade500)))),
                            ],
                          )
                        : Container()
                  ],
                )
              : const NoResults(
                  icon: ProximityIcons.no_results_illustration,
                  message: 'No results were found.')
          : Container()
    ]);
    /* MasonryGrid(
          column: 1,
          padding: const EdgeInsets.symmetric(
              horizontal: small_100, vertical: normal_100),
          children: widget._widgetList,
        ),*/
  }

  Row buildChoiceShip(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: normal_100),
          child: Wrap(
            spacing: normal_100,
            children: [
              ChoiceChip(
                label: Text(
                  'All',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                onSelected: (_) {
                  setState(() {
                    widget._productService.setSearchBoth();
                  });
                },
                selected: widget._productService.searchBoth,
                backgroundColor: dividerLightColor.withOpacity(0.5),
                selectedColor: Colors.blue.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: dividerLightColor.withOpacity(0.5),
                  ),
                ),
              ),
              ChoiceChip(
                label: Text(
                  'Stores',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                onSelected: (_) {
                  setState(() {
                    widget._productService.setSearchStores();
                  });
                },
                selected: widget._productService.searchStores,
                backgroundColor: dividerLightColor.withOpacity(0.5),
                selectedColor: Colors.blue.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: dividerLightColor.withOpacity(0.5),
                  ),
                ),
              ),
              ChoiceChip(
                label: Text(
                  'Products',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                onSelected: (_) {
                  setState(() {
                    widget._productService.setSearchProducts();
                  });
                },
                selected: widget._productService.searchProduct,
                backgroundColor: dividerLightColor.withOpacity(0.5),
                selectedColor: Colors.blue.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: dividerLightColor.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column buildSignleChoice(
    BuildContext context,
  ) {
    return Column(
      children: [
        (widget._productService.searchStores ||
                widget._productService.searchProduct)
            ? SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
                    child: SingleSelectDialogField(
                      searchable: true,
                      items: _items,
                      selectedColor: blueSwatch.shade500,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            width: 1,
                            color: _selected_item == null
                                ? Theme.of(context).dividerColor
                                : blueSwatch.shade500),
                      ),
                      buttonIcon: null,
                      buttonText: Text(
                        _selected_item == null
                            ? 'Select Category'
                            : _selected_item.name.toString(),
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: _selected_item == null
                                  ? Theme.of(context).dividerColor
                                  : blueSwatch.shade500,
                            ),
                      ),
                      onConfirm: (result) {
                        setState(() {
                          if (widget._productService.searchStores) {
                            _selected_item = result;
                            widget._storeService
                                .addSearchCategorie(_selected_item.id);
                          } else {
                            _selected_item = result;
                            widget._productService
                                .addSearchFilter(result.toString());
                          }
                        });
                      },
                    ),
                  ),

                  /*     _selectedAnimals2 == null || _selectedAnimals2.isEmpty
                                Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "None selected",
                                      style:
                                          TextStyle(color: Colors.black54),
                                    )):
                                Container(),*/
                ]),
              )
            : Container(),
        widget._productService.searchStores
            ? GestureDetector(
                onTap: () {
                  showPopUp(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 1,
                        color: widget._storeService.searchAddress == null
                            ? Theme.of(context).dividerColor
                            : blueSwatch.shade500,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(widget._storeService.getSearchAddresse()!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color:
                                      widget._storeService.searchAddress == null
                                          ? Theme.of(context).dividerColor
                                          : blueSwatch.shade500,
                                )),
                        const Spacer(),
                        Icon(
                          ProximityIcons.address,
                          color: widget._storeService.searchAddress == null
                              ? Theme.of(context).dividerColor
                              : blueSwatch.shade500,
                        )
                      ],
                    ),
                  ),
                ))
            : Container(),
      ],
    );
  }
}

enum _SearchBody {
  suggestions,
  results,
}

abstract class CustomSearchDelegate<T> {
  CustomSearchDelegate({
    this.searchFieldLabel,
    this.keyboardType,
    this.textInputAction = TextInputAction.search,
  });

  Widget buildSuggestions(BuildContext context);

  Widget buildResults(BuildContext context);

  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      //primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  String get query => _queryTextController.text;

  set query(String value) {
    _queryTextController.text = value;
  }

  void showResults(BuildContext context) {
    _focusNode!.unfocus();
    _currentBody = _SearchBody.results;
  }

  void showSuggestions(BuildContext context) {
    _focusNode!.requestFocus();
    _currentBody = _SearchBody.suggestions;
  }

  void close(BuildContext context, T result) {
    _currentBody = null;
    _focusNode!.unfocus();
    Navigator.of(context)
      ..popUntil((Route<dynamic> route) => route == _route)
      ..pop(result);
  }

  final String? searchFieldLabel;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;

  Animation<double> get transitionAnimation => _proxyAnimation;

  // The focus node to use for manipulating focus on the search page. This is
  // managed, owned, and set by the _SearchPageRoute using this delegate.
  FocusNode? _focusNode;

  final TextEditingController _queryTextController = TextEditingController();

  final ProxyAnimation _proxyAnimation =
      ProxyAnimation(kAlwaysDismissedAnimation);

  final ValueNotifier<_SearchBody?> _currentBodyNotifier =
      ValueNotifier<_SearchBody?>(null);

  _SearchBody? get _currentBody => _currentBodyNotifier.value;

  set _currentBody(_SearchBody? value) {
    _currentBodyNotifier.value = value;
  }

  _SearchPageRoute<T>? _route;
}

class _SearchPageRoute<T> extends PageRoute<T> {
  _SearchPageRoute({required this.delegate}) {
    assert(
      delegate._route == null,
    );
    delegate._route = this;
  }

  final CustomSearchDelegate<T> delegate;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => false;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Animation<double> createAnimation() {
    final Animation<double> animation = super.createAnimation();
    delegate._proxyAnimation.parent = animation;
    return animation;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _SearchPage<T>(
      delegate: delegate,
      animation: animation,
    );
  }

  @override
  void didComplete(T? result) {
    super.didComplete(result);
    assert(delegate._route == this);
    delegate._route = null;
    delegate._currentBody = null;
  }
}

class _SearchPage<T> extends StatefulWidget {
  const _SearchPage({
    this.delegate,
    this.animation,
  });

  final CustomSearchDelegate<T>? delegate;
  final Animation<double>? animation;

  @override
  State<StatefulWidget> createState() => _SearchPageState<T>();
}

class _SearchPageState<T> extends State<_SearchPage<T>> {
  // This node is owned, but not hosted by, the search page. Hosting is done by
  // the text field.
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.delegate!._queryTextController.addListener(_onQueryChanged);
    widget.animation!.addStatusListener(_onAnimationStatusChanged);
    widget.delegate!._currentBodyNotifier.addListener(_onSearchBodyChanged);
    focusNode.addListener(_onFocusChanged);
    widget.delegate!._focusNode = focusNode;
  }

  @override
  void dispose() {
    super.dispose();
    widget.delegate!._queryTextController.removeListener(_onQueryChanged);
    widget.animation!.removeStatusListener(_onAnimationStatusChanged);
    widget.delegate!._currentBodyNotifier.removeListener(_onSearchBodyChanged);
    widget.delegate!._focusNode = null;
    focusNode.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    widget.animation!.removeStatusListener(_onAnimationStatusChanged);
    if (widget.delegate!._currentBody == _SearchBody.suggestions) {
      focusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(_SearchPage<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.delegate != oldWidget.delegate) {
      oldWidget.delegate!._queryTextController.removeListener(_onQueryChanged);
      widget.delegate!._queryTextController.addListener(_onQueryChanged);
      oldWidget.delegate!._currentBodyNotifier
          .removeListener(_onSearchBodyChanged);
      widget.delegate!._currentBodyNotifier.addListener(_onSearchBodyChanged);
      oldWidget.delegate!._focusNode = null;
      widget.delegate!._focusNode = focusNode;
    }
  }

  void _onFocusChanged() {
    if (focusNode.hasFocus &&
        widget.delegate!._currentBody != _SearchBody.suggestions) {
      widget.delegate!.showSuggestions(context);
    }
  }

  bool _showChipsWrap = true;
  void _onQueryChanged() {
    setState(() {
      _showChipsWrap = widget.delegate!._queryTextController.text.isEmpty;
    });
  }

  Widget _buildChipsWrap() {
    List<String> searchedProducts = [
      "Electronics",
      "Clothing",
      "Shoes",
      "Accessories",
      "Home Decor",
      "Beauty",
      "Toys",
      "Books",
      "Sports",
    ];

    return Padding(
      padding: const EdgeInsets.all(normal_100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Most Searched",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: normal_150)),
          Wrap(
            spacing: 8,
            children: searchedProducts
                .map((search) => ChoiceChip(
                      label: Text(search),
                      selected: false,
                      onSelected: (selected) {
                        // Update query text and trigger search
                        _updateQueryAndSearch(search);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  void _updateQueryAndSearch(String choice) {
    setState(() {
      _showChipsWrap = false; // Hide chips wrap
    });

    // Update query text with the selected choice
    widget.delegate!._queryTextController.text = choice;

    // Perform the search based on the selected choice
    // Call your search function here or trigger search as you wish
    widget.delegate!.showResults(context);
  }

  void _onSearchBodyChanged() {
    setState(() {
      // rebuild ourselves because search body changed.
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = widget.delegate!.appBarTheme(context);
    final String searchFieldLabel = widget.delegate!.searchFieldLabel ??
        MaterialLocalizations.of(context).searchFieldLabel;
    Widget body;
    switch (widget.delegate!._currentBody!) {
      case _SearchBody.suggestions:
        body = KeyedSubtree(
          key: const ValueKey<_SearchBody>(_SearchBody.suggestions),
          child: widget.delegate!.buildSuggestions(context),
        );
        break;
      case _SearchBody.results:
        body = KeyedSubtree(
          key: const ValueKey<_SearchBody>(_SearchBody.results),
          child: widget.delegate!.buildResults(context),
        );
        break;
    }
    String routeName;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        routeName = '';
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        routeName = searchFieldLabel;
    }

    return Semantics(
        explicitChildNodes: true,
        scopesRoute: true,
        namesRoute: true,
        label: routeName,
        child: Scaffold(
          body: SafeArea(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Row(
                children: [
                  SmallIconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      icon: const Icon(ProximityIcons.chevron_left)),
                  Expanded(
                    child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: small_100)
                                .copyWith(left: normal_100),
                        margin: const EdgeInsets.all(normal_100),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(smallRadius),
                            gradient: LinearGradient(
                              colors: (Theme.of(context).brightness ==
                                      Brightness.light)
                                  ? lightSearchBarGradient
                                  : darkSearchBarGradient,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )),
                        child: Center(
                            child: TextFormField(
                                focusNode: focusNode,
                                controller:
                                    widget.delegate!._queryTextController,
                                textAlignVertical: TextAlignVertical.center,
                                onFieldSubmitted: (String _) {
                                  widget.delegate!.showResults(context);
                                },
                                keyboardType: TextInputType.name,
                                style: Theme.of(context).textTheme.headlineSmall,
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                    suffixIcon: IconButton(
                                        icon: (widget.delegate!.query == '')
                                            ? Icon(ProximityIcons.search,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color)
                                            : Icon(ProximityIcons.remove,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color),
                                        onPressed: () {
                                          widget.delegate!.query = '';
                                        }),
                                    border: InputBorder.none,
                                    hintText: 'Search .',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .color))))),
                  ),
                ],
              ),
              if (_showChipsWrap) _buildChipsWrap(),
              Expanded(
                  child: SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: AnimatedSwitcher(
                          duration: normalAnimationDuration, child: body))),
            ]),
          ),
        ));
  }
}

Future<T?> previewSearch<T>({
  required BuildContext context,
  required CustomSearchDelegate<T> delegate,
  String query = '',
}) {
  print(query);
  delegate.query = query;
  delegate._currentBody = _SearchBody.suggestions;
  return Navigator.of(context).push(_SearchPageRoute<T>(delegate: delegate));
}
