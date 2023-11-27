import 'package:get/get.dart';
import 'package:three_minute_diary/view/pages/auth_page/Login_page.dart';
import 'package:three_minute_diary/view/pages/auth_page/signup_page.dart';
import 'package:three_minute_diary/view/pages/main_pages/index_page.dart';
import 'package:three_minute_diary/view/pages/splash_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/', page: () => SplashPage()),
    GetPage(name: '/login', page: () => SigninPage()),
    GetPage(name: '/signup', page: () => SignupPage()),
    GetPage(name: '/index', page: () => IndexPage()),
  ];
}
