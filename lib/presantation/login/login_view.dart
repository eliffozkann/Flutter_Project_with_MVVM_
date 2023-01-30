import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/app/di.dart';
import 'package:flutter_application_1/domain/home/main_page.dart';
import 'package:flutter_application_1/presantation/onboarding/onboarding.dart';
import 'package:flutter_application_1/onboarding2/onboarding_screen.dart';
import 'package:flutter_application_1/presantation/register/register_view.dart';
import 'package:flutter_application_1/presantation/resources/color_manager.dart';
import 'package:flutter_application_1/presantation/resources/strings_manager.dart';
import 'package:flutter_application_1/presantation/state_renderer/state_renderer_impl.dart';
import 'package:flutter_application_1/presantation/login/login_viewmodel.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final StreamController<bool> _passwordVisibilityStreamController =
      StreamController<bool>.broadcast();

  //Burası kullanıcıyla buluştuğumuz ilk ekran burda sadece tasarım kodları var !
  //fonksiyonlarımızı kullanmak için viewmodeldan bir instance alıyoruz çünkü bütün fonksiyonlarımız viewmodelda

  _bind() {
    _usernameTextEditingController.addListener(() {
      _viewModel.setUsername(_usernameTextEditingController.text);
    });

    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });

    _viewModel.isUserLoginInSuccessfullyStreamController.stream
        .listen((girisYapabilirmi) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (girisYapabilirmi == true) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MainPage()));
        }
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _passwordTextEditingController.dispose();
    _usernameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentWidget(), () {}) ??
                _getContentWidget();
          },
        ),
      )),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Form(
          child: IntrinsicHeight(
            child: Column(
              children: [
                const Spacer(),
                Lottie.asset("assets/json_assets/hosgeldin.json", height: 250),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.loginScreen,
                        style: TextStyle(
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: StreamBuilder<String?>(
                          stream: _viewModel.outputErrorUsername,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: _usernameTextEditingController,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.account_circle_outlined,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  labelText: AppStrings.username,
                                  hintText: AppStrings.username,
                                  errorText: snapshot.data),
                            );
                          }),
                    )),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: StreamBuilder<String?>(
                          stream: _viewModel.outputErrorPassword,
                          builder: (context, snapshot) {
                            return StreamBuilder<bool>(
                                initialData: true,
                                stream:
                                    _passwordVisibilityStreamController.stream,
                                builder: (context, visibility) {
                                  return TextFormField(
                                    obscureText: visibility.data!,
                                    controller: _passwordTextEditingController,
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.lock_outline,
                                            color: ColorManager.kPrimaryColor,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                              visibility.data == false
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color:
                                                  ColorManager.kPrimaryColor),
                                          onPressed: () {
                                            _passwordVisibilityStreamController
                                                .sink
                                                .add(!visibility.data!);
                                          },
                                        ),
                                        hintText: AppStrings.password,
                                        labelText: AppStrings.password,
                                        errorText: snapshot.data),
                                  );
                                });
                          }),
                    )),
                Expanded(
                    flex: 2,
                    child: ElevatedButton(
                        onPressed: () {
                          _viewModel.login();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: ColorManager.kPrimaryColor,
                        ),
                        child: const Text(AppStrings.login))),
                Expanded(
                  flex: 3,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterView()));
                      },
                      child: Text(
                        AppStrings.registerText,
                        style: TextStyle(color: ColorManager.kPrimaryColor),
                      )),
                ),
                // Expanded(
                //   flex: 3,
                //   child: TextButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => OnBoardingView()));
                //       },
                //       child: Text(
                //         "On Boarding",
                //         style: TextStyle(color: ColorManager.kPrimaryColor),
                //       )),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
