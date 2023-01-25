import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/data_source/remote_data_source.dart';
import 'package:flutter_application_1/data/mapper/mapper.dart';
import 'package:flutter_application_1/data/network/failure.dart';
import 'package:flutter_application_1/data/network/request.dart';
import 'package:flutter_application_1/domain/model/model.dart';
import 'package:flutter_application_1/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    try {
      final response = await _remoteDataSource.login(loginRequest);
      if (response.success == true) {
        //eğer api bize başarı dönüyorsa rightin içine bilgileri atıyoruz
        return Right(response.toDomain());
      } else {
        return Left(Failure(409, response.exceptions?[0] ?? "Hata Oluştu"));
      }
    } catch (error) {
      return Left(Failure(404, "hata"));
    }
  }

  @override
  Future<Either<Failure, Register>> register(
      RegisterRequest registerRequest) async {
    try {
      final response = await _remoteDataSource.register(registerRequest);
      if (response.success == true) {
        return Right(response.toDomain());
      } else {
        return Left(Failure(409, response.exceptions?[0] ?? "Hata Oluştu"));
      }
    } catch (error) {
      return Left(Failure(404, "hata"));
    }
  }
}
