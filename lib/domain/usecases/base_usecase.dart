import 'package:dartz/dartz.dart';
import 'package:flutter_application_1/data/network/failure.dart';

//base lerin hepsi abstract oluyor çünkü diğer class larda kullanacak

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
