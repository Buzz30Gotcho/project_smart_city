import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_client/domain/user_repository/user_repository.dart';
import 'package:proximity_client/ui/pages/user_pages/widgets/loading_skeletons/account_switcher_skeleton.dart';

class AccountSwitcher extends StatelessWidget {
  const AccountSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(
      builder: (_, userService, __) {
        return userService.user != null
            ? Padding(
                padding: const EdgeInsets.all(normal_100),
                child: Row(children: [
                  // Container(
                  //     height: large_150,
                  //     width: large_150,
                  //     decoration: BoxDecoration(
                  //         borderRadius: const BorderRadius.all(largeRadius),
                  //         border: Border.all(
                  //             color: Theme.of(context).dividerColor,
                  //             width: tiny_50),
                  //         image: DecorationImage(
                  //             image: NetworkImage(
                  //                 userService.user!.profileImage!.first!)))),
                  SizedBox(
                      height: large_150,
                      width: large_150,
                      child: Stack(alignment: Alignment.topRight, children: [
                        Positioned.fill(
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(normalRadius),
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: (userService.user!.profileImage !=
                                                null &&
                                            userService.user!.profileImage!
                                                    .first !=
                                                null)
                                        ? Image.network(userService
                                            .user!.profileImage!.first!)
                                        : Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/5853/5853761.png")))),
                      ])),
                  const SizedBox(width: normal_100),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                        Text(userService.user!.userName!,
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(userService.user!.email!,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)
                      ]))
                ]))
            : const AccountSwitcherSkeleton();
      },
    );
  }
}
