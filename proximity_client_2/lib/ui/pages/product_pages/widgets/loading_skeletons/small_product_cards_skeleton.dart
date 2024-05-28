import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class SmallProductCardsSkeleton extends StatelessWidget {
  const SmallProductCardsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = SizedBox(
        height: huge_100,
        width: huge_300,
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: small_100),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const AspectRatio(aspectRatio: 1, child: SizedBox()),
              const VerticalDivider(width: tiny_50, thickness: tiny_50),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(small_50),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(' ',
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                            const Spacer(),
                            Text(
                              ' ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            )
                          ])))
            ])));
    return ShimmerFx(
        child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: normal_150),
            children: List.generate(4, (i) => card)));
  }
}
