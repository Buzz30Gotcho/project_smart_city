import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';

import 'package:flutter/material.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';

class ProductCategorySelectionWidget extends StatefulWidget {
  ProductCategorySelectionWidget({Key? key, this.check_deselect})
      : super(key: key);

  bool? check_deselect;
  @override
  _ProductCategorySelectionWidgetState createState() =>
      _ProductCategorySelectionWidgetState();
}

class _ProductCategorySelectionWidgetState
    extends State<ProductCategorySelectionWidget> {
  List<ProductCategory> categories = [
    ProductCategory(
      id: 1,
      name: 'ProductCategory 1',
      selected: false,
      subCategories: [
        ProductSubCategory(id: 1, name: 'Subcategory 1-1', selected: false),
        ProductSubCategory(id: 2, name: 'Subcategory 1-2', selected: false),
        ProductSubCategory(id: 3, name: 'Subcategory 1-3', selected: false),
      ],
    ),
    ProductCategory(
      id: 2,
      name: 'ProductCategory 2',
      selected: false,
      subCategories: [
        ProductSubCategory(id: 4, name: 'Subcategory 2-1', selected: false),
        ProductSubCategory(id: 5, name: 'Subcategory 2-2', selected: false),
        ProductSubCategory(id: 6, name: 'Subcategory 2-3', selected: false),
      ],
    ),
    // Add more categories and subcategories as needed
  ];
  bool fetched = false;

  TextEditingController categoryController = TextEditingController();
  TextEditingController subProductCategoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    subProductCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesSliderValidation =
        Provider.of<PreferencesSliderValidation>(context);
    print("preferencesSliderValidation.productCategories!.isEmpty");
    print(preferencesSliderValidation.productCategories!.isEmpty);
    if (preferencesSliderValidation.productCategories!.isEmpty && !fetched) {
      print("feeeetch data");
      preferencesSliderValidation.getProductCategories();
      fetched = true;
    }
    return Consumer<PreferencesSliderValidation>(
        builder: (context, preferencesSliderValidation, child) {
      if (preferencesSliderValidation.loadingProductCategories) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          children: [
            ...List.generate(
                preferencesSliderValidation.productCategories!.length, (index) {
              final categoryIndex = index;
              return ExpansionTile(
                title: Row(
                  children: [
                    Checkbox(
                        value: preferencesSliderValidation
                            .productCategories![categoryIndex].selected,
                        onChanged: (value) {
                          preferencesSliderValidation
                              .changeSelectProductCategorie(
                                  value!, categoryIndex,
                                  check_deselect: widget.check_deselect,
                                  context: context);
                          if (value) {
                            preferencesSliderValidation
                                .selectAllSubCategories(categoryIndex);
                          } else if (preferencesSliderValidation
                                  .productCategories![categoryIndex]
                                  .product_count! <=
                              0) {
                            preferencesSliderValidation
                                .deselectAllSubCategories(categoryIndex);
                          }
                        }),
                    Expanded(
                      child: Text(
                        preferencesSliderValidation
                            .productCategories![categoryIndex].name,
                        style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                      ),
                    ),
                  ],
                ),
                maintainState: preferencesSliderValidation
                    .productCategories![categoryIndex].selected,
                initiallyExpanded: false,
                onExpansionChanged: (expanded) {},
                children: [
                  ...preferencesSliderValidation
                      .productCategories![categoryIndex].subCategories
                      .map((subProductCategory) {
                    return CheckboxListTile(
                      title: Text(subProductCategory.name,
                          style: const TextStyle(
                              fontSize: 15.0, color: Color(0xFF000000))),
                      value: subProductCategory.selected,
                      onChanged: (value) {
                        preferencesSliderValidation
                            .changeSelectProductSubCategorie(
                                value, subProductCategory.id, categoryIndex,
                                check_deselect: widget.check_deselect,
                                context: context);
                      },
                    );
                  }),
                  // _buildNewProductSubCategoryField(
                  //     preferencesSliderValidation, categoryIndex)
                ],
              );
            }),
            const SizedBox(height: 40),
            // _buildNewProductCategoryField(preferencesSliderValidation, context),
            // const SizedBox(height: 40),
          ],
        );
      }
    });
  }

  Widget _buildNewProductCategoryField(
      PreferencesSliderValidation preferencesSliderValidation,
      BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(normalRadius),
          color: Theme.of(context).dividerColor.withOpacity(0.4),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 20, top: 20),
            child: Column(children: [
              Row(children: [
                Expanded(
                    child: DropDownSelector<StoreCategory>(
                        hintText: 'Select a Category.',
                        savedValue:
                            preferencesSliderValidation.selectedStoreCategorie!,
                        onChanged: preferencesSliderValidation
                            .changeSelectedStoreCategory,
                        items: preferencesSliderValidation.storeCategories!
                            .where((element) => element.selected)
                            .toList()
                            .map((item) => DropdownItem<StoreCategory>(
                                value: item,
                                child: Text(item.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.w600))))
                            .toList()))
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: EditText(
                      controller: categoryController,
                      hintText: 'New Product Category.',
                      suffixIcon: ProximityIcons.add,
                      suffixOnPressed: () {
                        final categoryName = categoryController.text.trim();
                        if (categoryName.isNotEmpty) {
                          preferencesSliderValidation.addProductCategorie(
                              categoryName, context);
                          setState(() {
                            categoryController.clear();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ])));
  }

  Widget _buildNewProductSubCategoryField(
      PreferencesSliderValidation preferencesSliderValidation, categoryIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: EditText(
              controller: subProductCategoryController,
              hintText: 'New Product SubCategory.',
              suffixIcon: ProximityIcons.add,
              suffixOnPressed: () {
                final subProductCategoryName =
                    subProductCategoryController.text.trim();
                if (subProductCategoryName.isNotEmpty) {
                  final selectedProductCategoryIndex = categoryIndex;
                  if (selectedProductCategoryIndex >= 0) {
                    preferencesSliderValidation.addProductSubCategorie(
                        subProductCategoryName, categoryIndex);
                    setState(() {
                      subProductCategoryController.clear();
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
