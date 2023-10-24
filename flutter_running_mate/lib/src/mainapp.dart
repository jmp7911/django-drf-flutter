import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_running_mate/src/http/http_client.dart';

import 'package:flutter_running_mate/src/model/customer.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FormData {
  String? email;
  String? password;

  FormData({
    this.email,
    this.password,
  });

}

class MainApp extends StatefulWidget {
  final HttpClient? httpClient;

  const MainApp({
    this.httpClient,
    super.key,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  FormData formData = FormData();
  AuthAPI _authAPI = AuthAPI();
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Running Mate'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // 열의 개수
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Center(child: Text('셀 1')),
          ),
          Container(
            color: Colors.green,
            child: Center(child: Text('셀 2')),
          ),
          Container(
            color: Colors.blue,
            child: Center(child: Text('셀 3')),
          ),
          Container(
            color: Colors.orange,
            child: Center(child: Text('셀 4')),
          ),
          Container(
            color: Colors.purple,
            child: Center(child: Text('셀 5')),
          ),
          Container(
            color: Colors.yellow,
            child: Center(child: Text('셀 6')),
          ),
        ],
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
