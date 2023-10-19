import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

var client = HttpClient();

class BaseAPI{
    static String token = '1171468886531839488';
    static String base = "http://localhost:8000"; 
    static var api = base + "/api";
    var customersPath = api + "/customers";
    var authPath = api + "/accounts/login"; 
    var logoutPath = api + "/accounts/logout";
    var recordPath = api + '/record';
    var csrfPath = base + '/csrf';
    
   // more routes
   Map<String,String> headers = {                           
       "Content-Type": "application/json; charset=UTF-8" };                                      
              
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

  Future<http.Response> health() async {
    http.Response response =
        await http.post(Uri.parse(BaseAPI.api+'/accounts/apikey'), headers: super.headers);

    return response;
  }

  Future<http.Response> logout(int id, String token) async {
    var body = jsonEncode({'id': id, 'token': token});
    
    http.Response response = await http.post(Uri.parse(super.logoutPath),
        headers: super.headers, body: body);

    return response;
  }



}