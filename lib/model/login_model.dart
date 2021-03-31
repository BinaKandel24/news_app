import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.token,
    this.error,
  });

  String token;
  String error;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json['token'] != null ? json['token'] : '',
        error: json['error'] != null ? json['error'] : '',
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'error': error,
      };
}

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  LoginRequestModel({
    this.email,
    this.password,
  });

  String email;
  String password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
