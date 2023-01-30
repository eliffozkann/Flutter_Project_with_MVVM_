import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/domain/usecases/register_usecase.dart';
import 'package:flutter_application_1/presantation/freezed/freezed_data_classes.dart';
import 'package:flutter_application_1/presantation/resources/strings_manager.dart';
import 'package:flutter_application_1/presantation/state_renderer/state_renderer.dart';
import 'package:flutter_application_1/presantation/state_renderer/state_renderer_impl.dart';
import 'package:flutter_application_1/presantation/base/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserRegisterInSuccessfullyStreamController =
      StreamController<bool>();

  var registerViewObject = RegisterObject("", "", 1);

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  @override
  void dispose() {
    _usernameStreamController.close(); //ram de yer kaplamaması için kapatılıyor
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserRegisterInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

//functions

  bool _validateAllInputs() {
    return registerViewObject.username.isNotEmpty &&
        registerViewObject.password.isNotEmpty;
  } //register username ve pasword boş değilse return yap

  _isPasswordValid(String password) {
    return password.length > 3;
  }

  _isUsernameValid(String username) {
    return username.length > 3;
  }

  @override
  register() async {
    //register butonuna basıldığında ekrana loading popupını getiriyoruz.
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));

    //_registerUseCase.girişyap ya da kayıtol fonksiyonları gibi düşünülebilir.
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerViewObject.username,
            registerViewObject.password,
            registerViewObject.languageId)))
        //fold yapısında iki yol var gibi düşünebilirsiniz hatalı olursa (failure) başarılı olursa (data)
        .fold(
            (failure) => {
                  inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE,
                      AppStrings.errorRegister))
                }, (data) {
      inputState.add(LoadingState(
          stateRendererType: StateRendererType.REGISTER_PAGE_CONGRATULATIONS));
      //inputState.add(ContentState());
      //isUserRegisterInSuccessfullyStreamController.add(true);
    });
  }

  @override
  registerError() async {
    inputState.add(ErrorState(
        StateRendererType.REGISTER_PAGE_ERROR, AppStrings.errorRegister));
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerViewObject = registerViewObject.copyWith(password: password);
    } else {
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    if (_isUsernameValid(username)) {
      registerViewObject = registerViewObject.copyWith(username: username);
    } else {
      registerViewObject = registerViewObject.copyWith(username: "");
    }
    _validate();
  }

  _validate() {
    inputAllInputsValid
        .add(null); //her denemeden sonra yeni set leri temizlesin
  }

//inputs

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

//outputs

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordMessage);

  @override
  Stream<String?> get outputErrorUsername => outputIsUsernameValid.map(
      (isUsernameValid) => isUsernameValid ? null : AppStrings.usernameMessage);

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<bool> get outputIsAllValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());
}

abstract class RegisterViewModelInput {
  register();

  //freezed
  setUsername(String username);
  setPassword(String password);

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAllInputsValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUsernameValid;
  Stream<String?> get outputErrorUsername;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsAllValid;
}
