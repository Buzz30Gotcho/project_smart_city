import 'dart:io';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

class StoreCategorySelectionWidget extends StatefulWidget {
  StoreCategorySelectionWidget({Key? key, this.store, this.check_deselect})
      : super(key: key);

  Store? store;
  bool? check_deselect;
  @override
  _StoreCategorySelectionWidgetState createState() =>
      _StoreCategorySelectionWidgetState();
}

class _StoreCategorySelectionWidgetState
    extends State<StoreCategorySelectionWidget> {
  List<StoreCategory> categories = [];
  bool fetched = false;

  TextEditingController categoryController = TextEditingController();
  TextEditingController subStoreCategoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    subStoreCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeCreationSliderValidation =
        Provider.of<StoreCreationSliderValidation>(context);
    print("storeCreationSliderValidation.storeCategories!.isEmpty");
    print(storeCreationSliderValidation.storeCategories!.isEmpty);
    if (storeCreationSliderValidation.storeCategories!.isEmpty && !fetched) {
      print("feeeetch data");
      // storeCreationSliderValidation.getInitStoreCategories();
      if (widget.store == null) {
        storeCreationSliderValidation.getStoreCategories();
      } else {
        print("im here");
        storeCreationSliderValidation.getInitStoreCategories();
      }
      fetched = true;
    }

    return Consumer<StoreCreationSliderValidation>(
        builder: (context, storeCreationSliderValidation, child) {
      if (storeCreationSliderValidation.loadingStoreCategories) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          children: [
            ...storeCreationSliderValidation.storeCategories!
                .map((storeCategory) {
              return CheckboxListTile(
                  title: Text(storeCategory.name,
                      style:
                          TextStyle(fontSize: 15.0, color: Color(0xFF000000))),
                  value: storeCategory.selected,
                  onChanged: (value) {
                    storeCreationSliderValidation.changeSelectStoreCategorie(
                        value, storeCategory.id,
                        check_deselect: widget.check_deselect,
                        context: context);
                  });
            }),
            _buildNewStoreCategoryField(storeCreationSliderValidation),
          ],
        );
      }
    });
  }

  Widget _buildNewStoreCategoryField(
      StoreCreationSliderValidation storeCreationSliderValidation) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: EditText(
              controller: categoryController,
              hintText: 'New Store Category.',
              suffixIcon: ProximityIcons.add,
              suffixOnPressed: () {
                final categoryName = categoryController.text.trim();
                if (categoryName.isNotEmpty) {
                  storeCreationSliderValidation.addStoreCategorie(categoryName);
                  setState(() {
                    categoryController.clear();
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
