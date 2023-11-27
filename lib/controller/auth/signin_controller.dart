import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:three_minute_diary/controller/auth/auth_controller.dart';

class SigninController extends GetxController {
  final AuthController authController = Get.find();

  var emailController = TextEditingController();
  var pwController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled.obs; // GetX 반응형 변수

  void enableAutoValidation() {
    autovalidateMode.value = AutovalidateMode.always; // GetX 반응형 변수 값 변경}
  }

  void handleSigninButton() {
    authController.signin(
      email: emailController.text,
      password: pwController.text,
    );
  }

  // Google 로그인 처리
  // Future<User?> handleGoogleSigninButton() async {
  //   return await authController.signInWithGoogle();
  // }
}
