import 'package:dio/dio.dart';
import 'package:flutter_application_1/app/constant.dart';
import 'package:flutter_application_1/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/account/login")
  Future<AuthenticationResponse> login(@Field("sign") String sign,
      @Field("password") String password, @Field("deviceId") String deviceId);

  @POST("/account/register")
  Future<RegisterResponse> register(@Field("sign") String sign,
      @Field("password") String password, @Field("languageId") int languageId);
}
