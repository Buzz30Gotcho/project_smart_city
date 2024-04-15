import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({Key? key, required this.openSideMenu}) : super(key: key);

  final VoidCallback? openSideMenu;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(builder: (_, userService, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.all(normal_100),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (userService.user == null)
                        ? ShimmerFx(
                            child: Container(
                                color: Theme.of(context).cardColor,
                                child: Text('Montpellier, France',
                                    style:
                                        Theme.of(context).textTheme.bodyText2)))
                        : Text(
                            '${userService.user!.address!.city}, ${userService.user!.address!.countryName}',
                            style: Theme.of(context).textTheme.bodyText2),
                    const SizedBox(width: small_50),
                    Icon(Icons.pin_drop_rounded,
                        color: Theme.of(context).primaryColor, size: normal_100)
                  ])),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const SizedBox(width: normal_100),
            SmallIconButton(
                onPressed: openSideMenu,
                icon: const Icon(Icons.menu_rounded, size: normal_150)),
            const SizedBox(width: normal_100),
            Expanded(
              child: (userService.user == null)
                  ? ShimmerFx(
                      child: Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          Container(
                              color: Theme.of(context).cardColor,
                              child: Text('Welcome',
                                  style:
                                      Theme.of(context).textTheme.subtitle2)),
                          Container(
                              color: Theme.of(context).cardColor,
                              child: Text('Abdelmadjid', //default width name
                                  style: Theme.of(context).textTheme.subtitle1))
                        ])))
                  : RichText(
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Welcome\n',
                            style: Theme.of(context).textTheme.subtitle2),
                        TextSpan(
                            text: '${userService.user!.userName}.',
                            style: Theme.of(context).textTheme.subtitle1)
                      ])),
            ),
            SmallIconButton(
                onPressed: () {},
                icon: const Icon(ProximityIcons.notifications)),
            const SizedBox(width: normal_100)
          ]),
        ],
      );
    });
  }
}
