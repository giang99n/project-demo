import 'dart:convert';

SignupResponse SignupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String SignupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  Result? result;
  int? status;
  int? code;
  String? message;

  SignupResponse({this.result, this.status, this.code, this.message});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    status = json['status'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class Result {
  String? id;
  String? createdAt;
  String? email;
  String? name;
  String? updatedAt;

  Result({this.id, this.createdAt, this.email, this.name, this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    email = json['email'];
    name = json['name'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['email'] = this.email;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

// class SignupResponse {
//   String? result;
//   int? status;
// //  String message;
//
//   SignupResponse({required this.result, required this.status});
//
//   SignupResponse.fromJson(Map<String, dynamic> json) {
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
