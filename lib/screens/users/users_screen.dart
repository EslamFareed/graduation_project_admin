import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/screens/users/cubit/users_cubit.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersCubit.get(context).getUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return Center(child: CircularProgressIndicator());
          }
          final list = UsersCubit.get(context).users;
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                child: ListTile(
                  title: Text(
                      "name : ${item.name}\nemail : ${item.email}\nphone : ${item.phone}\ngender : ${item.gender}\ndate of birth : ${item.dateOfBirth}\nnationality : ${item.nationality}"),
                ),
              );
            },
            itemCount: list.length,
          );
        },
      ),
    );
  }
}
