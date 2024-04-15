import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFx extends StatelessWidget {
  const ShimmerFx({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).cardColor,
        highlightColor: Theme.of(context).dividerColor,
        child: child);
  }
}