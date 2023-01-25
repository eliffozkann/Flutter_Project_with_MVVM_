import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app_prefs.dart';
import 'package:flutter_application_1/app/di.dart';
import 'package:flutter_application_1/presantation/resources/color_manager.dart';
import 'package:flutter_application_1/presantation/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  await initLoginModule();
  await initRegisterModule();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppPreferences _appPrefs = instance<AppPreferences>();

    late bool deger;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: ColorManager.primary),
          primarySwatch: Colors.blue,
        ),
        //home: Scaffold(body: Loginpage()));
        home: const Scaffold(body: SplashView()));
  }
}
