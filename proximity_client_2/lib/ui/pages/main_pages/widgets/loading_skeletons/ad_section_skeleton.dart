import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class AdSectionSkeleton extends StatelessWidget {
  const AdSectionSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(small_100),
        child: Column(children: [
          ShimmerFx(
              child: AspectRatio(
                  aspectRatio: 2.5,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          borderRadius: const BorderRadius.all(tinyRadius))))),
          const SizedBox(height: small_100),
          Container(
              height: small_100,
              width: small_100,
              decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  borderRadius: const BorderRadius.all(tinyRadius)))
        ]));
  }
}
