
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
          .post('auths/login', data: {'email': email, 'password': password});
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
      String name, String email, String password, String job, String phoneNumber) async {
    Response response;
    try {
      var formData = FormData.fromMap({
        "name": name,
        "username": email,
        "password": password,
        // "job": job,
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
        "language": "en"
    });
      response = await restClient.post('api/user/create',
          data: formData);
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
