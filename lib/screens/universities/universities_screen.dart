import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/navigation_helper.dart';
import 'package:graduation_project_admin/screens/universities/create_university_screen.dart';
import 'package:graduation_project_admin/screens/universities/cubit/universities_cubit.dart';

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
              context.goTo(CreateUniversityScreen());
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
                      child: ListTile(
                        leading: Image.network(
                          item.image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name ?? ""),
                            Text(item.email ?? ""),
                            Text(item.phone ?? ""),
                            Text(item.address ?? ""),
                            Text(item.desc ?? ""),
                          ],
                        ),
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
