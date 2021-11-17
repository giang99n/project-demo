
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:projectbnk/models/home_get_post_res.dart';
import 'package:projectbnk/models/infor_res.dart';
import 'package:projectbnk/models/login_res.dart';
import 'package:projectbnk/models/signup_res.dart';
import 'package:projectbnk/models/user_res.dart';
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

  Future<UserResponse?> getUser(String token, String userId) async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.add(PrettyDioLogger());
    Response response;
    try {
      print("token $userId");
      response = await dio.get('https://huntsub.com/api/user/get', queryParameters: {'id':userId});
      if (response.statusCode == 200) {
        print("token $userId");
        return UserResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      print(e);
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
  Future<InforResponse?> getInFor(String token, String userId) async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.add(PrettyDioLogger());
    Response response;
    try {
      response = await dio.get(
          'https://huntsub.com/api/user/info', queryParameters: {'id':userId});
      if (response.statusCode == 200) {
        return InforResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<HomeGetPostResponse?> getListPost(String token) async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.add(PrettyDioLogger());
    Response response;
    try {
      response = await dio.get(
        'https://huntsub.com/api/post/getall',//https://huntsub.com/api/post/getall?skip=1&limit=2&type=&lat=20.9773945&lng=105.7839877&keyword=&
          queryParameters: {'skip': 1,'type':'','lat':20.9773945,'lng':105.7839877,'keyword':'','limit':10,}
      );
      if (response.statusCode == 200) {
        return HomeGetPostResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
