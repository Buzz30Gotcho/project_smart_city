import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/ui/pages/pages.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({Key? key, required this.id, this.images})
      : super(key: key);

  final String id;
  final List<dynamic>? images;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? animation;
  int _index = 0;
  final double minScale = 1, maxScale = 4;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _pageController = PageController();
    _transformationController = TransformationController();
    _animationController = AnimationController(
        vsync: this, duration: smallAnimationDuration)
      ..addListener(() => _transformationController.value = animation!.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Padding(
            padding: const EdgeInsets.all(small_100),
            child: Stack(alignment: Alignment.center, children: [
              InteractiveViewer(
                  transformationController: _transformationController,
                  clipBehavior: Clip.none,
                  panEnabled: false,
                  minScale: minScale,
                  maxScale: maxScale,
                  onInteractionEnd: (details) {
                    resetAnimation();
                  },
                  child: AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(smallRadius),
                          child: Container(
                            color: Theme.of(context).cardColor,
                            child: PageView(
                                controller: _pageController,
                                onPageChanged: (index) => setState(() {
                                      _index = index;
                                    }),
                                children: List.generate(
                                    widget.images!.length,
                                    (index) => (widget.images![index] is File)
                                        ? Image.file(widget.images![index],
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter)
                                        : Image.network(widget.images![index],
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                            errorBuilder: (
                                            BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace,
                                          ) {
                                            return const AspectRatio(
                                                aspectRatio: 1.0,
                                                child: SizedBox(
                                                    width: large_100,
                                                    height: large_100));
                                          }))),
                          ))))
            ])),

        /// Top Buttons
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: normal_100, vertical: normal_200),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallIconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      icon: const Icon(ProximityIcons.chevron_left)),
                  SmallIconButton(
                      onPressed: () {
                        ProductDialogs.deleteProduct(context, widget.id);
                      },
                      icon: const Icon(ProximityIcons.more))
                ])),
      ]),
      Padding(
          padding: const EdgeInsets.all(small_100),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  widget.images!.length,
                  (index) => AnimatedContainer(
                      duration: normalAnimationDuration,
                      height: small_100,
                      margin: const EdgeInsets.symmetric(horizontal: tiny_50),
                      width: (_index == index) ? normal_150 : small_100,
                      decoration: BoxDecoration(
                          color: (_index == index)
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).textTheme.bodyText1!.color,
                          borderRadius: const BorderRadius.all(tinyRadius))))))
    ]);
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut));

    _animationController.forward(from: 0);
  }
}
