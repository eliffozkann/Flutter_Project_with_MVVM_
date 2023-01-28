import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/presantation/resources/assets_manager.dart';
import 'package:flutter_application_1/presantation/resources/color_manager.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorManager.primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "KaravApp'e Hoşgeldin",
                style: TextStyle(fontSize: 35),
              ),
              Lottie.asset(JsonAssets.welcomeHands),
            ],
          ),
        ));
  }
}
