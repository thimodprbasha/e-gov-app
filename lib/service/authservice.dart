import 'package:http/http.dart';
import 'package:e_gov/model/user.dart';
import 'dart:convert';
import 'package:e_gov/env/env.dart';


class AuthenticationService {
  Future<Response> userAuthenticateService(String reqUsername , String reqPassword) async{

    Uri url = Uri.parse(URL_LOGIN);

    Map<String,String> body = {
      "email" : reqUsername,
      "password" : reqPassword,
    };
    var userBody = json.encode(body);

    Response response = await post(url , body: userBody , headers: {"Content-Type": "application/json"});
    return response;
  }

  Future<Response> createUser(User user) async{
    Uri url = Uri.parse(URL_REGISTER);

    String userJson = user.toJson();

    Response response = await post(url , body: userJson , headers: {"Content-Type": "application/json"});
    // if (response.statusCode == 200) {
    //   return "ok";
    // } else {
    //   return response.body;
    // }
     return response;
  }
}