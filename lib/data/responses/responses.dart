import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "exceptions")
  List<String>? exceptions;

  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "developerMessage")
  String? developerMessage;
}

//LOGIN
@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "sign")
  String? sign;
  @JsonKey(name: "token")
  String? token;

  Data(this.id, this.sign, this.token);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "data")
  Data? data;

  AuthenticationResponse(this.data);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

// REGISTER
@JsonSerializable()
class RegisterData {
  @JsonKey(name: "passwordResetCode")
  String? passwordResetCode;

  RegisterData(this.passwordResetCode);

  //from json
  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      _$RegisterDataFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$RegisterDataToJson(this);
}

@JsonSerializable()
class RegisterResponse extends BaseResponse {
  @JsonKey(name: "data")
  RegisterData? data;

  RegisterResponse(this.data);

  //from json
  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
