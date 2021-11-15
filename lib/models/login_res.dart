import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? result;
  int? status;
  String? message = "";

  LoginResponse({
    this.result,
    this.status,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      result: json["result"], status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() =>
      {"result": result, "status": status, "message": message};
}
