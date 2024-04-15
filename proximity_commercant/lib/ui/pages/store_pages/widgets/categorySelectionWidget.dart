import 'dart:io';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

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
    final storeCreationSliderValidation =
        Provider.of<StoreCreationSliderValidation>(context);
    print("storeCreationSliderValidation.productCategories!.isEmpty");
    print(storeCreationSliderValidation.productCategories!.isEmpty);
    if (storeCreationSliderValidation.productCategories!.isEmpty && !fetched) {
      print("feeeetch data");
      storeCreationSliderValidation.getProductCategories();
      fetched = true;
    }
    return Consumer<StoreCreationSliderValidation>(
        builder: (context, storeCreationSliderValidation, child) {
      if (storeCreationSliderValidation.loadingProductCategories) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          children: [
            ...List.generate(
                storeCreationSliderValidation.productCategories!.length,
                (index) {
              final categoryIndex = index;
              return ExpansionTile(
                title: Row(
                  children: [
                    Checkbox(
                        value: storeCreationSliderValidation
                            .productCategories![categoryIndex].selected,
                        onChanged: (value) {
                          storeCreationSliderValidation
                              .changeSelectProductCategorie(
                                  value!, categoryIndex,
                                  check_deselect: widget.check_deselect,
                                  context: context);
                          if (value!) {
                            storeCreationSliderValidation
                                .selectAllSubCategories(categoryIndex);
                          } else if (storeCreationSliderValidation
                                  .productCategories![categoryIndex]
                                  .product_count! <=
                              0) {
                            storeCreationSliderValidation
                                .deselectAllSubCategories(categoryIndex);
                          }
                        }),
                    Expanded(
                      child: Text(
                        storeCreationSliderValidation
                            .productCategories![categoryIndex].name,
                        style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                      ),
                    ),
                  ],
                ),
                children: [
                  ...storeCreationSliderValidation
                      .productCategories![categoryIndex].subCategories
                      .map((subProductCategory) {
                    return CheckboxListTile(
                      title: Text(subProductCategory.name,
                          style: TextStyle(
                              fontSize: 15.0, color: Color(0xFF000000))),
                      value: subProductCategory.selected,
                      onChanged: (value) {
                        storeCreationSliderValidation
                            .changeSelectProductSubCategorie(
                                value, subProductCategory.id, categoryIndex,
                                check_deselect: widget.check_deselect,
                                context: context);
                      },
                    );
                  }),
                  _buildNewProductSubCategoryField(
                      storeCreationSliderValidation, categoryIndex)
                ],
                maintainState: storeCreationSliderValidation
                    .productCategories![categoryIndex].selected,
                initiallyExpanded: false,
                onExpansionChanged: (expanded) {},
              );
            }),
            const SizedBox(height: 40),
            _buildNewProductCategoryField(
                storeCreationSliderValidation, context),
            const SizedBox(height: 40),
          ],
        );
      }
    });
    ;
  }

  Widget _buildNewProductCategoryField(
      StoreCreationSliderValidation storeCreationSliderValidation,
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
                        savedValue: storeCreationSliderValidation
                            .selectedStoreCategorie!,
                        onChanged: storeCreationSliderValidation
                            .changeSelectedStoreCategory,
                        items: storeCreationSliderValidation.storeCategories!
                            .where((element) => element.selected)
                            .toList()
                            .map((item) => DropdownItem<StoreCategory>(
                                value: item,
                                child: Text("${item.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontWeight: FontWeight.w600))))
                            .toList()))
              ]),
              SizedBox(
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
                          storeCreationSliderValidation.addProductCategorie(
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
      StoreCreationSliderValidation storeCreationSliderValidation,
      categoryIndex) {
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
                    storeCreationSliderValidation.addProductSubCategorie(
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
