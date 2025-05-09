import 'package:flutter/material.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/login/cubit/login_cubit.dart';
import 'package:graduation_project_admin/screens/university_applications/university_applications_screen.dart';
import 'package:graduation_project_admin/screens/university_dashboard/university_profile_screen.dart';

class UniversityDashboardScreen extends StatelessWidget {
  const UniversityDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Welcome, ${LoginCubit.get(context).universityModel?.name}"),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(UniversityProfileScreen(
                    item: LoginCubit.get(context).universityModel!));
              },
              title: Text("University Profile"),
              leading: Icon(Icons.dashboard),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(UniversityApplicationsScreen());
              },
              title: Text("Applications"),
              leading: Icon(Icons.list),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
