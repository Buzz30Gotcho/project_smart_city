import 'dart:ui';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/l10n/app_localizations.dart';
import 'package:proximity/proximity.dart';

import 'package:proximity_commercant/domain/store_repository/src/store_service.dart';

import 'package:proximity_commercant/domain/user_repository/user_repository.dart';
import 'package:proximity_commercant/ui/pages/home_pages/home_pages.dart';
import 'package:proximity_commercant/ui/pages/order_pages/order_pages.dart';
import 'package:proximity_commercant/ui/pages/store_pages/store_pages.dart';
import 'package:proximity_commercant/ui/pages/store_pages/widgets/loading_skeletons/stores_skeleton.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:flutter/scheduler.dart';
import 'package:proximity_commercant/domain/data_persistence/data_persistence.dart';
import 'package:proximity_commercant/domain/notification_repository/notification_repository.dart';
import 'package:proximity_commercant/ui/pages/user_pages/user_pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ShowCaseWidget(
        builder: Builder(builder: (context) => HomeScreenBody()));
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with TickerProviderStateMixin {
  late AnimationController _drawerAnimation;
  late int _openedSideMenu;
  final GlobalKey _createStoreKey = GlobalKey();
  late UserService _userService;

  void _openSideMenu() {
    setState(() => _openedSideMenu = 1);
    _drawerAnimation.forward();
  }

  @override
  void initState() {
    _openedSideMenu = -1;
    _drawerAnimation =
        AnimationController(vsync: this, duration: normalAnimationDuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeService = Provider.of<StoreService>(context);
    final localizations = AppLocalizations.of(context);
    // storeService.getStores();
    final userService = Provider.of<UserService>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    double _viewPortFraction = (_screenWidth - large_150 * 2) / _screenWidth;
    double _pageWidth = _screenWidth - large_200 * 2;
    double _cardImageWidth = _pageWidth - (normal_100) * 2;
    double _cardImageHeight = _pageWidth * 8 / 11;
    double _cardHeight = _cardImageHeight + tiny_50 * 2 + normal_250;

    try {
      if (!Navigator.canPop(context) &&
          _openedSideMenu == -1 &&
          storeService.stores != null &&
          storeService.stores!.length == 0) {
        SchedulerBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context).startShowCase([_createStoreKey]));
      }
    } catch (e) {}

    return Scaffold(
        body: AnimatedBuilder(
            animation: _drawerAnimation,
            builder: (context, child) {
              int _sign =
                  (Directionality.of(context) == TextDirection.rtl) ? -1 : 1;
              double _maxSlideProfile =
                      MediaQuery.of(context).size.width - large_200 + small_50,
                  _slideProfile = _drawerAnimation.value * _maxSlideProfile;
              double _slideNotifications = _drawerAnimation.value *
                  (MediaQuery.of(context).size.width - huge_200 + tiny_50);

              return Stack(children: [
                /// HomePage
                SafeArea(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child:
                            // hna
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                              /// Top Bar
                              Consumer<UserService>(
                                  builder: (_, userService, __) {
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.all(normal_100),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                (userService.user == null)
                                                    ? ShimmerFx(
                                                        child: Container(
                                                            color: Theme.of(context)
                                                                .cardColor,
                                                            child: Text(
                                                                'User undefined',
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .bodyText2)))
                                                    : userService.user!.address!.city != null &&
                                                            userService
                                                                    .user!
                                                                    .address!
                                                                    .countryName !=
                                                                null
                                                        ? Text('${userService.user!.address!.city}, ${userService.user!.address!.countryName}',
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyText2)
                                                        : InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const EditProfileScreen()));
                                                            },
                                                            child: Text(
                                                                'Set your Address',
                                                                style: Theme.of(context).textTheme.bodyText2)),
                                                const SizedBox(width: small_50),
                                                Icon(Icons.pin_drop_rounded,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    size: normal_100)
                                              ])),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(width: normal_100),
                                            SmallIconButton(
                                                onPressed: _openSideMenu,
                                                icon: const Icon(
                                                    Icons.menu_rounded,
                                                    size: normal_150)),
                                            const SizedBox(width: normal_100),
                                            Expanded(
                                                child: (userService.user ==
                                                        null)
                                                    ? ShimmerFx(
                                                        child: Expanded(
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                            Container(
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor,
                                                                child: Text(
                                                                    localizations!
                                                                        .welcome, // 'Welcome',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .subtitle2)),
                                                            Container(
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor,
                                                                child: Text(
                                                                    "Welcome",
                                                                    //default width name
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .subtitle1))
                                                          ])))
                                                    : RichText(
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        text:
                                                            TextSpan(children: [
                                                          TextSpan(
                                                              text: localizations!
                                                                      .welcome +
                                                                  '\n',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2),
                                                          TextSpan(
                                                              text:
                                                                  '${userService.user!.userName}.',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1)
                                                        ]))),
                                            Consumer<NotificationService>(
                                                builder: (_,
                                                    notificationService, __) {
                                              var nb_notifs =
                                                  notificationService
                                                      .notifications
                                                      .where((element) =>
                                                          element.seendInList !=
                                                          true)
                                                      .length;
                                              return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Stack(children: [
                                                      SmallIconButton(
                                                          onPressed: () {
                                                            notificationService
                                                                .makeItListSeend();
                                                            notificationService
                                                                .getNotifications(
                                                                    context);
                                                            // Navigator.push(
                                                            //     context,
                                                            //     MaterialPageRoute(
                                                            //         builder: (context) =>
                                                            //             const NotificationsPreferencesScreen()));
                                                          },
                                                          icon: const Icon(
                                                              ProximityIcons
                                                                  .notifications)),
                                                      if (nb_notifs > 0)
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .all(
                                                                    tiny_50),
                                                            margin:
                                                                const EdgeInsets.only(
                                                                    top: 0,
                                                                    left: 35),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        tinyRadius),
                                                                color: redSwatch
                                                                    .shade500),
                                                            child: Text(
                                                              '${nb_notifs}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                      color:
                                                                          primaryTextDarkColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )),
                                                      const SizedBox(
                                                          width: normal_100)
                                                    ])
                                                  ]);
                                            }),
                                            const SizedBox(width: normal_100)
                                          ])
                                    ]);
                              }),

                              /// Orders Section

                              Consumer<StoreService>(
                                  builder: (context, storeService, child) {
                                if (storeService.stores == null) {
                                  return SizedBox(
                                      height: _cardHeight,
                                      child: const StoresCardSkeleton());
                                } else {
                                  if (storeService.stores!.length > 0) {
                                    return Column(
                                      children: [
                                        SectionDivider(
                                            leadIcon: ProximityIcons.order,
                                            title: localizations!.orders,
                                            color: redSwatch.shade400,
                                            seeMore: () {}),
                                        const OrdersDashboard(),
                                      ],
                                    );
                                  } else {
                                    return Container(
                                      height: large_200,
                                    );
                                  }
                                }
                              }),

                              /// Stores Section
                              StoresSection(globalKey: _createStoreKey)
                            ]))),

                /// blur background
                (_drawerAnimation.value != 0.0)
                    ? GestureDetector(
                        onTap: () => _drawerAnimation.reverse(),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: small_100 * _drawerAnimation.value,
                                sigmaY: small_100 * _drawerAnimation.value),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                color: Theme.of(context)
                                    .backgroundColor
                                    .withOpacity(_drawerAnimation.value / 3))))
                    : const SizedBox(),

                /// Side Menu (Drawer)
                Transform(
                    transform: Matrix4.identity()
                      ..translate(_sign *
                          (-_maxSlideProfile +
                              _slideProfile * _openedSideMenu)),
                    child:
                        (_drawerAnimation.value != 0.0 && _openedSideMenu > 0)
                            ? const SideMenu()
                            : const SizedBox())
              ]);
            }));
  }
}
