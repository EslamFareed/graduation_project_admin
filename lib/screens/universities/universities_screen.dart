import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/universities/cubit/universities_cubit.dart';
import 'package:graduation_project_admin/screens/universities/university_details_screen.dart';

import 'create_university_screen.dart';

class UniversitiesScreen extends StatelessWidget {
  const UniversitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UniversitiesCubit.get(context).getUniversities();
    return Scaffold(
      appBar: AppBar(
        title: Text("Universities"),
        actions: [
          IconButton(
            onPressed: () {
              context.goToPage(CreateUniversityScreen());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<UniversitiesCubit, UniversitiesState>(
        builder: (context, state) {
          return state is LoadingUniversitiesState
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final item =
                        UniversitiesCubit.get(context).universities[index];
                    return Card(
                      child: Row(
                        spacing: 20,
                        children: [
                          Image.network(
                            item.image,
                            width: context.screenWidth * .3,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(item.email),
                                Text(item.phone),
                                Text(item.address),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.goToPage(
                                UniversityDetailsScreen(item: item),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: UniversitiesCubit.get(context).universities.length,
                );
        },
      ),
    );
  }
}
