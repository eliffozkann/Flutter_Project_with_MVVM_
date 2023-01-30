import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app_prefs.dart';
import 'package:flutter_application_1/app/di.dart';
import 'package:flutter_application_1/presantation/login/login_view.dart';
import 'package:flutter_application_1/presantation/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_application_1/presantation/resources/color_manager.dart';
import 'package:flutter_application_1/presantation/resources/strings_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  bool onLastPage = false;
  bool onFirstPage = false;

  PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel _viewModel = OnBoardingViewModel();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _appPreferences.setOnboardingScreenViewed();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.SecondaryColor,
        body: StreamBuilder<OnboardingObject>(
          stream: _viewModel.outputOnboardingObject,
          builder: (context, snapshot) {
            return _getContentWidget(snapshot.data);
          },
        ));
  }

  Widget _getContentWidget(OnboardingObject? onboardingObject) {
    if (onboardingObject == null) {
      return const SizedBox.shrink();
    } else {
      return Scaffold(
          backgroundColor: ColorManager.SecondaryColor,
          body: SafeArea(
            child: PageView.builder(
              itemCount: onboardingObject.numberOfSlide,
              controller: _pageController,
              onPageChanged: (value) async {
                onLastPage = (value == 2);
                onFirstPage = (value == 1 || value == 2);
                const Duration(milliseconds: 0);
                _viewModel.onPageChanged(value);
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Lottie.asset(
                          onboardingObject.sliderObject.imageUrl,
                          width: MediaQuery.of(context).size.width / 1.15,
                          height: MediaQuery.of(context).size.height / 2.5,
                        )),
                    Expanded(
                        flex: 2,
                        child: Text(
                          textAlign: TextAlign.center,
                          onboardingObject.sliderObject.subtitle,
                          style: GoogleFonts.roboto(
                            textStyle:
                                Theme.of(context).textTheme.headlineSmall,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          onFirstPage
                              ? GestureDetector(
                                  onTap: () {
                                    _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  },
                                  child: const Text(AppStrings.back,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)))
                              : const Text(" "),
                          SmoothPageIndicator(
                              effect: WormEffect(
                                  activeDotColor: ColorManager.kPrimaryColor),
                              controller: _pageController,
                              count: 3),
                          onLastPage
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const LoginView();
                                    }));
                                  },
                                  child: const Text(AppStrings.getStart,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)))
                              : GestureDetector(
                                  onTap: () {
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  },
                                  child: const Text(
                                    AppStrings.next,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ));
    }
  }
}
