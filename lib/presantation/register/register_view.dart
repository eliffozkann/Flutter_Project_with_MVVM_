import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/app/di.dart';
import 'package:flutter_application_1/domain/home/main_page.dart';
import 'package:flutter_application_1/presantation/login/login_view.dart';
import 'package:flutter_application_1/presantation/register/register_viewmodel.dart';
import 'package:flutter_application_1/presantation/resources/color_manager.dart';
import 'package:flutter_application_1/presantation/state_renderer/state_renderer.dart';
import 'package:flutter_application_1/presantation/state_renderer/state_renderer_impl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingControllerAgain =
      TextEditingController();
  final StreamController<bool> _passwordVisibilityStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _passwordVisibilityStreamControllerAgain =
      StreamController<bool>.broadcast();

  _bind() {
    _usernameTextEditingController.addListener(() {
      _viewModel.setUsername(_usernameTextEditingController.text);
    });

    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });
    _passwordTextEditingControllerAgain.addListener(() {
      _viewModel.setPassword(_passwordTextEditingControllerAgain.text);
    });

    _viewModel.isUserRegisterInSuccessfullyStreamController.stream
        .listen((girisYapabilirmi) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (girisYapabilirmi == true) {
          //_viewModel.registerCongratulations();
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
    _passwordTextEditingControllerAgain.dispose();
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: ColorManager.kPrimaryColor,
                          size: 50,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                      ),
                    ],
                  ),
                  const Spacer(flex: 5),
                  Text(
                    "Yeni Kullanıcı",
                    style: TextStyle(
                        color: ColorManager.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
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
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    labelText: "Kullanıcı Adı",
                                    hintText: "Kullanıcı Adı",
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
                                  stream: _passwordVisibilityStreamController
                                      .stream,
                                  builder: (context, visibility) {
                                    return TextFormField(
                                      obscureText: visibility.data!,
                                      controller:
                                          _passwordTextEditingController,
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
                                          hintText: "Şifre",
                                          labelText: "Şifre",
                                          errorText: snapshot.data),
                                    );
                                  });
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
                                      _passwordVisibilityStreamControllerAgain
                                          .stream,
                                  builder: (context, visibility) {
                                    return TextFormField(
                                      obscureText: visibility.data!,
                                      controller:
                                          _passwordTextEditingControllerAgain,
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
                                              _passwordVisibilityStreamControllerAgain
                                                  .sink
                                                  .add(!visibility.data!);
                                            },
                                          ),
                                          hintText: "Şifreyi tekrar girin",
                                          labelText: "Şifreyi tekrar girin",
                                          errorText: snapshot.data),
                                    );
                                  });
                            }),
                      )),
                  Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: ColorManager.kPrimaryColor,
                          ),
                          onPressed: () {
                            if (_passwordTextEditingController.text ==
                                _passwordTextEditingControllerAgain.text) {
                              _viewModel.register();
                              print("KAYIT BAŞARILI");
                            } else {
                              _viewModel.registerError();
                              print("başarılı değil");
                              print(_passwordTextEditingController.text);
                              print(_passwordTextEditingControllerAgain.text);
                            }
                          },
                          child: const Text("Kayıt Ol"))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
