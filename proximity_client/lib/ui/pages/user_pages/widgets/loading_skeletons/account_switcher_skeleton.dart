import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class AccountSwitcherSkeleton extends StatelessWidget {
  const AccountSwitcherSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(normal_100),
        child: ShimmerFx(
          child: Row(children: [
            Container(
                height: large_150,
                width: large_150,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.all(largeRadius),
                    border: Border.all(
                        color: Theme.of(context).dividerColor, width: tiny_50))),
            const SizedBox(width: normal_100),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      color: Theme.of(context).cardColor,
                      width: huge_200,
                      child: Text(' ',
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)),
                  Container(
                      color: Theme.of(context).cardColor,
                      width: huge_100,
                      child: Text(' ',
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis))
                ]))
          ]),
        ));
  }
}
