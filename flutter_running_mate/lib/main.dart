import 'dart:async';
import 'dart:convert';

import 'dart:io' show Platform;


import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_running_mate/src/mainapp.dart';
import 'package:flutter_running_mate/src/appRouter.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
// import 'package:window_size/window_size.dart';

import 'src/login.dart';
// import 'src/http/mock_client.dart';
import 'src/http/http_client.dart';
import 'src/mainapp.dart';
void main() {
  // setupWindow();
  runApp(const FormApp());
  // 앱 시작 시 주기적인 JWT 검증 시작
  verifyAccessTokenPeriodically();
}

void verifyAccessTokenPeriodically() {
  // JWT 검증 주기를 설정 (예: 1분)
  const Duration verificationInterval = Duration(minutes: 5);

  Timer.periodic(verificationInterval, (Timer timer) async {
    print('Verifying JWT...');

    // 여기서 JWT 검증 로직을 구현
    if (await isAccessTokenValid()) {
      print('JWT is valid.');
    } else {
      print('JWT is invalid or expired. Perform necessary actions.');

      // 만료된 토큰인 경우, 로그아웃 또는 재인증을 수행
      // 예를 들어, 로그아웃 함수 호출:
      performLogout();
    }
  });
}

Future<bool> isAccessTokenValid() async {
  // 이 함수에서 실제 JWT의 유효성을 확인하고 반환
  // 유효한 토큰이라면 true를, 그렇지 않으면 false를 반환
  // 여기에서는 단순히 true를 반환하므로 실제 검증 로직을 구현해야 합니다.
  var req = await _authAPI.verifyToken();
  if (req.statusCode != 200) {
    var req2 = await _authAPI.getTokenRefresh();
    if (req2.statusCode != 200) {
      return false;
    }
  }
  return true;
}

void performLogout() {
  // 로그아웃 로직을 구현
  _authAPI.logout();
  router.go('/signIn');
}

const double windowWidth = 480;
const double windowHeight = 854;
AuthAPI _authAPI = new AuthAPI();
// void setupWindow() {
//   if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
//     WidgetsFlutterBinding.ensureInitialized();
//     setWindowTitle('Form Samples');
//     setWindowMinSize(const Size(windowWidth, windowHeight));
//     setWindowMaxSize(const Size(windowWidth, windowHeight));
//     getCurrentScreen().then((screen) {
//       setWindowFrame(Rect.fromCenter(
//         center: screen!.frame.center,
//         width: windowWidth,
//         height: windowHeight,
//       ));
//     });
//   }
// }



class FormApp extends StatelessWidget {
  const FormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Form Samples',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Samples'),
      ),
      body: ListView(
        children: [...demos.map((d) => DemoTile(demo: d))],
      ),
    );
  }
}
