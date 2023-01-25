import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/network/failure.dart';
import 'package:flutter_application_1/data/network/request.dart';
import 'package:flutter_application_1/domain/model/model.dart';
import 'package:flutter_application_1/domain/repository/repository.dart';
import 'package:flutter_application_1/domain/usecases/base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, Register> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Register>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(
        RegisterRequest(input.sign, input.password, input.languageId));
  }
}

class RegisterUseCaseInput {
  String sign;
  String password;
  int languageId;

  RegisterUseCaseInput(this.sign, this.password, this.languageId);
}
