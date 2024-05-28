import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class WorkingTimeSkeleton extends StatelessWidget {
  const WorkingTimeSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerFx(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: small_100),
          child: Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      color: Theme.of(context).cardColor,
                      child: Text('Store Name Example.',
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start)),
                  const StarRating(rating: 5.0)
                ])),
            TertiaryButton(
                buttonState: ButtonState.disabled,
                title: 'Go to Store.',
                onPressed: null)
          ])),
      const SizedBox(height: small_100),
      const Card(
          margin: EdgeInsets.symmetric(horizontal: normal_100),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: dividerDarkColor, width: tiny_50),
              borderRadius: BorderRadius.all(smallRadius)),
          child: SizedBox(height: huge_300, width: double.infinity))
    ]));
  }
}
