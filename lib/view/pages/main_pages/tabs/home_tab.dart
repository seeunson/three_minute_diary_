import 'package:flutter/material.dart';
import 'package:three_minute_diary/util/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              // controller.handleSignoutButton();
            },
            child: Text('HomeTab'),
          ),
          // Text(controller.authController.user.value?.email ?? ''),
        ],
      ),
    );
  }
}
