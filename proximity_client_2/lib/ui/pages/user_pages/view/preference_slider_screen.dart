import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';


import 'package:proximity_client/ui/pages/user_pages/widgets/widgets.dart';

import 'package:proximity_client/domain/user_repository/user_repository.dart';

class PreferencesSliderScreen extends StatefulWidget {
  const PreferencesSliderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PreferencesSliderScreen> createState() =>
      _PreferencesSliderScreenState();
}

class _PreferencesSliderScreenState extends State<PreferencesSliderScreen> {
  @override
  int _currentStep = 0;
  bool isLastStep = false;

  void onPay(int value) {
    setState(() {
      _currentStep = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PreferencesSliderValidation>(
        // create: (context) => preferencesSliderValidation.setStore(store),
        create: (context) => PreferencesSliderValidation(),
        child: Consumer2<PreferencesSliderValidation, UserService>(builder:
            (context, preferencesSliderValidation, userService, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Align(
                  alignment: Alignment.center,
                  child: TopBar(title: "Preferences"),
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
                          if (_currentStep == 0 &&
                              (!(preferencesSliderValidation
                                      .storeCategories!.isNotEmpty) ||
                                  preferencesSliderValidation.storeCategories!
                                      .where(
                                          (element) => element.selected == true)
                                      .isEmpty)) {
                            ToastSnackbar().init(context).showToast(
                                message:
                                    "You must select at least one category",
                                type: ToastSnackbarType.error);
                            return;
                          } else if (_currentStep == 0) {
                            preferencesSliderValidation.getProductCategories();
                          }
                          if (_currentStep == 1) {
                            preferencesSliderValidation
                                .initStoreRayons(userService.user!.tags ?? []);
                          }
                          if (_currentStep == 1 &&
                              (!(preferencesSliderValidation
                                      .productCategories!.isNotEmpty) ||
                                  preferencesSliderValidation.productCategories!
                                      .where(
                                          (element) => element.selected == true)
                                      .isEmpty)) {
                            ToastSnackbar().init(context).showToast(
                                message:
                                    "You must select at least one category",
                                type: ToastSnackbarType.error);
                            return;
                          } else if (_currentStep == 2) {
                            try {
                              // Navigator.pop(context);
                              Map<String, dynamic> formData =
                                  preferencesSliderValidation.toFormData();
                              userService.updateUser(context, formData);

                              // Code that might throw the exception
                            } catch (e, stackTrace) {
                              print('Exception: $e');
                              print('Stack Trace: $stackTrace');
                            }
                          }
                          setState(() {
                            if (_currentStep != 2) {
                              _currentStep = _currentStep + 1;
                            }
                          });
                        },
                        onStepCancel: () {
                          if (_currentStep != 0) {
                            if (_currentStep == 1) {
                              print("i'm here");
                              preferencesSliderValidation
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
                          getStoreCategoriesStep(
                              preferencesSliderValidation, context),
                          getStoreProductsCategoriesStep(
                              preferencesSliderValidation, context),
                          getStoreRayonsStep(
                              preferencesSliderValidation, context),
                        ],
                      )),
                ),
              ));
        }));
  }

  Step getStoreCategoriesStep(
      PreferencesSliderValidation preferencesSliderValidation,
      BuildContext context) {
    return Step(
        isActive: _currentStep >= 1,
        title: const Text(""),
        content: Column(
          children: [
            const Text("Store Categories",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            const SizedBox(height: 20),
            StoreCategorySelectionWidget()
          ],
        ));
  }

  Step getStoreProductsCategoriesStep(
      PreferencesSliderValidation preferencesSliderValidation,
      BuildContext context) {
    return Step(
        isActive: _currentStep >= 2,
        title: const Text(""),
        content: Column(
          children: [
            const Text("Product categories",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            const SizedBox(height: 20),
            ProductCategorySelectionWidget()
          ],
        ));
  }

  Step getStoreRayonsStep(
      PreferencesSliderValidation preferencesSliderValidation,
      BuildContext context) {
    return Step(
        isActive: _currentStep >= 3,
        title: const Text(""),
        content: Column(
          children: [
            const Text("Tags",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Color(0xFF136DA5))),
            const SizedBox(height: 20),
            StoreRayonSelectionWidget()
          ],
        ));
  }
}
