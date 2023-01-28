import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presantation/resources/assets_manager.dart';
import 'package:flutter_application_1/presantation/resources/color_manager.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorManager.primary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Bütün karavan servislerine ulaşabileceğiniz, Servis hizmeti alabileceğiniz, Aldığınız hizmetlerin takibini sağlayabileceğiniz",
                  style: TextStyle(fontSize: 18),
                ),
                Lottie.asset(JsonAssets.karavan),
              ],
            ),
          ),
        ));
  }
}
