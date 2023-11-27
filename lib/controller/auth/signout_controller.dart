import 'package:get/get.dart';
import 'package:three_minute_diary/controller/auth/auth_controller.dart';

class SignoutController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  void handleSignoutButton() {
    authController.signOut();
  }
}
