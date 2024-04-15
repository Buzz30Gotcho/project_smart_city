import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:proximity/proximity.dart';
import 'package:proximity_commercant/domain/data_persistence/src/boxes.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/authentication_pages.dart';
import 'package:proximity_commercant/ui/pages/authentication_pages/view/email_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
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
    var credentialsBox = Boxes.getCredentials();

    credentialsBox.put('first_time', false);

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

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut));

    _animationController.forward(from: 0);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
            child: InteractiveViewer(
              transformationController: _transformationController,
              clipBehavior: Clip.none,
              panEnabled: false,
              minScale: minScale,
              maxScale: maxScale,
              onInteractionEnd: (details) {
                resetAnimation();
              },
              child: PageView.builder(
                  onPageChanged: (index) => setState(() {
                        _index = index;
                        if (index == onboardingData.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        }
                      }),
                  controller: _pageController,
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    return OnBoardingItem(
                        image: onboardingData[index].imagePath,
                        title: onboardingData[index].title,
                        description: onboardingData[index].description);
                  }),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(small_100),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      onboardingData!.length,
                      (index) => AnimatedContainer(
                          duration: normalAnimationDuration,
                          height: small_100,
                          margin:
                              const EdgeInsets.symmetric(horizontal: tiny_50),
                          width: (_index == index) ? normal_150 : small_100,
                          decoration: BoxDecoration(
                              color: (_index == index)
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                              borderRadius:
                                  const BorderRadius.all(tinyRadius)))))),
        ],
      )),
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final String imagePath;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

List<OnboardingContent> onboardingData = [
  OnboardingContent(
    title: "Create and Manage Stores",
    description:
        "Easily create and manage your own stores within the app. Showcase your products and attract customers.",
    imagePath: "assets/store_creation.png",
  ),
  /*OnboardingContent(
    title: "Effortless Product Management",
    description:
        "Add, edit, and organize your products with ease. Provide detailed descriptions and pricing information.",
    imagePath: "assets/images/product.png",
  ),*/
  OnboardingContent(
    title: "Promote Your Products",
    description:
        "Create promotions and discounts to attract more customers. Set promotional prices and limited-time offers.",
    imagePath: "assets/promote.png",
  ),
  OnboardingContent(
    title: "Streamlined Order Management",
    description:
        "Efficiently manage incoming orders, track shipments, and communicate with customers. Provide excellent service.",
    imagePath: "assets/orders.png",
  ),
  OnboardingContent(
    title: "Policy Management",
    description:
        "Set your store policies, such as shipping, returns, and terms of service. Customize policies to fit your needs.",
    imagePath: "assets/policy.png",
  ),
];

class OnBoardingItem extends StatelessWidget {
  OnBoardingItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);
  String image;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Spacer(),
      Image.asset(
        image,
        height: 250,
      ),
      const Spacer(),
      Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: normal_200,
              fontWeight: FontWeight.w600,
            ),
      ),
      const SizedBox(
        height: normal_100,
      ),
      Text(
        description,
        textAlign: TextAlign.center,
      ),
      const Spacer()
    ]);
  }
}
