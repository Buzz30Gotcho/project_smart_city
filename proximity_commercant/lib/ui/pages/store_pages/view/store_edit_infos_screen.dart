import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';
import 'package:proximity_commercant/domain/store_repository/models/workingTime_model.dart';
import 'package:proximity_commercant/domain/store_repository/src/policy_creation_validation.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
import 'package:proximity_commercant/ui/pages/home_pages/view/home_screen.dart';
import 'package:proximity_commercant/ui/pages/store_pages/view/store_policy_screen.dart';
import 'package:proximity_commercant/ui/widgets/address_picker/address_picker.dart';

import 'package:proximity_commercant/ui/pages/store_pages/store_pages.dart';

class StoreCreationScreen extends StatefulWidget {
  const StoreCreationScreen({
    Key? key,
    this.index,
    required this.store,
    this.editScreen = false,
  }) : super(key: key);

  final int? index;
  final Store store;
  final bool editScreen;

  @override
  State<StoreCreationScreen> createState() => _StoreCreationScreenState();
}

class _StoreCreationScreenState extends State<StoreCreationScreen> {
  final int _currentIndex = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    User? _user = context.watch<UserService>().user;
    final storeCreationSliderValidation =
        Provider.of<StoreCreationSliderValidation>(context);

    if (_user!.policy == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialogPopup(
            context: context,
            pageBuilder: (ctx, anim1, anim2) => StatefulBuilder(
                builder: (context, setState) => DialogPopup(
                    child: SizedBox(
                        width:
                            MediaQuery.of(context).size.width - normal_200 * 2,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          const SizedBox(height: normal_100),
                          Stack(children: [
                            ImageFiltered(
                                imageFilter: blurFilter,
                                child: Icon(Icons.check_circle_outline_outlined,
                                    color:
                                        blueSwatch.shade100.withOpacity(1 / 3),
                                    size: normal_300)),
                            Icon(ProximityIcons.policy,
                                color: blueSwatch.shade100, size: normal_300)
                          ]),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: normal_100,
                                  left: normal_100,
                                  right: normal_100),
                              child: Text(
                                  'Please set your global policy before creating a new store.To ensure consistency across all your stores, it is important to set a global policy that will apply to all your stores. This policy can include details such as shipping and return policies, terms of service, and other important information for your customers.To set your global policy, please click the "Set Policy" button below. If you are  not ready to set your policy yet, you can click "Cancel" ',
                                  style: Theme.of(context).textTheme.titleSmall,
                                  textAlign: TextAlign.center)),
                          Padding(
                              padding: const EdgeInsets.all(normal_100),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                        child: SecondaryButton(
                                            title: 'Cancel.',
                                            onPressed: () => Navigator.of(
                                                    context)
                                                .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen()),
                                                    (Route<dynamic> route) =>
                                                        false))),
                                    const SizedBox(width: normal_100),
                                    Expanded(
                                        child: Consumer<StoreService>(
                                            builder: (context, storeService,
                                                    child) =>
                                                Expanded(
                                                    child: PrimaryButton(
                                                        title: 'Set Policy.',
                                                        onPressed: () {
                                                          /// Go to [HomeScreen]
                                                          Navigator.of(context).pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder: (context) => StorePolicyScreen(
                                                                      global:
                                                                          true,
                                                                      policy: _user!
                                                                          .policy)),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                        }))))
                                  ]))
                        ])))));
      });
    } else if (storeCreationSliderValidation.policy == null) {
      storeCreationSliderValidation.setPolicy(_user.policy!);
    }
  }

  int index = 0;
  //final storeCreation= Provider.of<StoreCreationSliderValidation>(context);

  Widget buildOpenDayList(
      StoreCreationSliderValidation storeCreationSliderValidation) {
    return Column(
      children: Day.map((day) {
        final dayName = day.toString().split('.').last;
        return Column(
          children: [
            CheckboxListTile(
              title: Text(dayName),
              value: storeCreationSliderValidation.selectedDays.contains(day),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    storeCreationSliderValidation.addSelectedDays(day);
                    storeCreationSliderValidation.addDayDayWorkingHours(day);
                  } else {
                    storeCreationSliderValidation.removeDay(day);
                    storeCreationSliderValidation.removeDayWorkingHours(day);
                  }
                });
              },
            ),
            if (storeCreationSliderValidation.selectedDays.contains(day))
              /* Padding(
                padding: const EdgeInsets.symmetric(horizontal: normal_100),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dayWorkingTimes[day]?.length ?? 0,
                  itemBuilder: (context, index) {
                    WorkingTime workingTime = dayWorkingTimes[day]![index];
                    return getTimeRange(
                        storeCreation, context, workingTime);
                  },
                ),
              ),*/
              if (storeCreationSliderValidation.selectedDays.contains(day))
                Padding(
                  padding: const EdgeInsets.all(normal_100),
                  child: TertiaryButton(
                    onPressed: () {
                      setState(() {
                        /*  dayWorkingTimes[day]
                            ?.add(TimeRange(openTime: null, closeTime: null));*/
                      });
                    },
                    title: "Add working time",
                  ),
                ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildOpenDaysAndWorkingTimesWidget(
      StoreCreationSliderValidation storeCreationSliderValidation) {
    return Column(
      children: [
        buildOpenDayList(storeCreationSliderValidation),
      ],
    );
  }

  //List<TimeRange> workingTimes = [];
  Map<String, String> workingTimesOptions = {
    "1": "Fixed Daily Schedule",
    "2": "Customized Working Hours"
  };

  Policy? policyResult;
  @override
  Widget build(BuildContext context) {
    final policyValidation = Provider.of<PolicyValidation>(context);
    User? _user = context.watch<UserService>().user;

    /// a boolean to help fetch data ONLY if necessary
    bool didFetch = true;

    return Consumer2<StoreCreationSliderValidation, StoreService>(
        builder: (context, storeCreationSliderValidation, storeService, child) {
      /// first check if [index] is null or not
      /// if it is null then it's a ShopAddingScreen, so no need to fetch data
      /// to edit it, and no need for a loading screen
      ///
      /// otherwise we need to check if we already fetched the data and then
      /// proceed with the rendering
      ///

      if (widget.index != null) {
        didFetch = storeService.stores![widget.index!].allFetched();

        if (!didFetch) storeService.getStoreByIndex(widget.index!);
      }
      return
          // Scaffold(
          //     body: SafeArea(
          //         child: Stack(alignment: Alignment.bottomCenter, children: [
          Column(children: [
        // TopBar(
        //     title: widget.editScreen
        //         ? 'Edit Store.'
        //         : 'Create a new Store.'),
        /* SectionDivider(
                  leadIcon: ProximityIcons.user,
                  title: 'Store owner.',
                  color: redSwatch.shade500),
              Selector<UserService, String?>(
                  selector: (_, userService) => userService.user!.email,
                  builder: (context, email, child) {
                    return RichEditText(
                      children: [
                        EditText(
                            hintText: 'Owner email.',
                            saved: email,
                            enabled: true),
                      ],
                    );
                  }),*/

        /// Store Details
        SectionDivider(
            leadIcon: ProximityIcons.edit,
            title: 'Store details.',
            color: redSwatch.shade500),

        EditText(
          hintText: 'Name',
          borderType: BorderType.top,
          saved: storeCreationSliderValidation.storeName.value,
          errorText: storeCreationSliderValidation.storeName.error,
          enabled: (widget.store.name == null) || widget.editScreen,
          onChanged: storeCreationSliderValidation.changeStoreName,
        ),

        const EditTextSpacer(),
        EditText(
          hintText: 'Description.',
          borderType: BorderType.bottom,
          keyboardType: TextInputType.multiline,
          saved: storeCreationSliderValidation.storeDescription.value,
          errorText: storeCreationSliderValidation.storeDescription.error,
          maxLines: 5,
          enabled: (widget.store.description == null) || widget.editScreen,
          onChanged: storeCreationSliderValidation.changeStoreDescription,
        ),
        const InfoMessage(
            message:
                'Please provide your commercial registration number. This is a unique identifier assigned to your business by the relevant government authority'),
        const EditTextSpacer(),
        EditText(
          hintText: 'Commercial Registration Number',
          saved: storeCreationSliderValidation.storeRegistrationNumber.value,
          errorText:
              storeCreationSliderValidation.storeRegistrationNumber.error,
          enabled:
              (widget.store.registrationNumber == null) || widget.editScreen,
          onChanged:
              storeCreationSliderValidation.changeStoreRegistrationNumber,
        ),

        SectionDivider(
            leadIcon: ProximityIcons.picture,
            title: 'Store Image.',
            color: redSwatch.shade500),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: normal_125),
          child: ImagePickerWidget(
              images: storeCreationSliderValidation.storeImages,
              maxImages: 1,
              onImageAdded: storeCreationSliderValidation.addStoreImage,
              onImageRemoved: storeCreationSliderValidation.removeStoreImage),
        ),

        /// Error Messages
        //  const SizedBox(height: small_100),
        const ErrorMessage(errors: [
          // storeCreationSliderValidation.storeName.error,
          //storeCreationSliderValidation.storeDescription.error
        ]),

        /// Policy

        const SizedBox(height: normal_100),

        SectionDivider(
            leadIcon: Icons.timer_outlined,
            title: 'Working time.',
            color: redSwatch.shade500),
        const InfoMessage(
            message:
                "By updating your working hours in the app, your clients will be informed about when you're open for pickups. Take a moment to add your working hours and keep your customers in the loop"),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: normal_100),
            child: DropDownSelector<String>(
                hintText: 'Select working time option.',
                savedValue: storeCreationSliderValidation.workingTimeOption,
                onChanged:
                    storeCreationSliderValidation.changeWorkingTimeOption,
                items: workingTimesOptions.entries
                    .map((item) => DropdownItem<String>(
                        value: item.key,
                        child: Text(item.value,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600))))
                    .toList())
            // }),
            ),
        storeCreationSliderValidation.workingTimeOption == "1"
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: normal_100),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: normal_100),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: storeCreationSliderValidation
                            .fixedWorkingHours!.length,
                        itemBuilder: (context, index) {
                          TimeRange workingTime = storeCreationSliderValidation
                              .fixedWorkingHours![index];
                          return getTimeRange(
                              storeCreationSliderValidation,
                              context,
                              workingTime,
                              null,
                              storeCreationSliderValidation.workingTimeOption);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(normal_100),
                      child: TertiaryButton(
                        onPressed: () {
                          setState(() {
                            storeCreationSliderValidation.addFixedWorkingHours(
                                TimeRange(
                                    openTime:
                                        const TimeOfDay(hour: 9, minute: 0),
                                    closeTime:
                                        const TimeOfDay(hour: 0, minute: 0)));
                          });
                        },
                        title: "Add working time",
                      ),
                    )
                  ],
                ),
              )
            : storeCreationSliderValidation.workingTimeOption == "2"
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: normal_100),
                    child: Column(
                      children: [
                        Column(
                          children: Day.map((day) {
                            final dayName = day.toString().split('.').last;
                            return Column(
                              children: [
                                CheckboxListTile(
                                  activeColor: const Color(
                                      0xFF2196F3), // bluewatch color
                                  checkColor:
                                      Colors.white, // contrasting color (white)
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: normal_150),
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  title: Text(
                                    dayName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: storeCreationSliderValidation
                                              .selectedDays
                                              .contains(day)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: storeCreationSliderValidation
                                              .selectedDays
                                              .contains(day)
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                    /*Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),*/
                                  ),
                                  value: storeCreationSliderValidation
                                      .selectedDays
                                      .contains(day),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        storeCreationSliderValidation
                                            .addSelectedDays(day);
                                        storeCreationSliderValidation
                                            .addDayDayWorkingHours(day);
                                        // dayWorkingTimes[day] = [];
                                      } else {
                                        storeCreationSliderValidation
                                            .deleteSelectedDay(day);
                                        storeCreationSliderValidation
                                            .removeDayWorkingHours(day);
                                        storeCreationSliderValidation
                                            .removeDay(day);
                                      }
                                    });
                                  },
                                ),
                                if (storeCreationSliderValidation.selectedDays
                                    .contains(day))
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: normal_100),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: storeCreationSliderValidation
                                              .dayWorkingHours![day]?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        TimeRange workingTime =
                                            storeCreationSliderValidation
                                                .dayWorkingHours![day]![index];
                                        return Column(
                                          children: [
                                            getTimeRange(
                                                storeCreationSliderValidation,
                                                context,
                                                workingTime,
                                                day,
                                                storeCreationSliderValidation
                                                    .workingTimeOption),
                                            /*  ErrorMessage(errors: [
                                                storeCreationSliderValidation
                                                    .errorMessage,
                                              ]),*/
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                if (storeCreationSliderValidation.selectedDays
                                    .contains(day))
                                  Padding(
                                    padding: const EdgeInsets.all(normal_100),
                                    child: TertiaryButton(
                                      onPressed: () {
                                        setState(() {
                                          storeCreationSliderValidation
                                              .addDayWorkingHours(
                                                  day,
                                                  TimeRange(
                                                      openTime: const TimeOfDay(
                                                          hour: 9, minute: 0),
                                                      closeTime:
                                                          const TimeOfDay(
                                                              hour: 0,
                                                              minute: 0)));
                                          /*  dayWorkingTimes[day]?.add(TimeRange(
                                                openTime: null,
                                                closeTime: null));*/
                                        });
                                      },
                                      title: "Add working time",
                                    ),
                                  ),
                              ],
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  )
                : Container(),

        /// Address
        SectionDivider(
            leadIcon: ProximityIcons.address,
            title: 'Address.',
            color: redSwatch.shade500),
        const InfoMessage(
            message:
                'Select your Store Location from the Address Picker, then edit the address info for more accuracy.'),
        Padding(
          padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
          child: TertiaryButton(
              onPressed: () async {
                final Address _result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressSelectionScreen(
                            currentAddress:
                                storeCreationSliderValidation.storeAddress)));
                setState(() {
                  print(_result);
                  storeCreationSliderValidation.changeAddress(_result);
                });
              },
              title: 'Select Address.'),
        ),
        Text(storeCreationSliderValidation.storeAddress.fullAddress ?? ""),
        EditText(
          controller: () {
            TextEditingController _controller = TextEditingController();
            _controller.text =
                storeCreationSliderValidation.storeAddress.fullAddress ?? "";
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
            return _controller;
          }(),
          hintText: 'Street Address Line 1.',
          borderType: BorderType.top,
          enabled: (widget.store.address == null) || widget.editScreen,
          onChanged: storeCreationSliderValidation.changeFullAddress,
        ),
        const EditTextSpacer(),
        EditText(
          controller: () {
            TextEditingController _controller = TextEditingController();
            _controller.text =
                storeCreationSliderValidation.storeAddress.streetName ?? "";
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
            return _controller;
          }(),
          hintText: 'Street Address Line 2.',
          borderType: BorderType.middle,
          enabled: (widget.store.address == null) || widget.editScreen,
          onChanged: storeCreationSliderValidation.changeStreetName,
        ),
        const EditTextSpacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: normal_100),
          child: DropDownSelector<String>(
            // labelText: 'Product Category.',
            hintText: 'Country.',
            onChanged: storeCreationSliderValidation.changeCountry,
            borderType: BorderType.middle,
            savedValue:
                storeCreationSliderValidation.storeAddress.countryCode ?? "",
            items: countryList.entries
                .map((item) => DropdownItem<String>(
                    value: item.key,
                    child: Text(item.value,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w600))))
                .toList(),
          ),
        ),
        const EditTextSpacer(),
        EditText(
          controller: () {
            TextEditingController _controller = TextEditingController();
            _controller.text =
                storeCreationSliderValidation.storeAddress.region ?? "";
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
            return _controller;
          }(),
          hintText: 'Region.',
          borderType: BorderType.middle,
          enabled: (widget.store.address == null) || widget.editScreen,
          onChanged: storeCreationSliderValidation.changeRegion,
        ),
        const EditTextSpacer(),
        EditText(
          controller: () {
            TextEditingController _controller = TextEditingController();
            _controller.text =
                storeCreationSliderValidation.storeAddress.city ?? "";
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
            return _controller;
          }(),
          hintText: 'City.',
          borderType: BorderType.middle,
          enabled: (widget.store.address == null) || widget.editScreen,
          onChanged: storeCreationSliderValidation.changeCity,
        ),
        const EditTextSpacer(),
        EditText(
          controller: () {
            TextEditingController _controller = TextEditingController();
            _controller.text =
                storeCreationSliderValidation.storeAddress.postalCode ?? "";
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
            return _controller;
          }(),
          hintText: 'Postal Code.',
          borderType: BorderType.bottom,
          enabled: (widget.store.address == null) || widget.editScreen,
          onChanged: storeCreationSliderValidation.changePostalCode,
        ),

        SectionDivider(
            leadIcon: ProximityIcons.policy,
            title: 'Store Policy.',
            color: redSwatch.shade500),
        const InfoMessage(
            message:
                ' Keep  global policy ensures fair and transparent transactions. When creating a new store, you can keep this policy for all your stores or create a custom policy for each store. Review the policy and create custom policies to build trust with your customers'),
        Padding(
          padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
          child: Column(
            children: [
              ListToggle(
                  title: 'keep global policy',
                  value: storeCreationSliderValidation.globalPolicy!,
                  onToggle: storeCreationSliderValidation.toggleGlobalPolicy),
              if (!storeCreationSliderValidation.globalPolicy!)
                Padding(
                  padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
                  child: TertiaryButton(
                      onPressed: () async {
                        Policy? policyResult = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StorePolicyScreen(
                                      global: false,
                                      store: true,
                                      policy:
                                          widget.store.policy ?? _user!.policy,
                                    )));

                        storeCreationSliderValidation.setPolicy(policyResult);

                        // final Address _result = await
                        /* widget.editScreen
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StorePolicyScreen(
                                                          global: false,
                                                          policy: widget
                                                              .store.policy,
                                                        )))
                                            :
                                            Policy? storePolicy=  StorePolicyScreen(
                                                global: false,
                                              );*/
                        // storeCreationSliderValidation.changeAddress(_result);
                      },
                      title: 'Set Custom  Policy .'),
                )
              else
                Container(),
            ],
          ),
        ),

        /// Image Picker
      ]);
      // BottomActionsBar(buttons: [
      //   PrimaryButton(
      //       buttonState: storeService.formsLoading
      //           ? ButtonState.loading
      //           : (storeCreationSliderValidation.isValid)
      //               ? ButtonState.enabled
      //               : ButtonState.disabled,
      //       onPressed: () {
      //         if (storeCreationSliderValidation.globalPolicy!) {
      //           storeCreationSliderValidation.setPolicy(_user!.policy!);
      //         }
      //         if (widget.editScreen) {
      //           storeService.editStore(
      //               context,
      //               widget.index!,
      //               storeCreationSliderValidation
      //                   .toFormData(storeCreationSliderValidation.policy!),
      //               []);
      //         } else {
      //           StoreDialogs.confirmStore(context, 1);
      //           storeService.addStore(
      //               context,
      //               storeCreationSliderValidation
      //                   .toFormData(storeCreationSliderValidation.policy!));
      //         }
      //       },
      //       title: 'Confirm.')
      // ])
      // ])
    });

    // ));
  }

  Padding getTimeRange(
      StoreCreationSliderValidation storeCreationSliderValidation,
      BuildContext context,
      TimeRange workingTime,
      String? day,
      String? option) {
    storeCreationSliderValidation.changeTimeRangeKey;
    int index = storeCreationSliderValidation.timeRangeKey;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: small_100),
      child: Dismissible(
        key: Key('$index'), // Unique key for each widget
        direction: DismissDirection.endToStart, // Swipe from right to left
        onDismissed: (_) {
          // Handle widget dismissal
          setState(() {
            if (option == '1') {
              storeCreationSliderValidation
                  .deleteFixedWorkingHours(workingTime);
            } else {
              storeCreationSliderValidation.deleteDayWorkingHours(
                  day.toString(), workingTime);
            }
          });
        },
        background: Container(
          color:
              redSwatch.shade500, // Customize the background color when swiping
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.highlight_remove_rounded,
            color: Colors.white,
          ),
        ),
        child: Row(children: [
          Expanded(
            child: TimeButton(
              onPressed: (() async {
                TimeOfDay? selectedTime =
                    await storeCreationSliderValidation.getStartTime(
                        context, storeCreationSliderValidation.openTime);
                setState(() {
                  workingTime.openTime = selectedTime;
                });
              }),
              text: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${workingTime.openTime?.hour.toString().padLeft(2, '0')}:${workingTime.openTime?.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.timer_outlined,
                    size: normal_200,
                    color: redSwatch.shade500,
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: small_100),
            child: Text(
              'To',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: TimeButton(
              onPressed: (() async {
                TimeOfDay? selectedTime =
                    await storeCreationSliderValidation.getClosingTime(
                        context, storeCreationSliderValidation.closeTime);
                setState(() {
                  workingTime.closeTime = selectedTime;
                  if (option == '1') {
                    storeCreationSliderValidation
                        .addFixedWorkingHours(workingTime);
                  } else {
                    storeCreationSliderValidation.addCustomizedHours(
                        day.toString(), workingTime);
                  }
                });
              }),
              text: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${workingTime.closeTime?.hour.toString().padLeft(2, '0')}:${workingTime.closeTime?.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.timer_outlined,
                    size: normal_200,
                    color: redSwatch.shade500,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';
import 'package:proximity_commercant/domain/store_repository/store_repository.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
import 'package:proximity_commercant/ui/pages/home_pages/home_pages.dart';
import 'package:proximity_commercant/ui/widgets/address_picker/address_picker.dart';

class StoreCreationScreen extends StatelessWidget {
  const StoreCreationScreen(
      {Key? key, this.index, required this.store, this.editScreen = false})
      : super(key: key);

  final int? index;
  final Store store;
  final bool editScreen;

  @override
  Widget build(BuildContext context) {
    /// a boolean to help fetch data ONLY if necessary
    bool didFetch = true;

    return ChangeNotifierProvider<StoreCreationSliderValidation>(
        create: (context) => StoreCreationSliderValidation.setStore(store),
        child: Consumer2<StoreCreationSliderValidation, StoreService>(
            builder: (context, storeCreationSliderValidation, storeService, child) {
          /// first check if [index] is null or not
          /// if it is null then it's a ShopAddingScreen, so no need to fetch data
          /// to edit it, and no need for a loading screen
          ///
          /// otherwise we need to check if we already fetched the data and then
          /// proceed with the rendering
          ///
          if (index != null) {
            didFetch = storeService.stores![index!].allFetched();
            if (!didFetch) storeService.getStoreByIndex(index!);
          }
          return Scaffold(
              body: SafeArea(
                  child: Stack(alignment: Alignment.bottomCenter, children: [
            ListView(children: [
              TopBar(title: editScreen ? 'Edit Store.' : 'Create a new Store.'),
              SectionDivider(
                  leadIcon: ProximityIcons.user,
                  title: 'Store owner.',
                  color: redSwatch.shade500),
              Selector<UserService, String?>(
                  selector: (_, userService) => userService.user!.email,
                  builder: (context, email, child) {
                    return EditText(
                        borderType: BorderType.middle,
                        hintText: 'Owner email.',
                        saved: email,
                        enabled: false);
                  }),

              /// Store Details
              SectionDivider(
                  leadIcon: ProximityIcons.edit,
                  title: 'Store details.',
                  color: redSwatch.shade500),
              EditText(
                hintText: 'Name.',
                borderType: BorderType.middle,
                saved: storeCreationSliderValidation.storeName.value,
                errorText: storeCreationSliderValidation.storeName.error,
                enabled: (store.name == null) || editScreen,
                onChanged: storeCreationSliderValidation.changeStoreName,
              ),
              const EditTextSpacer(),
              EditText(
                hintText: 'Description.',
                borderType: BorderType.middle,
                keyboardType: TextInputType.multiline,
                saved: storeCreationSliderValidation.storeDescription.value,
                errorText: storeCreationSliderValidation.storeDescription.error,
                maxLines: 5,
                enabled: (store.description == null) || editScreen,
                onChanged: storeCreationSliderValidation.changeStoreDescription,
              ),

              /// Error Messages
              const SizedBox(height: small_100),
              ErrorMessage(errors: [
                storeCreationSliderValidation.storeName.error,
                storeCreationSliderValidation.storeDescription.error
              ]),

              /// Policy
              SectionDivider(
                  leadIcon: ProximityIcons.policy,
                  title: 'Store Policy.',
                  color: redSwatch.shade500),
              const InfoMessage(
                  message:
                      'Select the type of Deliveries your store support, and set a delivery tax value in case you deliver your orders.'),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: small_100),
                  child: Row(children: [
                    Expanded(
                        child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: small_100),
                      child: LargeIconButton(
                          onPressed: storeCreationSliderValidation.toggleSelfPickup,
                          selected:
                              (storeCreationSliderValidation.selfPickup ?? false),
                          icon: DuotoneIcon(
                              primaryLayer:
                                  ProximityIcons.self_pickup_duotone_1,
                              secondaryLayer:
                                  ProximityIcons.self_pickup_duotone_2,
                              color: redSwatch.shade500),
                          title: 'Self Pickup'),
                    )),
                    Expanded(
                        child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: small_100),
                      child: LargeIconButton(
                          onPressed: storeCreationSliderValidation.toggleDelivery,
                          selected: (storeCreationSliderValidation.delivery ?? false),
                          icon: DuotoneIcon(
                              primaryLayer: ProximityIcons.delivery_duotone_1,
                              secondaryLayer: ProximityIcons.delivery_duotone_2,
                              color: redSwatch.shade500),
                          title: 'Delivery'),
                    ))
                  ])),
              if (storeCreationSliderValidation.selfPickup ?? false) ...[
                ListToggle(
                    title: 'Free SelfPickup',
                    value: storeCreationSliderValidation.selfPickupFree!,
                    onToggle: storeCreationSliderValidation.toggleSelfPickupFree),
                ListToggle(
                    title: 'Partial SelfPickup',
                    value: storeCreationSliderValidation.selfPickupPartial!,
                    onToggle: storeCreationSliderValidation.toggleSelfPickupPartial),
                ListToggle(
                    title: 'Total SelfPickup',
                    value: storeCreationSliderValidation.selfPickupTotal!,
                    onToggle: storeCreationSliderValidation.toggleSelfPickupTotal),
                if (!(storeCreationSliderValidation.selfPickupFree ?? false)) ...[
                  const SizedBox(height: normal_100),
                  EditText(
                    hintText: 'SelfPickup Price.',
                    keyboardType: TextInputType.number,
                    saved: (storeCreationSliderValidation.selfPickupPrice == null)
                        ? ""
                        : storeCreationSliderValidation.selfPickupPrice.toString(),
                    enabled: (store.policy == null) || editScreen,
                    onChanged: storeCreationSliderValidation.changeSelfPickupPrice,
                  )
                ],
              ],
              if (storeCreationSliderValidation.delivery ?? false) ...[
                const SizedBox(height: normal_100),
                EditText(
                  hintText: 'Delivery Tax.',
                  keyboardType: TextInputType.number,
                  saved: (storeCreationSliderValidation.tax == null)
                      ? ""
                      : storeCreationSliderValidation.tax.toString(),
                  enabled: (store.policy == null) || editScreen,
                  onChanged: storeCreationSliderValidation.changeTax,
                )
              ],
              const SizedBox(height: normal_100),
              const EditText(
                hintText: 'Opening Time.',
                prefixIcon: Icons.timer_outlined,
                // suffixIcon: ProximityIcons.chevron_bottom,
                borderType: BorderType.middle,
              ),
              const EditTextSpacer(),
              const EditText(
                hintText: 'Closing Time.',
                prefixIcon: Icons.timer_outlined,
                // suffixIcon: ProximityIcons.chevron_bottom,
                borderType: BorderType.middle,
              ),

              /// Address
              SectionDivider(
                  leadIcon: ProximityIcons.address,
                  title: 'Address.',
                  color: redSwatch.shade500),
              const InfoMessage(
                  message:
                      'Select your Store Location from the Address Picker, then edit the address info for more accuracy.'),
              Padding(
                padding: const EdgeInsets.all(normal_100).copyWith(top: 0),
                child: TertiaryButton(
                    onPressed: () async {
                      final Address _result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressSelectionScreen(
                                  currentAddress:
                                      storeCreationSliderValidation.storeAddress)));
                      storeCreationSliderValidation.changeAddress(_result);
                    },
                    title: 'Select Address.'),
              ),
              EditText(
                hintText: 'Street Address Line 1.',
                //  borderType: BorderType.middle,
                saved: storeCreationSliderValidation.storeAddress.fullAddress,
                enabled: (store.address == null) || editScreen,
                onChanged: storeCreationSliderValidation.changeFullAddress,
              ),
              const EditTextSpacer(),
              EditText(
                hintText: 'Street Address Line 2.',
                borderType: BorderType.middle,
                saved: storeCreationSliderValidation.storeAddress.streetName,
                enabled: (store.address == null) || editScreen,
                onChanged: storeCreationSliderValidation.changeStreetName,
              ),

              DropDownSelector<String>(
                padding: true,

                // labelText: 'Product Category.',
                hintText: 'Country.',
                onChanged: storeCreationSliderValidation.changeCountry,
                // borderType: BorderType.middle,
                savedValue: storeCreationSliderValidation.storeAddress.countryCode,
                items: countryList.entries
                    .map((item) => DropdownItem<String>(
                        value: item.key,
                        child: Text(item.value,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.w600))))
                    .toList(),
              ),
              const EditTextSpacer(),
              EditText(
                hintText: 'Region.',
                borderType: BorderType.middle,
                saved: storeCreationSliderValidation.storeAddress.region,
                enabled: (store.address == null) || editScreen,
                onChanged: storeCreationSliderValidation.changeRegion,
              ),
              const EditTextSpacer(),
              EditText(
                hintText: 'City.',
                borderType: BorderType.middle,
                saved: storeCreationSliderValidation.storeAddress.city,
                enabled: (store.address == null) || editScreen,
                onChanged: storeCreationSliderValidation.changeCity,
              ),
              const EditTextSpacer(),

              EditText(
                hintText: 'Postal Code.',
                borderType: BorderType.bottom,
                saved: storeCreationSliderValidation.storeAddress.postalCode,
                enabled: (store.address == null) || editScreen,
                onChanged: storeCreationSliderValidation.changePostalCode,
              ),

              /// Image Picker
              SectionDivider(
                  leadIcon: ProximityIcons.picture,
                  title: 'Store Image.',
                  color: redSwatch.shade500),
              ImagePickerWidget(
                  images: storeCreationSliderValidation.storeImages,
                  maxImages: 1,
                  onImageAdded: storeCreationSliderValidation.addStoreImage,
                  onImageRemoved: storeCreationSliderValidation.removeStoreImage),

              const SizedBox(height: huge_100)
            ]),
            BottomActionsBar(buttons: [
              PrimaryButton(
                  buttonState: storeService.formsLoading
                      ? ButtonState.loading
                      : (storeCreationSliderValidation.isValid)
                          ? ButtonState.enabled
                          : ButtonState.disabled,
                  onPressed: () async {
                    if (editScreen) {
                      await storeService.editStore(context, index!,
                          storeCreationSliderValidation.toFormData(), []);
                      
                    } else {
                      await storeService.addStore(
                          context, storeCreationSliderValidation.toFormData());
                      if (!storeService.formsLoading) {
                    
                      }
                    }
                  },
                  title: 'Confirm.')
            ])
          ])));
        }));
  }
}
*/
