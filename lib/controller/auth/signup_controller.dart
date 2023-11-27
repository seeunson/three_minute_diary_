import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:three_minute_diary/controller/auth/auth_controller.dart';

class SignupController extends GetxController {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var pwController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled.obs; // GetX 반응형 변수

  void enableAutoValidation() {
    autovalidateMode.value = AutovalidateMode.always; // GetX 반응형 변수 값 변경}
  }

  final AuthController authController = Get.find();

  void handleSignupButton() {
    authController.signup(
      email: emailController.text,
      name: nameController.text,
      password: pwController.text,
    );
  }
}
