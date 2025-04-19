import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/login/cubit/login_cubit.dart';
import 'package:graduation_project_admin/screens/university_applications/cubit/university_applications_cubit.dart';

class UniversityApplicationsScreen extends StatelessWidget {
  const UniversityApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UniversityApplicationsCubit.get(context)
        .getApplications(LoginCubit.get(context).universityModel!.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Applications"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: SearchBar(
                hintText: "Search for Applications",
                onChanged: (value) {
                  UniversityApplicationsCubit.get(context).search(value);
                },
              ),
            ),
            BlocBuilder<UniversityApplicationsCubit,
                UniversityApplicationsState>(
              builder: (context, state) {
                if (state is LoadingUniversityApplicationsState) {
                  return Center(child: CircularProgressIndicator());
                }
                final list =
                    UniversityApplicationsCubit.get(context).applications;
                return ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                                  Text("Student Name : ${item.user.name}"),
                                  Text(
                                    "Status : ${item.status}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  if (item.status == "interview")
                                    Text(
                                        "Interview Date : ${item.interviewDate.year}-${item.interviewDate.month}-${item.interviewDate.day}"),
                                  Text(
                                      "Application Date : ${item.date.year}-${item.date.month}-${item.date.day}"),
                                  Text("Major : ${item.major.name}"),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
