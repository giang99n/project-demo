
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:projectbnk/models/login_res.dart';
import 'package:projectbnk/models/signup_res.dart';
import 'package:projectbnk/network/error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_client.dart';

class Api {
  RestClient restClient = RestClient(Dio());

  Future<LoginResponse?> login(String email, String password) async {
    Response response;
    try {
      response = await restClient.post('api/auth/login',
          data: {'username': email, 'password': password});
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print(response.data.toString());
        return LoginResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data.toString());
        if(e.response.statusCode==401){
          final pref = await SharedPreferences.getInstance();
          pref.setString('errorLogin', LoginErrorResponse.fromJson(e.response.data).error.toString()?? "");
        }

      } else {
        print(e.message);
      }
    }
    return null;
  }

  Future<SignupResponse?> Signup(
      String name, String email, String password, String job, String phoneNumber) async {
    Response response;
    try {
      response = await restClient.post('api/user/create',
          data: {
            "name": name,
            "username": email,
            "password": password,
            "job": job,
            "phone": phoneNumber,
            "verify":true,
            "home" : {
              "address":"Tam Giang, Yên Phong, Bắc Ninh",
              "type" : "Point",
              "coordinates" : [
                108.215028,
                16.053509
              ]
            },
            "language": "en"});
      if (response.statusCode == 200) {
        return SignupResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on DioError catch (e) {
      // BaseResponse br = BaseResponse.fromJson(e.response.data);
      return SignupResponse.fromJson(e.response.data);
        // ErrorHandle eh =  ErrorHandle(dioErrorType: e.type, baseResponse: sr );
      // eh.defaultError();
    }
    return null;
  }
}
