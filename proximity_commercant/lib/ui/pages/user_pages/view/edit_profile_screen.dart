import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity/widgets/forms/edit_text_spacer.dart';
//import 'package:proximity/widgets/image_picker/image_card.dart';
import 'package:proximity/widgets/image_picker/image_profile.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
import 'package:proximity_commercant/ui/widgets/address_picker/address_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Consumer<UserService>(
      builder: (_, userService, __) {
        return ChangeNotifierProvider(
          create: (_) => UserEditValidation.setUser(userService.user!),
          child: Consumer<UserEditValidation>(
            builder: (_, userEditValidation, __) {
              return Scaffold(
                body: SafeArea(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView(
                        children: [
                          TopBar(title: localizations!.editProfileTitle),
                          ImageProfile(
                            images: userEditValidation.profileImage,
                            maxImages: 1,
                            centered: true,
                            onImageAdded: (File file) {
                              userEditValidation.editProfileImage(
                                  file, userService);
                            },
                            onImageRemoved:
                                userEditValidation.removeProfileImage,
                          ),
                          SectionDivider(
                            leadIcon: ProximityIcons.user,
                            title: localizations.personalInfoTitle,
                            color: redSwatch.shade500,
                          ),
                          EditText(
                            hintText: localizations.firstName,
                            borderType: BorderType.topLeft,
                            saved: userEditValidation.userName.value,
                            onChanged: userEditValidation.changeUserName,
                          ),
                          SectionDivider(
                            leadIcon: ProximityIcons.email,
                            title: localizations.emailTitle,
                            color: redSwatch.shade500,
                          ),
                          EditText(
                            hintText: localizations.email,
                            prefixIcon: ProximityIcons.email,
                            saved: userEditValidation.emailAddress.value,
                            onChanged: userEditValidation.changeEmailAddress,
                          ),
                          SectionDivider(
                            leadIcon: ProximityIcons.phone,
                            title: localizations.phoneNumberTitle,
                            color: redSwatch.shade500,
                          ),
                          EditText(
                            hintText: localizations.phoneNumber,
                            saved: userEditValidation.phone.value,
                            onChanged: userEditValidation.changePhoneNumber,
                          ),
                          SectionDivider(
                            leadIcon: ProximityIcons.address,
                            title: localizations.addressTitle,
                            color: redSwatch.shade500,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(normal_100)
                                .copyWith(top: 0),
                            child: TertiaryButton(
                              onPressed: () async {
                                final Address _result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddressSelectionScreen(
                                      currentAddress:
                                          userEditValidation.address,
                                    ),
                                  ),
                                );
                                userEditValidation.changeAddress(_result);
                              },
                              title: localizations.selectAddressButton,
                            ),
                          ),
                          EditText(
                            hintText: localizations.streetAddressLine1Hint,
                            saved: userEditValidation.address.fullAddress,
                            onChanged: userEditValidation.changeFullAddress,
                          ),
                          const EditTextSpacer(),
                          EditText(
                            hintText: localizations.streetAddressLine2Hint,
                            saved: userEditValidation.address.streetName,
                            onChanged: userEditValidation.changeStreetName,
                          ),
                          const EditTextSpacer(),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: normal_100),
                            child: DropDownSelector<String>(
                              hintText: localizations.countryHint,
                              onChanged: userEditValidation.changeCountry,
                              borderType: BorderType.middle,
                              savedValue:
                                  userEditValidation.address.countryCode,
                              items: countryList.entries
                                  .map(
                                    (item) => DropdownItem<String>(
                                      value: item.key,
                                      child: Text(
                                        item.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          const EditTextSpacer(),
                          EditText(
                            hintText: localizations.regionHint,
                            saved: userEditValidation.address.region,
                            onChanged: userEditValidation.changeRegion,
                          ),
                          const EditTextSpacer(),
                          EditText(
                            hintText: localizations.cityHint,
                            saved: userEditValidation.address.city,
                            onChanged: userEditValidation.changeCity,
                          ),
                          const EditTextSpacer(),
                          EditText(
                            hintText: localizations.postalCodeHint,
                            saved: userEditValidation.address.postalCode,
                            onChanged: userEditValidation.changePostalCode,
                          ),
                          const SizedBox(height: huge_100),
                        ],
                      ),
                      Consumer<UserService>(
                        builder: (_, userService, __) {
                          return BottomActionsBar(
                            buttons: [
                              PrimaryButton(
                                onPressed: () {
                                  userService.updateUser(
                                    context,
                                    userEditValidation.toDataForm(),
                                  );
                                },
                                buttonState: userService.loading
                                    ? ButtonState.loading
                                    : ButtonState.enabled,
                                title: localizations.updateButton,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
