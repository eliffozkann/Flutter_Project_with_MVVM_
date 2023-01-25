import 'dart:developer';

import 'package:flutter_application_1/app/extension.dart';
import 'package:flutter_application_1/data/responses/responses.dart';
import 'package:flutter_application_1/domain/model/model.dart';

extension UserResponseMapper on Data? {
  UserData toDomain() {
    return UserData(this?.id?.orZero() ?? 0, this?.sign?.orEmpty() ?? "",
        this?.token?.orEmpty() ?? "");
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.data?.toDomain());
  }
}

//Register
extension RegisterRResponseMapper on RegisterData? {
  RegisterRData toDomain() {
    return RegisterRData(this?.passwordResetCode?.orEmpty() ?? "");
  }
}

extension RegisterResponseMapper on RegisterResponse? {
  Register toDomain() {
    return Register(this?.data?.toDomain());
  }
}
