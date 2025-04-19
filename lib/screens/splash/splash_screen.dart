import 'package:flutter/material.dart';
import 'package:graduation_project_admin/core/utils/navigation_helper.dart';
import 'package:graduation_project_admin/core/utils/shared_helper.dart';
import 'package:graduation_project_admin/screens/dashboard/dashboard_screen.dart';
import 'package:graduation_project_admin/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      if (SharedHelper.isLogin()) {
        context.goOff(DashboardScreen());
      } else {
        context.goOff(LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
