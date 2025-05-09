import 'package:flutter/material.dart';
import 'package:graduation_project_admin/screens/universities/cubit/universities_cubit.dart';
import '../../core/utils/app_colors.dart';
import 'models/university_model.dart';
import 'models/major_model.dart';

class EditUniversityScreen extends StatefulWidget {
  final UniversityModel university;

  const EditUniversityScreen({super.key, required this.university});

  @override
  State<EditUniversityScreen> createState() => _EditUniversityScreenState();
}

class _EditUniversityScreenState extends State<EditUniversityScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController websiteController;
  late final TextEditingController requirementsController;
  late final TextEditingController descController;

  List<Major> majors = [];

  @override
  void initState() {
    super.initState();
    final u = widget.university;
    nameController = TextEditingController(text: u.name);
    phoneController = TextEditingController(text: u.phone);
    addressController = TextEditingController(text: u.address);
    websiteController = TextEditingController(text: u.website);
    requirementsController = TextEditingController(text: u.requirements);
    descController = TextEditingController(text: u.desc);
    majors = List.from(u.majors);
  }

  void saveData() {
    if (!_formKey.currentState!.validate()) return;

    for (var major in majors) {
      if (major.name.isEmpty || major.score.isEmpty || major.fees.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All major fields must be filled.")),
        );
        return;
      }
    }

    final updatedUniversity = UniversityModel(
      id: widget.university.id,
      name: nameController.text.trim(),
      email: widget.university.email,
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      website: websiteController.text.trim(),
      requirements: requirementsController.text.trim(),
      desc: descController.text.trim(),
      image: widget.university.image,
      password: widget.university.password,
      isAds: widget.university.isAds,
      majors: majors,
    );

    UniversitiesCubit.get(context).editUniversity(updatedUniversity);

    Navigator.pop(context, updatedUniversity);
  }

  void addMajor() {
    setState(() {
      majors.add(Major(name: '', score: '', fees: ''));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit University")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image.network(widget.university.image,
              //     height: 150, fit: BoxFit.cover),
              // const SizedBox(height: 10),
              // Text(widget.university.email,
              //     style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildField("Name", nameController),
              _buildField("Phone", phoneController),
              _buildField("Address", addressController),
              _buildField("Website", websiteController),
              _buildField("Requirements", requirementsController, maxLines: 3),
              _buildField("Description", descController, maxLines: 3),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Majors",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: addMajor, child: const Text("Add Major")),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: majors.length,
                itemBuilder: (context, index) {
                  final major = majors[index];
                  final nameCtrl = TextEditingController(text: major.name);
                  final scoreCtrl = TextEditingController(text: major.score);
                  final feesCtrl = TextEditingController(text: major.fees);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameCtrl,
                            decoration:
                                const InputDecoration(labelText: "Major Name"),
                            validator: (val) =>
                                val!.trim().isEmpty ? 'Required' : null,
                            onChanged: (val) =>
                                majors[index] = major.copyWith(name: val),
                          ),
                          TextFormField(
                            controller: scoreCtrl,
                            decoration:
                                const InputDecoration(labelText: "Score"),
                            validator: (val) =>
                                val!.trim().isEmpty ? 'Required' : null,
                            onChanged: (val) =>
                                majors[index] = major.copyWith(score: val),
                          ),
                          TextFormField(
                            controller: feesCtrl,
                            decoration:
                                const InputDecoration(labelText: "Fees"),
                            validator: (val) =>
                                val!.trim().isEmpty ? 'Required' : null,
                            onChanged: (val) =>
                                majors[index] = major.copyWith(fees: val),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  setState(() => majors.removeAt(index)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveData,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                child: const Text("Save Changes",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (val) => val!.trim().isEmpty ? 'Required' : null,
      ),
    );
  }
}
