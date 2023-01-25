// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse()
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?
    ..developerMessage = json['developerMessage'] as String?;
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'developerMessage': instance.developerMessage,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['id'] as int?,
    json['sign'] as String?,
    json['token'] as String?,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'sign': instance.sign,
      'token': instance.token,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
    Map<String, dynamic> json) {
  return AuthenticationResponse(
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?
    ..developerMessage = json['developerMessage'] as String?;
}

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'developerMessage': instance.developerMessage,
      'data': instance.data,
    };

RegisterData _$RegisterDataFromJson(Map<String, dynamic> json) {
  return RegisterData(
    json['passwordResetCode'] as String?,
  );
}

Map<String, dynamic> _$RegisterDataToJson(RegisterData instance) =>
    <String, dynamic>{
      'passwordResetCode': instance.passwordResetCode,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) {
  return RegisterResponse(
    json['data'] == null
        ? null
        : RegisterData.fromJson(json['data'] as Map<String, dynamic>),
  )
    ..exceptions =
        (json['exceptions'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..success = json['success'] as bool?
    ..developerMessage = json['developerMessage'] as String?;
}

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'exceptions': instance.exceptions,
      'success': instance.success,
      'developerMessage': instance.developerMessage,
      'data': instance.data,
    };
