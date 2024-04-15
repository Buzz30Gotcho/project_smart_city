import 'package:flutter/material.dart';
import 'package:proximity/proximity.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({Key? key}) : super(key: key);

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  PageController _pageController = PageController();
  int _index = 0;
  final List<List<String>> _pages = [
    [
      'assets/img/illustration-1.png',
      'GET YOUR\nPRODUCTS\nDELIVERED!',
      'Explore the most recent and\nthe greatest deals around you.'
    ],
    [
      'assets/img/illustration-2.png',
      'BEST\nSERVICES\nAROUND YOU!',
      'Explore the most recent and\nthe greatest services around you.'
    ],
    [
      'assets/img/illustration-3.png',
      'START\nNOW!',
      'Explore the most recent and\nthe greatest deals around you.'
    ]
  ];

  void _leftClick() => setState(() {
        if (_index > 0) {
          _index--;
          _pageController.previousPage(
              duration: normalAnimationDuration, curve: Curves.easeInOut);
        }
      });

  void _rightClick() => setState(() {
        if (_index < _pages.length - 1) {
          _index++;
          _pageController.nextPage(
              duration: normalAnimationDuration, curve: Curves.easeInOut);
        }
      });

  @override
  void initState() {
    super.initState();
    _index = 0;
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(small_100),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(smallRadius),
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) => setState(() {
                        _index = index;
                      }),
                      children: [
                        Image.asset(_pages[0][0],
                            fit: BoxFit.cover, alignment: Alignment.topCenter),
                        Image.asset(_pages[1][0],
                            fit: BoxFit.cover, alignment: Alignment.topCenter),
                        Image.asset(_pages[2][0],
                            fit: BoxFit.cover, alignment: Alignment.topCenter),
                      ],
                    ),
                  )),
              if (_index != 0)
                Positioned(
                    left: small_100,
                    child: OutlinedButton(
                        key: GlobalKey(debugLabel: 'leftButton'),
                        onPressed: _leftClick,
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            side: BorderSide(
                              color:
                                  scaffoldBackgroundLightColor.withOpacity(0.3),
                              width: tiny_50,
                            ),
                            backgroundColor:
                                scaffoldBackgroundLightColor.withOpacity(0.3),
                            minimumSize: const Size(large_150, large_150)),
                        child: const Icon(ProximityIcons.chevron_left,
                            color: scaffoldBackgroundLightColor))),
              if (_index != _pages.length - 1)
                Positioned(
                    right: small_100,
                    child: OutlinedButton(
                        key: GlobalKey(debugLabel: 'rightButton'),
                        onPressed: _rightClick,
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            side: BorderSide(
                              color:
                                  scaffoldBackgroundLightColor.withOpacity(0.3),
                              width: tiny_50,
                            ),
                            backgroundColor:
                                scaffoldBackgroundLightColor.withOpacity(0.3),
                            minimumSize: const Size(large_150, large_150)),
                        child: const Icon(ProximityIcons.chevron_right,
                            color: scaffoldBackgroundLightColor))),
              Positioned(
                  bottom: small_100,
                  left: small_100,
                  child: Stack(children: [
                    Text(_pages[_index][1],
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w900,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = tiny_50
                              ..color =
                                  primaryTextLightColor.withOpacity(0.6))),
                    Text(_pages[_index][1],
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: primaryTextDarkColor,
                            fontWeight: FontWeight.w900))
                  ]))
            ],
          )),
      Padding(
          padding: const EdgeInsets.all(small_100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          )),
      Padding(
        padding: const EdgeInsets.all(small_100),
        child: Text(_pages[_index][2],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge),
      ),
    ]);
  }
}
