
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:projectbnk/models/login_res.dart';
import 'package:projectbnk/models/signup_res.dart';

import 'dio_client.dart';

class Api {
  RestClient restClient = RestClient(Dio());

  Future<LoginResponse?> login(String email, String password) async {
    Response response;
    try {
      response = await restClient
          .post('api/auth/login', data: {'username': email, 'password': password});
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<SignupResponse?> Signup(
      String name, String email, String password) async {
    Response response;
    try {
      response = await restClient.post('auths/register',
          data: {'name': name, 'email': email, 'password': password});
      if (response.statusCode == 200) {
        return SignupResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

}
