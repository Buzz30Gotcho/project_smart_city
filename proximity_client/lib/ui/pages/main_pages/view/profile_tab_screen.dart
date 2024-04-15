import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/authentication/authentication.dart';
import 'package:proximity_client/domain/data_persistence/src/boxes.dart';
import 'package:proximity_client/domain/notification_repository/notification_repository.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';
import 'package:proximity_client/ui/pages/pages.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var credentialsBox = Boxes.getCredentials();

    String? token = credentialsBox.get('token');

    final loginValidation = Provider.of<LoginValidation>(context);
    final userService = Provider.of<UserService>(context);
    final notificationsService = Provider.of<NotificationService>(context);
    final localizations = AppLocalizations.of(context);

    if (token != null && userService.user == null) {
      userService.getUserData();
    }

    return (token == null)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: normal_100),
            child: Column(children: [
              const SizedBox(height: large_100),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: normal_100),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(width: normal_100),
                        Expanded(
                            child: Text('Account Options.',
                                style: Theme.of(context).textTheme.titleMedium)),
                      ])),
              const SizedBox(
                height: large_100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: small_100),
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    title: 'Sign Up.',
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: SecondaryButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  title: 'Log In.',
                ),
              )
            ]),
          )
        : ListView(
            padding: const EdgeInsets.symmetric(vertical: large_100),
            children: [
              const AccountSwitcher(),
              const OrdersDashboard(),
              SectionDivider(
                  title: localizations!.settings,
                  leadIcon: ProximityIcons.settings,
                  color: redSwatch.shade500),
              ListButton(
                  title: localizations.editProfile,
                  leadIcon: ProximityIcons.edit,
                  onPressed: (userService.user == null)
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen()));
                        }),
              ListButton(
                  title: localizations.appearanceText,
                  leadIcon: ProximityIcons.preferences,
                  onPressed: (userService.user == null)
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PreferencesSliderScreen()));
                        }),
              ListButton(
                  title: localizations.payment,
                  leadIcon: ProximityIcons.credit_card,
                  onPressed: null),
              // onPressed: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const EditPaymentMethodsScreen()));
              // }),
              ListButton(
                  title: localizations.appearanceText,
                  leadIcon: ProximityIcons.appearance,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppearanceScreen()));
                  }),
              ListButton(
                  title: localizations.language,
                  leadIcon: ProximityIcons.language,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LanguageScreen()));
                  }),
              Consumer<NotificationService>(
                  builder: (_, notificationService, __) {
                var nbNotifs = notificationService.notifications
                    .where((element) => element.seendInList != true)
                    .length;
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        if (nbNotifs > 0)
                          Container(
                              padding: const EdgeInsets.all(tiny_50),
                              margin: const EdgeInsets.only(top: 2, left: 30),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(tinyRadius),
                                  color: redSwatch.shade500),
                              child: Text(
                                '$nbNotifs',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: primaryTextDarkColor,
                                        fontWeight: FontWeight.w800),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ListButton(
                            title: localizations.notificationsText,
                            leadIcon: ProximityIcons.notifications,
                            onPressed: () {
                              // notificationService.makeItListSeend();
                              // notificationService.getNotifications(context);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationSettingsScreen(
                                              user: userService.user)));
                            }),
                      ])
                    ]);
              }),

              const SizedBox(height: normal_100),
              SectionDivider(
                  title: localizations.appearanceText,
                  leadIcon: ProximityIcons.info,
                  color: redSwatch.shade500),
              ListButton(
                  title: localizations.rateSmartCityText,
                  leadIcon: ProximityIcons.star,
                  onPressed: null),
              ListButton(
                  title: localizations.contactSupportText,
                  leadIcon: ProximityIcons.support,
                  onPressed: null),
              ListButton(
                  title: localizations.logoutText,
                  onPressed: () {
                    loginValidation.logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const MainScreen()),
                        (route) => false);
                  }),
              const SizedBox(height: large_200 + small_100),
            ],
          );
  }
}
