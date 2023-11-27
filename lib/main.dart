import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:three_minute_diary/controller/auth/auth_controller.dart';
import 'package:three_minute_diary/controller/auth/signin_controller.dart';
import 'package:three_minute_diary/controller/auth/signout_controller.dart';
import 'package:three_minute_diary/controller/auth/signup_controller.dart';
import 'package:three_minute_diary/controller/index/diary/diary_controller.dart';
import 'package:three_minute_diary/controller/index/diary/diary_upload_controller.dart';
import 'package:three_minute_diary/controller/index/memo/memo_tab_controller.dart';
import 'package:three_minute_diary/firebase_options.dart';
import 'package:three_minute_diary/util/app_pages.dart';
import 'package:three_minute_diary/view/pages/auth_page/Login_page.dart';
import 'package:three_minute_diary/view/pages/auth_page/signup_page.dart';
import 'package:three_minute_diary/view/pages/main_pages/index_page.dart';
import 'package:three_minute_diary/view/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Firebase 초기화
  Get.put(DiaryUploadController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Three Minute Diary',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(SignupController());
        Get.put(SigninController());
        Get.put(SignoutController());
        Get.put(DiaryController());
        Get.put(DiaryUploadController());
        Get.put(MemoTabController());
      }),
      getPages: AppPages.pages,
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => SigninPage(),
        '/signup': (context) => SignupPage(),
        '/index': (context) => IndexPage(),
      },
      initialRoute: '/',
    );
  }
}
