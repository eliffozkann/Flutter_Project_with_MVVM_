import 'package:flutter/material.dart';
import 'package:flutter_application_1/presantation/onboarding/onboarding.dart';
import 'package:flutter_application_1/presantation/resources/color_manager.dart';
import 'package:flutter_application_1/presantation/resources/intro_screens/intro_page_1.dart';
import 'package:flutter_application_1/presantation/resources/intro_screens/intro_page_2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _contraller = PageController();
  bool onLastPage = false;
  bool onFirstPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _contraller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 1);
              onFirstPage = (index == 0);
            });
          },
          children: const [IntroPage1(), IntroPage2()],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                onFirstPage
                    ? GestureDetector(onTap: () {}, child: const Text(" "))
                    : GestureDetector(
                        onTap: () {
                          _contraller.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        child: const Text("Back",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15))),
                SmoothPageIndicator(
                    effect: WormEffect(activeDotColor: ColorManager.third),
                    controller: _contraller,
                    count: 2),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const OnBoardingView();
                          }));
                        },
                        child: const Text("Done",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)))
                    : GestureDetector(
                        onTap: () {
                          _contraller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
              ],
            )),
      ],
    ));
  }
}
