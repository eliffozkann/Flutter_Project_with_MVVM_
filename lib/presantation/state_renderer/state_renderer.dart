import 'package:flutter/material.dart';
import 'package:flutter_application_1/presantation/login/login_view.dart';
import 'package:flutter_application_1/presantation/register/register_view.dart';
import 'package:flutter_application_1/presantation/resources/assets_manager.dart';
import 'package:flutter_application_1/presantation/resources/color_manager.dart';
import 'package:flutter_application_1/presantation/resources/strings_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,

  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE,

  REGISTER_PAGE_CONGRATULATIONS,
  REGISTER_PAGE_ERROR,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryFunction;

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      String? message,
      String? title,
      required this.retryFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(context, [
          _getText(AppStrings.loading, context),
          _getAnimatedErrorLottie(JsonAssets.loading, context)
        ]);

      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getText(AppStrings.error, context),
          _getAnimatedErrorLottie(JsonAssets.error, context)
        ]);

      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsFullScreen([
          _getText(AppStrings.loading, context),
          _getAnimatedLoadingLottie(JsonAssets.fullPageLoading, context)
        ], context);

      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsFullScreen([
          _getText(AppStrings.error, context),
          _getAnimatedErrorLottie(JsonAssets.error, context)
        ], context);

      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();

      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsFullScreen([
          _getText(AppStrings.notfound, context),
          _getAnimatedErrorLottie(JsonAssets.notFound, context)
        ], context);

      case StateRendererType.REGISTER_PAGE_CONGRATULATIONS:
        return _getPopUpDialog(context, [
          _getText(AppStrings.succesfulRegister, context),
          _getAnimatedErrorLottie(
              JsonAssets.registerPageCongratulation, context),
          _getButton(AppStrings.login, LoginView(), context)
        ]);

      case StateRendererType.REGISTER_PAGE_ERROR:
        return _getPopUpDialog(context, [
          _getText(AppStrings.registerPasswordError, context),
          _getAnimatedErrorLottie(JsonAssets.registerPageWrong, context),
        ]);

      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54, blurRadius: 12, offset: Offset(0, 12)),
            ],
            borderRadius: BorderRadius.circular(12)),
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.2,
        child: _getDialogContent(context, children),
      ),
    );
  }

  _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(children: children);
  }

  Widget _getAnimatedLoadingLottie(String animationName, BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.2,
        child: Lottie.asset(
          animationName,
        ),
      ),
    );
  }

  Widget _getAnimatedErrorLottie(String animationName, BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Lottie.asset(
          animationName,
        ),
      ),
    );
  }

  Widget _getText(String message, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: ColorManager.kPrimaryColor, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  _getItemsFullScreen(List<Widget> children, BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: _getDialogContent(context, children),
        ),
      ),
    );
  }

  Widget _getButton(text, where, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => where));
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: ColorManager.kPrimaryColor,
          ),
          child: Text(text)),
    );
  }
}
