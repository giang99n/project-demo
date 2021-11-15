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

// class LoginResponse {
//   String? result;
//   int? status;
// //  String message;
//
//   LoginResponse({required this.result, required this.status});
//
//   LoginResponse.fromJson(Map<String, dynamic> json) {
//     result = json['result'].toString();
//     status = json['status'];
//     //  message = json['message'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['result'] = this.result;
//     data['status'] = this.status;
//     // data['message'] = this.message;
//     return data;
//   }
// }
