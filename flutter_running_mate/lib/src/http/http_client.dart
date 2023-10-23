import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;

var client = HttpClient();

class BaseAPI{
    static String access = '';
    static String refresh = '';
    static String base = "http://localhost:8000"; 
    static var api = base + "/api";
    var customersPath = api + "/customers";
    var authPath = api + "/user/login/"; 
    var refreshPath = api + "/user/token/refresh/"; 
    var recordPath = api + '/record';
    var csrfPath = base + '/csrf';
    
   // more routes
   Map<String,String> headers = {                           
    "Content-Type": "application/json; charset=UTF-8",
    // "Authorization": "Bearer " + access
   };                                      
   
}

class AuthAPI extends BaseAPI {
  Future<http.Response> signUp(String name, String email, String phone,
      String password, String passwordConfirmation) async {
    var body = jsonEncode({
      'customer': {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation
      }
    });

    http.Response response =
        await http.post(super.customersPath as Uri, headers: super.headers, body: body);
    return response;
  }

  Future<http.Response> login(String? email, String? password) async {
    var body = jsonEncode({'email': email, 'password': password});
    
    http.Response response =
        await http.post(Uri.parse(super.authPath), headers: super.headers, body: body);

    return response;
  }

  Void? logout() {
    BaseAPI.access = '';
    BaseAPI.refresh = '';

    
    return null;
  }

  Future<http.Response> getTokenRefresh() async {
    var body = jsonEncode({'refresh': BaseAPI.refresh});
    
    http.Response response = await http.post(Uri.parse(super.refreshPath),
        headers: super.headers, body: body);

    return response;
  }

  Future<http.Response> verifyToken() async {
    var body = jsonEncode({'token': BaseAPI.access});
    
    http.Response response = await http.post(Uri.parse(super.refreshPath),
        headers: super.headers, body: body);

    return response;
  }

}