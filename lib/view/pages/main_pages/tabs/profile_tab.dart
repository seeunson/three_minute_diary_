import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:three_minute_diary/controller/auth/signout_controller.dart';

class ProfileTab extends GetView<SignoutController> {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextButton(
          onPressed: () {
            controller.handleSignoutButton();
          },
          child: Text('ProfileTab'),
        ),
        Text(controller.authController.user.value?.email ?? ''),
      ],
    ));
  }
}
