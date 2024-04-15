import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class AdSection extends StatefulWidget {
  const AdSection({Key? key, required this.ads}) : super(key: key);

  final List<String> ads;

  @override
  State<AdSection> createState() => _AdSectionState();
}

class _AdSectionState extends State<AdSection> {
  PageController _pageController = PageController();
  int _index = 0;

  void _nextAd() {
    Future.delayed(hugeAnimationDuration).then(
          (_) {
        int nextPage = _pageController.page!.round() + 1;

        if (nextPage == widget.ads.length) {
          nextPage = 0;
        }
        _pageController
            .animateToPage(nextPage,
            duration: normalAnimationDuration, curve: Curves.linear)
            .then(
              (_) => _nextAd(),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _index = 0;
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _nextAd());
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(small_100),
        child: Column(children: [
          AspectRatio(
              aspectRatio: 2.5,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(tinyRadius),
                  child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) => setState(() {
                            _index = index;
                          }),
                      children: List.generate(
                          widget.ads.length,
                          (index) => Image.asset(widget.ads[index],
                              fit: BoxFit.cover))))),
          const SizedBox(height: small_100),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedContainer(
                duration: normalAnimationDuration,
                height: small_100,
                width: (_index == 0) ? normal_150 : small_100,
                decoration: BoxDecoration(
                    color: (_index == 0)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                    borderRadius: const BorderRadius.all(tinyRadius))),
            const SizedBox(width: small_50),
            AnimatedContainer(
                duration: normalAnimationDuration,
                height: small_100,
                width: (_index == 1) ? normal_150 : small_100,
                decoration: BoxDecoration(
                    color: (_index == 1)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                    borderRadius: const BorderRadius.all(tinyRadius))),
            const SizedBox(width: small_50),
            AnimatedContainer(
                duration: normalAnimationDuration,
                height: small_100,
                width: (_index == 2) ? normal_150 : small_100,
                decoration: BoxDecoration(
                    color: (_index == 2)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                    borderRadius: const BorderRadius.all(tinyRadius))),
            const SizedBox(width: small_50),
            AnimatedContainer(
                duration: normalAnimationDuration,
                height: small_100,
                width: (_index == 3) ? normal_150 : small_100,
                decoration: BoxDecoration(
                    color: (_index == 3)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                    borderRadius: const BorderRadius.all(tinyRadius))),
            const SizedBox(width: small_50),
            AnimatedContainer(
                duration: normalAnimationDuration,
                height: small_100,
                width: (_index == 4) ? normal_150 : small_100,
                decoration: BoxDecoration(
                    color: (_index == 4)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyLarge!.color,
                    borderRadius: const BorderRadius.all(tinyRadius)))
          ])
        ]));
  }
}
