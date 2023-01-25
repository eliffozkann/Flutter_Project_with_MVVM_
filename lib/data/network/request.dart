class LoginRequest {
  //istek atma gibi
  String sign;
  String password;
  String deviceId;

  LoginRequest(this.password, this.sign, this.deviceId);
}

class RegisterRequest {
  String sign;
  String password;
  int languageId;

  RegisterRequest(this.sign, this.password, this.languageId);
}
