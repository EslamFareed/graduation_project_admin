import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/applications/models/application_model.dart';

import '../../core/utils/app_colors.dart';
import '../login/cubit/login_cubit.dart';
import 'cubit/university_applications_cubit.dart';

class UniversityApplicationDetailsScreen extends StatelessWidget {
  UniversityApplicationDetailsScreen({super.key, required this.item});

  final StudentApplication item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        item.user.name,
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
                        item.user.email,
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
                        item.user.phone,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.circle),
                      title: Text(
                        "Status : ${item.status}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    width: context.screenWidth,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text("Date of birth : ${item.user.dateOfBirth}"),
                            Text("Gender : ${item.user.gender}"),
                            Text("Nationality : ${item.user.nationality}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    width: context.screenWidth,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text("Date of Application : ${item.date}"),
                            Text("Father Phone : ${item.fatherPhone}"),
                            Text("Father Job : ${item.fatherJob}"),
                            Text("Mother Name : ${item.motherName}"),
                            Text("Mother Phone : ${item.motherPhone}"),
                            Text("Mother Job : ${item.motherJob}"),
                            Text("High School Name : ${item.highSchoolName}"),
                            Text(
                                "High School Percentage : ${item.highSchoolPercentage}"),
                            Text("Interview Date : ${item.interviewDate}"),
                            Text(
                                "Interview Description : ${item.interviewDesc}"),
                            Text("Selected Major : ${item.major.name}"),
                            Text("Application Type : ${item.type}"),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text("ID Photo"),
                  Image.network(
                    item.idPhoto,
                    height: 300,
                    fit: BoxFit.cover,
                    width: context.screenWidth,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text("Certification Photo"),
                  Image.network(
                    item.certificatePhoto,
                    height: 300,
                    fit: BoxFit.cover,
                    width: context.screenWidth,
                  ),
                ],
              ),
            ),
            BlocConsumer<UniversityApplicationsCubit,
                UniversityApplicationsState>(
              listener: (context, state) {
                if (state is SuccessChangeApplicationStatus) {
                  UniversityApplicationsCubit.get(context).getApplications(
                      LoginCubit.get(context).universityModel!.id);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is LoadingChangeApplicationStatus) {
                  return Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    spacing: 10,
                    children: [
                      if (item.status == "interview" ||
                          item.status == "pending")
                        MaterialButton(
                          onPressed: () {
                            UniversityApplicationsCubit.get(context)
                                .accpetOrRejectApplication(true, item.id);
                          },
                          minWidth: context.screenWidth,
                          height: 50,
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "Accpet This Application",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      if (item.status == "interview" ||
                          item.status == "pending")
                        MaterialButton(
                          onPressed: () {
                            UniversityApplicationsCubit.get(context)
                                .accpetOrRejectApplication(false, item.id);
                          },
                          minWidth: context.screenWidth,
                          height: 50,
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "Reject This Application",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      if (item.status == "pending")
                        MaterialButton(
                          onPressed: () {
                            showMajorsBottomSheet(context);
                          },
                          minWidth: context.screenWidth,
                          height: 50,
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            "Make interview",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        interviewDateController.text =
            "${finalDateTime.day.toString().padLeft(2, '0')}/"
            "${finalDateTime.month.toString().padLeft(2, '0')}/"
            "${finalDateTime.year} "
            "${pickedTime.hour.toString().padLeft(2, '0')}:"
            "${pickedTime.minute.toString().padLeft(2, '0')}";
      }
    }
  }

  final interviewDescController = TextEditingController();
  final interviewDateController = TextEditingController();

  void showMajorsBottomSheet(BuildContext context) {
    final GlobalKey<FormState> _interviewForm = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BottomSheet(
          onClosing: () {},
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _interviewForm,
                child: Column(
                  children: [
                    Text(
                      "Enter Interview Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 25),
                    Row(children: [Text("Interview Desc")]),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: interviewDescController,
                      decoration: InputDecoration(
                        hintText: "",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Interview Desc is required";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Row(children: [Text("Interview Date")]),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: interviewDateController,
                      readOnly: true,
                      onTap: () {
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                        hintText: "DD/MM/YYYY",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Interview Date is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    MaterialButton(
                      onPressed: () {
                        if (_interviewForm.currentState?.validate() ?? false) {
                          UniversityApplicationsCubit.get(context)
                              .makeInterviewApplication(item.id,
                                  interviewDesc: interviewDescController.text,
                                  interviewDate: interviewDateController.text);
                          Navigator.pop(context);
                        }
                      },
                      minWidth: context.screenWidth,
                      height: 50,
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Add Interview Details",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
