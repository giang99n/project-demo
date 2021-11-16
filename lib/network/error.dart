// import 'package:dio/dio.dart';
//
// class ErrorHandle{
//   DioErrorType dioErrorType;
//   BaseResponse baseResponse;
//   ErrorHandle({required this.dioErrorType,required this.baseResponse});
//
//   void defaultError(){
//     if(this.dioErrorType == DioErrorType.CONNECT_TIMEOUT){
//     }
//     else if(this.dioErrorType == DioErrorType.RESPONSE){
//         print(this.baseResponse.status);
//         print(this.baseResponse.error);
//       }
//   }
// }
//
// class BaseResponse{
//   String? error;
//   String? status;
//
//   BaseResponse.fromJson(Map<String, dynamic>json){
//     this.error = json["error"] ?? "";
//     this.status = json['status'] ?? "";
//   }
//
//   Map<String, dynamic> toJson(){
//     Map <String, dynamic> map = {};
//     map['error'] = this.error ?? "";
//     map['status'] = this.status ?? "";
//     return map;
//   }
//
// }