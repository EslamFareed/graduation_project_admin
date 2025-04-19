import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/applications/cubit/applications_cubit.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApplicationsCubit.get(context).getApplications();
    return Scaffold(
      appBar: AppBar(
        title: Text("Applications"),
      ),
      body: BlocBuilder<ApplicationsCubit, ApplicationsState>(
        builder: (context, state) {
          if (state is LoadingApplicationsState) {
            return Center(child: CircularProgressIndicator());
          }
          final list = ApplicationsCubit.get(context).applications;
          return ListView.builder(
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                child: Row(
                  spacing: 20,
                  children: [
                    Image.network(
                      item.university.image,
                      width: context.screenWidth * .3,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("University Name : ${item.university.name}"),
                            Text("Student Name : ${item.user.name}"),
                            Text("Student Phone : ${item.user.phone}"),
                            Text("Student ID : ${item.idNumber}"),
                            Text(
                              "Status : ${item.status}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "Application Date : ${item.date.year}-${item.date.month}-${item.date.day}"),
                            Text("Major : ${item.major.name}"),
                            Text("Fees : ${item.major.fees}"),
                          ],
                        ),
                      ),
                    ),
                  ],
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
