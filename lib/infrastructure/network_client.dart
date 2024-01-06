import 'dart:developer';

import 'package:de_nada/injection_container.dart';
import 'package:dio/dio.dart';


// for making get post delete download etc requests
class NetworkClient {
  final _dio = serviceLocator.get<Dio>();

  Future<Response?> createGetRequest({required url}) async {
    try {
      Response res = await _dio.get(url);
     
      _dio.interceptors.add(LogInterceptor(
        request: true, 
        responseBody: true, 
        logPrint: (object) {
          log("$url ->  $object");
        },
      ));
      if (res.statusCode == 200) {
        return res;
      } else {
        return null;
      }
    } catch (e) {
       print(e);
       
      throw e;
    }
  }
}
