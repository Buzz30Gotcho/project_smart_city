import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/user_repository/user_repository.dart';

class AccountSwitcher extends StatelessWidget {
  const AccountSwitcher({Key? key}) : super(key: key);

  Widget _verifiedBadge(BuildContext context, bool isVerified) {
    if (isVerified) {
      return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: small_50, vertical: tiny_50),
        decoration: BoxDecoration(
            color: greenSwatch.shade300,
            borderRadius: const BorderRadius.all(normalRadius),
            border: Border.all(color: greenSwatch.shade200)),
        child: Text("Verified",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: greenSwatch.shade900)),
      );
    } else {
      return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: small_50, vertical: tiny_50),
        decoration: BoxDecoration(
            color: redSwatch.shade400,
            borderRadius: const BorderRadius.all(normalRadius),
            border: Border.all(color: redSwatch.shade200)),
        child: Text("Unverified",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: redSwatch.shade900)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(builder: (_, userService, __) {
      return Padding(
          padding: const EdgeInsets.all(normal_100),
          child: Row(children: [
            //to do : sgam hadii
            /*  Container(
                height: large_150,
                width: large_150,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(largeRadius),
                    border: Border.all(
                        color: Theme.of(context).dividerColor, width: tiny_50),
                    image: ((userService.user == null)
                            ? null
                            : DecorationImage(
                                image: NetworkImage(
                                    userService.user!.profileImage!.first))
                        //     : DecorationImage(
                        // image: (userService.user!.profileImage!.first is File)
                        // ? FileImage(
                        // userService.user!.profileImage!.fibarst)
                        // : NetworkImage(
                        // userService.user!.profileImage!.first))
                        ))),*/

            SizedBox(
                height: large_150,
                width: large_150,
                child: Stack(alignment: Alignment.topRight, children: [
                  Positioned.fill(
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(normalRadius),
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: (userService.user!.profileImage != null &&
                                      userService.user!.profileImage!.first !=
                                          null)
                                  ? Image.network(
                                      userService.user!.profileImage!.first!)
                                  : Image.network(
                                      "https://cdn-icons-png.flaticon.com/512/5853/5853761.png")))),
                ])),
            const SizedBox(width: normal_100),
            Expanded(
                child: (userService.user == null)
                    ? ShimmerFx(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                            Container(
                                color: Theme.of(context).cardColor,
                                child: Text('Oussama, Taleb',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)),
                            Container(
                                color: Theme.of(context).cardColor,
                                child: Text('talebbenkhlouf@gmail.com',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis))
                          ]))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            Text('${userService.user!.userName}, ',
                                style: Theme.of(context).textTheme.subtitle2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Row(
                              children: [
                                Text(userService.user!.email!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(width: small_100),
                                _verifiedBadge(
                                    context, userService.user!.isVerified!)
                              ],
                            )
                          ]))
          ]));
    });
  }
}
