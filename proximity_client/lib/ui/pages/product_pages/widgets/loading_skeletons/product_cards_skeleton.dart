import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class ProductCardsSkeleton extends StatelessWidget {
  const ProductCardsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Card card = Card(
        margin: const EdgeInsets.symmetric(horizontal: small_100)
            .copyWith(bottom: normal_100),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AspectRatio(aspectRatio: 1, child: SizedBox()),
              const Divider(height: tiny_50, thickness: tiny_50),
              Padding(
                  padding: const EdgeInsets.all(small_50),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Text(' ',
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: small_50),
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: ' ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold))
                            ]),
                            overflow: TextOverflow.fade)
                      ]))
            ]));
    return ShimmerFx(
        child: MasonryGrid(
            column: 2,
            padding: const EdgeInsets.symmetric(horizontal: small_100),
            children: List.generate(6, (i) => card)));
  }
}
