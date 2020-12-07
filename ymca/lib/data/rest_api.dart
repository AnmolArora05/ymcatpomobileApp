import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;


class RestDataSource {

  Future<dynamic> post(String url, {Map headers, body, encoding})
  {
    final JsonDecoder _decoder = new JsonDecoder();
    print(body);
    return http
        .post(url, body: body, headers:{"Content-Type": "application/json"}, encoding: encoding)
        .then((http.Response response)
    {
      final String res = response.body;
      final int statusCode = response.statusCode;

        if (statusCode > 400) {

        }
      return json.decode(response.body);
    });
  }
  Future<dynamic> get(String url, {Map headers})
  {
    final JsonDecoder _decoder = new JsonDecoder();
    return http
        .get(url,headers:{"Content-Type": "application/json"})
        .then((http.Response response)
    {
      final String res = response.body;
      final int statusCode = response.statusCode;

//        if (statusCode < 200 || statusCode > 400 || json == null) {
//            throw new Exception("Error while fetching data");
//        }
      return json.decode(response.body);
    });
  }
  Future<dynamic> delete(String url, {Map headers})
  {
    final JsonDecoder _decoder = new JsonDecoder();
    return http
        .delete(url,headers:{"Content-Type": "application/json"})
        .then((http.Response response)
    {
      final String res = response.body;
      final int statusCode = response.statusCode;

//        if (statusCode < 200 || statusCode > 400 || json == null) {
//            throw new Exception("Error while fetching data");
//        }
      return json.decode(response.body);
    });
  }

  Future<dynamic> put(String url, {Map headers , body})
  {
    print(body);
    final JsonDecoder _decoder = new JsonDecoder();
    return http
        .put(url,body: body,headers:{"Content-Type": "application/json"})
        .then((http.Response response)
    {
      final String res = response.body;
      final int statusCode = response.statusCode;

//        if (statusCode < 200 || statusCode > 400 || json == null) {
//            throw new Exception("Error while fetching data");
//        }
      return json.decode(response.body);
    });
  }
}