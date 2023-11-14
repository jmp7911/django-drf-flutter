import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_running_mate/src/http/http_client.dart';

import 'package:flutter_running_mate/src/model/customer.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_running_mate/src/appRouter.dart';


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
  
  AuthAPI _authAPI = AuthAPI();
  
  final List<Demo> items = demos.sublist(3);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Running Mate'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 한 행에 표시할 항목 수
          crossAxisSpacing: 8.0, // 항목 간의 가로 간격
          mainAxisSpacing: 8.0, // 항목 간의 세로 간격
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 여기에 탭했을 때 수행할 동작을 추가하세요.
              context.go(items[index].route);
              // 또는 Navigator를 사용하여 다른 화면으로 이동할 수도 있습니다.
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherScreen()));
            },
            child: Container(
              color: Colors.blue, // 각 항목의 배경색
              child: Center(
                child: Text(
                  items[index].name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
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

