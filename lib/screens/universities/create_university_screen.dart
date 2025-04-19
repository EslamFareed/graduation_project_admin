import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/navigation_helper.dart';
import 'package:graduation_project_admin/core/utils/show_snackbar.dart';
import 'package:graduation_project_admin/screens/admins/cubit/admins_cubit.dart';
import 'package:graduation_project_admin/screens/dashboard/dashboard_screen.dart';

class CreateUniversityScreen extends StatelessWidget {
  CreateUniversityScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  // final phoneController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create University"),
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
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.security),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                BlocConsumer<AdminsCubit, AdminsState>(
                  listener: (context, state) {
                    if (state is ErrorAdminsState) {
                      context.showSnackBar(
                          SnackType.error, "Error, Please login again");
                    } else if (state is SuccessAdminsState) {
                      context.showSnackBar(
                          SnackType.success, "Created Successfully");
                      context.goOffAll(DashboardScreen());
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingAdminsState
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                              ),
                              onPressed: () {
                                if (globalKey.currentState?.validate() ??
                                    false) {
                                  AdminsCubit.get(context).createAdmin(
                                      emailController.text,
                                      passwordController.text);
                                }
                              },
                              child: Text(
                                "Create Admin",
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
