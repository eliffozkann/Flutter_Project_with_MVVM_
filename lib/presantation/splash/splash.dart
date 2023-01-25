import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app_prefs.dart';
import 'package:flutter_application_1/app/di.dart';
import 'package:flutter_application_1/presantation/login/login_view.dart';
import 'package:flutter_application_1/presantation/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AppPreferences _appPreferences = instance<AppPreferences>();

  _goNext() async {
    _appPreferences.isOnboardingScreenViewed().then((value) => {
          if (value)
            {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginView()))
            }
          else
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => OnBoardingView()))
            }
        });
  }

  @override
  void initState() {
    _goNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
