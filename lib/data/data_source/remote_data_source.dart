import 'package:flutter_application_1/data/network/app_api.dart';
import 'package:flutter_application_1/data/network/request.dart';
import 'package:flutter_application_1/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<RegisterResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.sign,
        loginRequest.password,
        loginRequest.deviceId,
        loginRequest.userDeviceTypeId);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(registerRequest.sign,
        registerRequest.password, registerRequest.languageId);
  }
}
