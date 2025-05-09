import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/universities/cubit/universities_cubit.dart';

import '../../core/utils/app_colors.dart';
import 'edit_university_screen.dart';
import 'models/university_model.dart';

class UniversityDetailsScreen extends StatelessWidget {
  const UniversityDetailsScreen({super.key, required this.item});

  final UniversityModel item;

  Future<void> showDeleteUniversityDialog({
    required BuildContext context,
    required VoidCallback onDelete,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text(
              'Are you sure you want to delete this university? This action cannot be undone.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.goToPage(screen)
      //   },
      //   child: Icon(Icons.edit),
      // ),
      appBar: AppBar(
        title: Text(item.name),
        actions: [
          IconButton(
            onPressed: () async {
              await context.goToPage(EditUniversityScreen(
                university: item,
              ));
              Navigator.pop(context);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDeleteUniversityDialog(
                context: context,
                onDelete: () {
                  UniversitiesCubit.get(context).deleteUniversity(item);
                  Navigator.pop(context);
                },
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item.image,
              height: 300,
              fit: BoxFit.cover,
              width: context.screenWidth,
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.mail),
                      title: Text(
                        item.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        item.phone,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.location_pin),
                      title: Text(item.address, style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.link),
                      title: Text(item.website, style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Text("Requirements"),
                  Text(item.requirements, style: TextStyle(fontSize: 16)),
                  Divider(),
                  Text("Majors", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primary,
                          ),
                          child: Text(
                            item.majors[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                      itemCount: item.majors.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Text(item.desc, style: TextStyle(fontSize: 16)),
                  BlocBuilder<UniversitiesCubit, UniversitiesState>(
                    builder: (context, state) {
                      return Card(
                        child: SwitchListTile(
                          value: item.isAds,
                          title: Text("Make this university an ad"),
                          onChanged: (value) {
                            UniversitiesCubit.get(context)
                                .makeAds(value, item.id);
                            // Handle the switch change
                            item.isAds = value;
                            // You can also call a function to update the state in your app
                          },
                          activeColor: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
