import 'package:flutter/material.dart';
import 'package:graduation_project_admin/core/utils/app_colors.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        context.goOffAll(LoginScreen());
      }
    });

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/icon.png",
              height: 200,
              width: 200,
              color: Colors.white,
            ),
            Text(
              "EduGate ADMIN",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
