import 'dart:async';
import 'package:flutter/material.dart';
import 'package:three_minute_diary/view/pages/auth_page/signup_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //로그인 페이지로 이동
  void moveScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    //3초 후에 moveScreen 함수를 실행, 로그인 페이지로 이동
    super.initState();
    Timer(Duration(seconds: 2), () {
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.wallpaper, size: 100),
          Text('Three Minute Diary', style: TextStyle(fontSize: 30)),
        ],
      )),
    );
  }
}
