import 'package:flutter/material.dart';
import 'package:graduation_project_admin/core/utils/navigation_helper.dart';
import 'package:graduation_project_admin/core/utils/shared_helper.dart';
import 'package:graduation_project_admin/screens/admins/admins_screen.dart';
import 'package:graduation_project_admin/screens/universities/universities_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${SharedHelper.getAdminEmail()}"),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                context.goTo(AdminsScreen());
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
              onTap: () {},
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
                context.goTo(UniversitiesScreen());

              },
              title: Text("Universities"),
              leading: Icon(Icons.dashboard),
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
