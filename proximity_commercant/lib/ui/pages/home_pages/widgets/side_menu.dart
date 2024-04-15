import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/l10n/app_localizations_ar.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/authentication/authentication.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/domain/notification_repository/notification_repository.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/view/onBoard.dart';
import 'package:proximity_commercant/ui/pages/stat_pages/view/global_statistiques.dart';
import 'package:proximity_commercant/ui/pages/store_pages/view/store_policy_screen.dart';
import 'package:proximity_commercant/ui/pages/user_pages/user_pages.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width - normal_200;
    final loginValidation = Provider.of<LoginValidation>(context);
    final userService = Provider.of<UserService>(context);
    final localizations = AppLocalizations.of(context);
    return SafeArea(
        child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Theme.of(context).dividerColor, width: tiny_50),
                borderRadius:
                    const BorderRadius.horizontal(right: normalRadius)),
            child: SizedBox(
                width: _width,
                child:
                    ListView(physics: const ClampingScrollPhysics(), children: [
                  const SizedBox(height: normal_200),
                  const AccountSwitcher(),
                  SectionDivider(
                      leadIcon: ProximityIcons.settings,
                      title: localizations!.settings,
                      color: redSwatch.shade400),
                  Selector<UserService, bool>(
                      selector: (_, userService) => userService.valid,
                      builder: (context, valid, child) {
                        return ListButton(
                            title: localizations!.editProfile,
                            leadIcon: ProximityIcons.edit,
                            enabled: valid,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen()));
                            });
                      }),
                  Selector<UserService, bool?>(
                      selector: (_, userService) =>
                          userService.user?.policy != null,
                      builder: (context, valid, child) {
                        return ListButton(
                            title: localizations!.verifyIdentityText,
                            leadIcon: ProximityIcons.password,
                            enabled: valid,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfileScreen()));
                            });
                      }),
                  Selector<UserService, bool?>(
                      selector: (_, userService) =>
                          userService.user?.policy != null,
                      builder: (context, valid, child) {
                        return ListButton(
                            title: localizations!.editGlobalPolicyText,
                            leadIcon: ProximityIcons.policy,
                            enabled: valid,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StorePolicyScreen(
                                            policy: userService.user?.policy,
                                            global: true,
                                          )));
                              print('pp');
                              print(userService.user?.policy!.toJson());
                            });
                      }),
                  ListButton(
                      title: localizations!.statisticsText,
                      leadIcon: Icons.bar_chart,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GlobalStatisticsScreen()));
                      }),
                  ListButton(
                      title: localizations!.settings,
                      leadIcon: ProximityIcons.preferences,
                      enabled: false,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsScreen()));
                      }),
                  ListButton(
                      title: localizations!.appearanceText,
                      leadIcon: ProximityIcons.appearance,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AppearanceScreen()));
                      }),
                  ListButton(
                      title: localizations!.language,
                      leadIcon: ProximityIcons.language,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LanguageScreen()));
                      }),
                  Consumer<NotificationService>(
                      builder: (_, notificationService, __) {
                    var nb_notifs = notificationService.notifications
                        .where((element) => element.seendInList != true)
                        .length;
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(children: [
                            if (nb_notifs > 0)
                              Container(
                                  padding: const EdgeInsets.all(tiny_50),
                                  margin:
                                      const EdgeInsets.only(top: 2, left: 30),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(tinyRadius),
                                      color: redSwatch.shade500),
                                  child: Text(
                                    '${nb_notifs}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            color: primaryTextDarkColor,
                                            fontWeight: FontWeight.w800),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ListButton(
                                title: localizations!.notificationsText,
                                leadIcon: ProximityIcons.notifications,
                                onPressed: () {
                                  notificationService.makeItListSeend();
                                  notificationService.getNotifications(context);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const NotificationsPreferencesScreen()));
                                }),
                          ])
                        ]);
                  }),
                  const SizedBox(height: normal_100),
                  SectionDivider(
                      leadIcon: ProximityIcons.info,
                      title: localizations!.about,
                      color: redSwatch.shade400),
                  ListButton(
                      title: localizations!.rateSmartCityText,
                      leadIcon: ProximityIcons.star,
                      onPressed: () {}),
                  ListButton(
                      title: localizations!.contactSupportText,
                      leadIcon: ProximityIcons.support,
                      onPressed: () {}),
                  const Divider(height: normal_200),
                  ListButton(
                      title: localizations!.logoutText,
                      leadIcon: Icons.logout_rounded,
                      onPressed: () {
                        loginValidation.logout(context);
                        /*   Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const OnBoard()),
                            (Route<dynamic> route) => false);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/", (r) => false);*/
                      }),
                  const SizedBox(height: huge_200)
                ]))));
  }
}
