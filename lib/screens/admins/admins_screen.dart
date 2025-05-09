import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/admins/cubit/admins_cubit.dart';
import 'package:graduation_project_admin/screens/login/cubit/login_cubit.dart';

import 'create_admin_screen.dart';

class AdminsScreen extends StatelessWidget {
  const AdminsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AdminsCubit.get(context).getAdmins();
    return Scaffold(
      appBar: AppBar(
        title: Text("Admins"),
        actions: [
          IconButton(
            onPressed: () {
              context.goToPage(CreateAdminScreen());
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<AdminsCubit, AdminsState>(
        builder: (context, state) {
          return state is LoadingAdminsState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final item = AdminsCubit.get(context).admins[index];
                    return Card(
                      child: ListTile(
                        onLongPress: () {
                          if (LoginCubit.get(context).adminData!["id"] !=
                              item.id) {
                            showDeleteAdminDialog(
                              context: context,
                              onDelete: () {
                                AdminsCubit.get(context).deleteAdmin(item);
                              },
                            );
                          } else {
                            context.showErrorSnack(
                                "You can't remove your account");
                          }
                        },
                        leading: Text("${index + 1}"),
                        title: Text(item.email ?? ""),
                      ),
                    );
                  },
                  itemCount: AdminsCubit.get(context).admins.length,
                );
        },
      ),
    );
  }

  Future<void> showDeleteAdminDialog({
    required BuildContext context,
    required VoidCallback onDelete,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text(
              'Are you sure you want to delete this Admin? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // dismiss
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // dismiss
                onDelete(); // execute deletion
              },
            ),
          ],
        );
      },
    );
  }
}
