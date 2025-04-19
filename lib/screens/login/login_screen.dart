import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/navigation_helper.dart';
import 'package:graduation_project_admin/core/utils/show_snackbar.dart';
import 'package:graduation_project_admin/screens/dashboard/dashboard_screen.dart';
import 'package:graduation_project_admin/screens/login/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visible = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email must be not empty";
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password must be not empty";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: visible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.security),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: Icon(
                          visible ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    child: Text(
                      "Login as University",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is ErrorLoginState) {
                      context.showSnackBar(
                          SnackType.error, "Login Error, Please login again");
                    } else if (state is SuccessLoginState) {
                      context.showSnackBar(SnackType.success, "Login Success");
                      context.goOff(DashboardScreen());
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingLoginState
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (globalKey.currentState?.validate() ??
                                    false) {
                                  LoginCubit.get(context).login(
                                      emailController.text,
                                      passwordController.text);
                                }
                              },
                              child: Text(
                                "Login as Admin",
                                style: TextStyle(color: Colors.white),
                              ),
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
