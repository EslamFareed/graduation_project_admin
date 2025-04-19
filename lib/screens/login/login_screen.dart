import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/login/cubit/login_cubit.dart';
import 'package:graduation_project_admin/screens/university_dashboard/university_dashboard_screen.dart';

import '../../core/utils/app_colors.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * .05),
                SvgPicture.asset(
                  "assets/icons/icon.svg",
                  height: 100,
                  width: 100,
                ),
                Text(
                  "EduGate",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: context.screenHeight * .05),

                //! ------------------- Email ------------------!
                Row(children: [Text("Email")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                //! ------------------- Password ------------------!
                Row(children: [Text("Password")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: context.screenHeight * .05),

                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is ErrorLoginUniversityState) {
                      context.showErrorSnack("Login Error, Please login again");
                    } else if (state is SuccessLoginUniversityState) {
                      context.showSuccessSnack("Login Success");

                      context.goOffAll(UniversityDashboardScreen());
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingLoginUniversityState
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                LoginCubit.get(context).loginAsUniversity(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            minWidth: context.screenWidth,
                            height: 50,
                            color: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "Login as University",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                  },
                ),
                SizedBox(height: 20),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is ErrorLoginAdminState) {
                      context.showErrorSnack("Login Error, Please login again");
                    } else if (state is SuccessLoginAdminState) {
                      context.showSuccessSnack("Login Success");

                      context.goOffAll(DashboardScreen());
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingLoginAdminState
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                            onPressed: () {
                              if (globalKey.currentState?.validate() ?? false) {
                                LoginCubit.get(context).loginAsAdmin(
                                    emailController.text,
                                    passwordController.text);
                              }
                            },
                            minWidth: context.screenWidth,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(color: AppColors.primary)),
                            child: Text(
                              "Login as Admin",
                              style: TextStyle(color: AppColors.primary),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
