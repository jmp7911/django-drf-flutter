import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_running_mate/src/http/http_client.dart';
import 'package:flutter_running_mate/src/model/customer.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_running_mate/src/router/router.dart';

part 'login.g.dart';


@JsonSerializable()
class FormData {
  String? email;
  String? password;

  FormData({
    this.email,
    this.password,
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}

class SignInHttpDemo extends StatefulWidget {
  final HttpClient? httpClient;

  const SignInHttpDemo({
    this.httpClient,
    super.key,
  });

  @override
  State<SignInHttpDemo> createState() => _SignInHttpDemoState();
}

class _SignInHttpDemoState extends State<SignInHttpDemo> {
  FormData formData = FormData();
  AuthAPI _authAPI = AuthAPI();
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in Form'),
      ),
      body: Form(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...[
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'Your email address',
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      formData.email = value;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      formData.password = value;
                    },
                  ),
                  TextButton(
                    child: const Text('Sign in'),
                    onPressed: () async {
                      try{
                          // var req = await _authAPI.health();
                          var req = await _authAPI.login(formData.email,  formData.password);
                          if(req.statusCode == 200){
                            Map<String, dynamic> json = jsonDecode(req.body);
                            BaseAPI.access = json['access'];
                            
                            if (json['refresh'] != '') {
                              BaseAPI.refresh = json['refresh'];
                            }
                            context.go('/mainApp');
                          } else {
                            print(req.body);
                          }
                        } on Exception catch (e){
                          print(e.toString());
                          print(context);
                        }
                    },
                  ),
                ].expand(
                  (widget) => [
                    widget,
                    const SizedBox(
                      height: 24,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
