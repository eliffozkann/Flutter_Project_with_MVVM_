import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/network/failure.dart';
import 'package:flutter_application_1/data/network/request.dart';
import 'package:flutter_application_1/domain/model/model.dart';
import 'package:flutter_application_1/domain/repository/repository.dart';
import 'package:flutter_application_1/domain/usecases/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) {
    return _repository.login(LoginRequest(
        input.sign, input.password, input.deviceId, input.userDeviceTypeId));
  }
}

class LoginUseCaseInput {
  String sign;
  String password;
  String deviceId;
  int userDeviceTypeId;

  LoginUseCaseInput(
      this.sign, this.password, this.deviceId, this.userDeviceTypeId);
}
