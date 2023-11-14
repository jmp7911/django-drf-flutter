import 'dart:async';
import 'dart:convert';

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_running_mate/main.dart';
import 'package:flutter_running_mate/src/geolocator.dart';
import 'package:flutter_running_mate/src/http/http_client.dart';
import 'package:flutter_running_mate/src/login.dart';
import 'package:flutter_running_mate/src/mainapp.dart';
import 'package:flutter_running_mate/src/record.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
// import 'package:window_size/window_size.dart';

final demos = [
  Demo(
    name: 'Sign in with HTTP',
    route: 'signIn',
    builder: (context) => SignInHttpDemo(
      // This sample uses a mock HTTP client.
      httpClient: client,
    ),
  ),
  Demo(
    name: 'Running Mate',
    route: 'mainApp',
    builder: (context) => MainApp(
      // This sample uses a mock HTTP client.
      httpClient: client,
    ),
  ),
  Demo(
    name: 'Geolocator',
    route: 'myGeolocator',
    builder: (context) => MyGeolocator(
      
    ),
  ),
  Demo(
    name: 'Record',
    route: 'record',
    builder: (context) => MySwipePage(
    ),
  ),
  Demo(
    name: 'History',
    route: 'history',
    builder: (context) => MainApp(
      // This sample uses a mock HTTP client.
      httpClient: client,
    ),
  ),
  Demo(
    name: 'Settings',
    route: 'settings',
    builder: (context) => MyGeolocator(
      
    ),
  ),
];

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        for (final demo in demos)
          GoRoute(
            path: demo.route,
            builder: (context, state) => demo.builder(context),
          ),
      ],
    ),
  ],
);


class DemoTile extends StatelessWidget {
  final Demo? demo;

  const DemoTile({this.demo, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(demo!.name),
      onTap: () {
        context.go('/${demo!.route}');
      },
    );
  }
}

class Demo {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const Demo({required this.name, required this.route, required this.builder});
}

