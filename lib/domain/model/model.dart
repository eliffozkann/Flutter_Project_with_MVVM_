class Authentication {
  UserData? userData;

  Authentication(this.userData);
}

class UserData {
  int id;
  String sign;
  String token;

  UserData(this.id, this.sign, this.token);
}

class Register {
  RegisterRData? registerData;

  Register(this.registerData);
}

class RegisterRData {
  String passwordResetCode;

  RegisterRData(this.passwordResetCode);
}
