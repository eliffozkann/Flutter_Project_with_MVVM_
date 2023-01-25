import 'package:flutter_application_1/app/app_prefs.dart';
import 'package:flutter_application_1/data/data_source/remote_data_source.dart';
import 'package:flutter_application_1/data/network/app_api.dart';
import 'package:flutter_application_1/data/network/dio_factory.dart';
import 'package:flutter_application_1/data/network/repository/repository_impl.dart';
import 'package:flutter_application_1/domain/repository/repository.dart';
import 'package:flutter_application_1/domain/usecases/login_usecase.dart';
import 'package:flutter_application_1/domain/usecases/register_usecase.dart';
import 'package:flutter_application_1/presantation/login/login_viewmodel.dart';
import 'package:flutter_application_1/presantation/register/register_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.asNewInstance();

Future<void> initAppModule() async {
  //SHARED PREFS
  final sharedPref = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  //APP PREFS
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  final dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
}

//login
initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

//register
initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
  }
}
