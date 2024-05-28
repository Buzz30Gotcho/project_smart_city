import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';

import 'package:flutter/material.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';

class StoreCategorySelectionWidget extends StatefulWidget {
  StoreCategorySelectionWidget({Key? key, this.check_deselect})
      : super(key: key);

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
    final preferencesSliderValidation =
        Provider.of<PreferencesSliderValidation>(context);
    print("preferencesSliderValidation.storeCategories!.isEmpty");
    print(preferencesSliderValidation.storeCategories!.isEmpty);
    if (preferencesSliderValidation.storeCategories!.isEmpty && !fetched) {
      print("feeeetch data");
      preferencesSliderValidation.getInitStoreCategories();
      fetched = true;
    }

    return Consumer<PreferencesSliderValidation>(
        builder: (context, preferencesSliderValidation, child) {
      if (preferencesSliderValidation.loadingStoreCategories) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          children: [
            ...preferencesSliderValidation.storeCategories!
                .map((storeCategory) {
              return CheckboxListTile(
                  title: Text(storeCategory.name,
                      style:
                          const TextStyle(fontSize: 15.0, color: Color(0xFF000000))),
                  value: storeCategory.selected,
                  onChanged: (value) {
                    preferencesSliderValidation.changeSelectStoreCategorie(
                        value, storeCategory.id,
                        check_deselect: widget.check_deselect,
                        context: context);
                  });
            }),
            // _buildNewStoreCategoryField(preferencesSliderValidation),
          ],
        );
      }
    });
  }

  Widget _buildNewStoreCategoryField(
      PreferencesSliderValidation preferencesSliderValidation) {
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
                  preferencesSliderValidation.addStoreCategorie(categoryName);
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
