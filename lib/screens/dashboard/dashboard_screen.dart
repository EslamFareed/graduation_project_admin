import 'package:flutter/material.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/applications/applications_screen.dart';
import 'package:graduation_project_admin/screens/login/cubit/login_cubit.dart';
import 'package:graduation_project_admin/screens/sliders/sliders_screen.dart';
import 'package:graduation_project_admin/screens/users/users_screen.dart';

import '../admins/admins_screen.dart';
import '../universities/universities_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${LoginCubit.get(context).adminData?["email"]}"),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(AdminsScreen());
              },
              title: Text("Admins"),
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
                context.goToPage(UsersScreen());
              },
              title: Text("Users"),
              leading: Icon(Icons.person),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(SlidersScreen());
              },
              title: Text("Sliders ADS"),
              leading: Icon(Icons.image),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                context.goToPage(UniversitiesScreen());
              },
              title: Text("Universities"),
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
                context.goToPage(ApplicationsScreen());
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
