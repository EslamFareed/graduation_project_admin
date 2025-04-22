import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/app_functions.dart';
import 'package:graduation_project_admin/screens/universities/cubit/universities_cubit.dart';
import 'package:graduation_project_admin/screens/universities/models/major_model.dart';
import 'package:graduation_project_admin/screens/universities/models/university_model.dart';

import '../../core/utils/app_colors.dart';

class CreateUniversityScreen extends StatelessWidget {
  CreateUniversityScreen({super.key});

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final descController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();
  final requirementsController = TextEditingController();
  String? gender;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UniversitiesCubit.get(context).majorsAdded = [];
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New University"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //! ------------------- Name ------------------!
                Row(children: [Text("Name")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: nameController,
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
                      return "Full Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Email ------------------!
                Row(children: [Text("Email")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
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
                      return "Email is required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Phone ------------------!
                Row(children: [Text("Phone")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
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
                      return "Phone is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Password ------------------!
                Row(children: [Text("Password")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
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
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Description ------------------!
                Row(children: [Text("Description")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: descController,
                  minLines: 5,
                  maxLines: 10,
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
                      return "Description is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Requirements ------------------!
                Row(children: [Text("Requirements")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: requirementsController,
                  minLines: 5,
                  maxLines: 10,
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
                      return "Requirements is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Address ------------------!
                Row(children: [Text("Address")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: addressController,
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
                      return "Address is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Website ------------------!
                Row(children: [Text("Website")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: websiteController,
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
                      return "Website is required";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- image ------------------!
                Row(children: [Text("Image")]),
                SizedBox(height: 5),
                BlocBuilder<UniversitiesCubit, UniversitiesState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        UniversitiesCubit.get(context).selectImage();
                      },
                      child: Container(
                        width: context.screenWidth,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: state is LoadingImageState
                              ? CircularProgressIndicator()
                              : UniversitiesCubit.get(context).imageLink == null
                                  ? Icon(Icons.upload)
                                  : Image.network(
                                      UniversitiesCubit.get(context)
                                              .imageLink ??
                                          "",
                                      fit: BoxFit.cover,
                                      height: 200,
                                      width: context.screenWidth,
                                    ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- Majors ------------------!
                Row(children: [Text("Majors")]),
                SizedBox(height: 5),
                BlocBuilder<UniversitiesCubit, UniversitiesState>(
                  builder: (context, state) {
                    var list = UniversitiesCubit.get(context).majorsAdded;
                    return InkWell(
                      onTap: () {
                        showMajorsBottomSheet(context);
                      },
                      child: Container(
                        width: context.screenWidth,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(list[index].name),
                            );
                          },
                          itemCount: list.length,
                        )),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Create University Button ------------------!
                BlocConsumer<UniversitiesCubit, UniversitiesState>(
                  listener: (context, state) {
                    if (state is SuccessUniversitiesState) {
                      context.showSuccessSnack("University added successfully");
                    } else if (state is ErrorUniversitiesState) {
                      context.showErrorSnack(
                        "University add Error, Please try again",
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingUniversitiesState
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  UniversitiesCubit.get(context)
                                      .majorsAdded
                                      .isNotEmpty &&
                                  UniversitiesCubit.get(context).imageLink !=
                                      null) {
                                UniversitiesCubit.get(context).createUniversity(
                                    UniversityModel(
                                        isAds: false,
                                        website: websiteController.text,
                                        image: UniversitiesCubit.get(context)
                                                .imageLink ??
                                            "",
                                        requirements:
                                            requirementsController.text,
                                        password: passwordController.text,
                                        majors: UniversitiesCubit.get(context)
                                            .majorsAdded,
                                        address: addressController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        email: emailController.text,
                                        desc: descController.text,
                                        id: ""));
                              } else {
                                context.showErrorSnack(
                                    "Must enter all data, Majors required");
                              }
                            },
                            minWidth: context.screenWidth,
                            height: 50,
                            color: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "Create New University",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showMajorsBottomSheet(BuildContext context) {
    final nameMajorController = TextEditingController();
    final feesMajorController = TextEditingController();
    final scoreMajorController = TextEditingController();

    final GlobalKey<FormState> _majorForm = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BottomSheet(
          onClosing: () {},
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _majorForm,
                child: Column(
                  children: [
                    Text(
                      "Enter Major Data",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 25),
                    Row(children: [Text("Major Name")]),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: nameMajorController,
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
                          return "Major Name is required";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Row(children: [Text("Major Fees")]),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: feesMajorController,
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
                          return "Major Fees is required";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Row(children: [Text("Major Score")]),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: scoreMajorController,
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
                          return "Major Score is required";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    MaterialButton(
                      onPressed: () {
                        if (_majorForm.currentState?.validate() ?? false) {
                          UniversitiesCubit.get(context).addMajor(
                            Major(
                              score: scoreMajorController.text,
                              fees: feesMajorController.text,
                              name: nameMajorController.text,
                            ),
                          );
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
                        "Add New Major",
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
