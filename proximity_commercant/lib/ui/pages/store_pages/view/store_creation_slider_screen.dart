import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';
import 'package:proximity_commercant/domain/product_repository/models/models.dart';
import 'package:proximity_commercant/ui/pages/store_pages/widgets/widgets.dart';
import 'package:proximity_commercant/ui/pages/store_pages/store_pages.dart';
import 'package:proximity_commercant/ui/widgets/address_picker/area_selection_screen.dart';
import 'package:proximity_commercant/domain/store_repository/src/store_creation_slider_validation.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';

class StoreCreationSliderScreen extends StatefulWidget {
  StoreCreationSliderScreen({
    Key? key,
    this.index,
    required this.store,
    this.editScreen = false,
  }) : super(key: key);

  final int? index;
  final Store store;
  final bool editScreen;
  @override
  State<StoreCreationSliderScreen> createState() =>
      _StoreCreationSliderScreenState();
}

class _StoreCreationSliderScreenState extends State<StoreCreationSliderScreen> {
  @override
  int _currentStep = 0;
  bool isLastStep = false;

  void onPay(int value) {
    setState(() {
      _currentStep = value;
    });
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreCreationSliderValidation>(
        // create: (context) => storeCreationSliderValidation.setStore(store),
        create: (context) => StoreCreationSliderValidation(),
        child: Consumer2<StoreCreationSliderValidation, StoreService>(builder:
            (context, storeCreationSliderValidation, storeService, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Align(
                  alignment: Alignment.center,
                  child: TopBar(title: "New Store"),
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              body: SafeArea(
                child: Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Stepper(
                        physics: const ClampingScrollPhysics(),
                        elevation: 0.0,
                        currentStep: _currentStep,
                        type: StepperType.horizontal,
                        onStepContinue: () {
                          if (_currentStep == 1) {
                            storeCreationSliderValidation
                                .getProductCategories();
                          } else if (_currentStep == 3 &&
                              (!(storeCreationSliderValidation
                                      .storeRayons!.isNotEmpty) ||
                                  storeCreationSliderValidation.storeRayons!
                                      .where(
                                          (element) => element.selected == true)
                                      .isEmpty)) {
                            ToastSnackbar().init(context).showToast(
                                message: "You must define at least one rayon",
                                type: ToastSnackbarType.error);
                            return;
                          } else if (_currentStep == 4) {
                            try {
                              FormData _formData =
                                  storeCreationSliderValidation.toFormData(
                                      storeCreationSliderValidation.policy!);
                              // print(_formData.fields);
                              storeService.addStore(context, _formData);
                              StoreDialogs.confirmStore(context, 1);

                              // Code that might throw the exception
                            } catch (e, stackTrace) {
                              print('Exception: $e');
                              print('Stack Trace: $stackTrace');
                            }
                          }
                          setState(() {
                            if (_currentStep != 4) {
                              _currentStep = _currentStep + 1;
                            }
                          });
                        },
                        onStepCancel: () {
                          if (_currentStep != 0) {
                            if (_currentStep == 2) {
                              print("i'm here");
                              storeCreationSliderValidation
                                  .changeSelectedStoreCategory(
                                      StoreCategory(name: "", selected: true),
                                      0);
                            }
                            setState(() {
                              _currentStep -= 1;
                              print(_currentStep);
                            });
                          }
                        },
                        controlsBuilder: (context, details) {
                          return Padding(
                            padding: const EdgeInsets.all(small_100),
                            child: Row(
                              mainAxisAlignment:
                                  _currentStep != 0 && _currentStep != 5
                                      ? MainAxisAlignment.spaceBetween
                                      : _currentStep == 5
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (_currentStep != 0 && _currentStep < 5)
                                  SecondaryButton(
                                      onPressed: details.onStepCancel,
                                      title: "Back"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PrimaryButton(
                                      buttonState: ButtonState.enabled,
                                      onPressed: details.onStepContinue,
                                      title:
                                          _currentStep == 4 ? "Done" : "Next.",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        steps: [
                          getGlobalInfoStep(
                              storeCreationSliderValidation, context),
                          getStoreCategoriesStep(
                              storeCreationSliderValidation, context),
                          getStoreProductsCategoriesStep(
                              storeCreationSliderValidation, context),
                          getStoreRayonsStep(
                              storeCreationSliderValidation, context),
                          getStoreTemplatesStep(
                              storeCreationSliderValidation, context),
                        ],
                      )),
                ),
              ));
        }));
  }

  Step getGlobalInfoStep(
      StoreCreationSliderValidation storeCreationSliderValidation,
      BuildContext context) {
    return Step(
        isActive: _currentStep >= 0,
        title: const Text(""),
        content: Column(
          children: [
            const Text("Global Informations",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            const SizedBox(height: 20),
            StoreCreationScreen(store: Store())
          ],
        ));
  }

  Step getStoreCategoriesStep(
      StoreCreationSliderValidation storeCreationSliderValidation,
      BuildContext context) {
    return Step(
        isActive: _currentStep >= 1,
        title: const Text(""),
        content: Column(
          children: [
            const Text("Categories of the Store",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            const SizedBox(height: 20),
            StoreCategorySelectionWidget()
          ],
        ));
  }

  Step getStoreProductsCategoriesStep(
      StoreCreationSliderValidation storeCreationSliderValidation,
      BuildContext context) {
    return Step(
        isActive: _currentStep >= 2,
        title: const Text(""),
        content: Column(
          children: [
            const Text("Product categories of the Store",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            const SizedBox(height: 20),
            ProductCategorySelectionWidget()
          ],
        ));
  }

  Step getStoreRayonsStep(
      StoreCreationSliderValidation storeCreationSliderValidation,
      BuildContext context) {
    return Step(
        isActive: _currentStep >= 3,
        title: const Text(""),
        content: Column(
          children: [
            const Text("Rayons of the store",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            const SizedBox(height: 20),
            StoreRayonSelectionWidget()
          ],
        ));
  }

  Step getStoreTemplatesStep(
      StoreCreationSliderValidation storeCreationSliderValidation,
      BuildContext context) {
    return Step(
        isActive: _currentStep >= 4,
        title: const Text(""),
        content: Column(
          children: const [
            Text("Templates of the Store",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            SizedBox(height: 20),
            Text("Content"),
            StoreTemplateSelectionWidget()
          ],
        ));
  }
}
