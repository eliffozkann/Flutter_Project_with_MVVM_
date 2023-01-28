import 'dart:async';

import 'package:flutter_application_1/domain/model/slider_object.dart';
import 'package:flutter_application_1/presantation/base/base_viewmodel.dart';
import 'package:flutter_application_1/presantation/resources/assets_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<OnboardingObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToOnboardingView();
  }

  List<SliderObject> _getSliderData() => [
        SliderObject("1. Sayfa", JsonAssets.caravanLoader,
            "Yapacağın tatil için herhangi bir aracın yeterli olduğunu düşünebilirsin. Fakat..."),
        SliderObject("2.Sayfa", JsonAssets.karavan,
            "CaravanApp ile yolları evin haline getirebilir, tatilini en konforlu şekilde geçirebilirsin."),
        SliderObject("3.Sayfa", JsonAssets.welcomeHands,
            "Çeşit çeşit karavanı keşfetmeye hazırsan, CaravanApp'e Hoşgeldin"),
      ];

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToOnboardingView();
  }

  @override
  Stream<OnboardingObject> get outputOnboardingObject =>
      _streamController.stream.map((OnboardingObject) => OnboardingObject);

  @override
  Sink get inputOnboardingObject => _streamController.sink;

  _postDataToOnboardingView() {
    inputOnboardingObject.add(
        OnboardingObject(_currentIndex, _list.length, _list[_currentIndex]));
  }
}

abstract class OnboardingViewModelInputs {
  void onPageChanged(int index);

  Sink get inputOnboardingObject;
}

abstract class OnboardingViewModelOutputs {
  Stream<OnboardingObject> get outputOnboardingObject;
}

class OnboardingObject {
  SliderObject sliderObject;
  int numberOfSlide;
  int currentIndex;

  OnboardingObject(this.currentIndex, this.numberOfSlide, this.sliderObject);
}
