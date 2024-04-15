import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class StoresCardSkeleton extends StatelessWidget {
  const StoresCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// calculate card height to avoid PageView overflow
    double _screenWidth = MediaQuery.of(context).size.width;
    double _viewPortFraction = (_screenWidth - large_150 * 2) / _screenWidth;
    double _pageWidth = _screenWidth - large_200 * 2;
    double _cardImageWidth = _pageWidth - (normal_100) * 2;
    double _cardImageHeight = _pageWidth * 8 / 11;
    double _cardHeight = _cardImageHeight + tiny_50 * 2 + normal_250;

    return ShimmerFx(
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: normal_100 + large_150),
            child: SizedBox(height: _cardHeight)));
  }
}
