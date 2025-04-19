import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/screens/applications/models/application_model.dart';
import 'package:meta/meta.dart';

part 'university_applications_state.dart';

class UniversityApplicationsCubit extends Cubit<UniversityApplicationsState> {
  UniversityApplicationsCubit() : super(UniversityApplicationsInitial());

  static UniversityApplicationsCubit get(context) => BlocProvider.of(context);
  final firestore = FirebaseFirestore.instance;

  List<StudentApplication> allApplications = [];
  List<StudentApplication> applications = [];

  void getApplications(String id) async {
    print(id);
    emit(LoadingUniversityApplicationsState());
    try {
      var data = await firestore
          .collection("applications")
          .where("university.id", isEqualTo: id)
          .get();

      allApplications =
          data.docs.map((e) => StudentApplication.fromJson(e.data())).toList();
      applications = allApplications;

      emit(SuccessUniversityApplicationsState());
    } catch (e) {
      emit(ErrorUniversityApplicationsState());
    }
  }

  void search(String text) {
    emit(UniversityApplicationsInitial());

    applications = allApplications
        .where((e) =>
            e.user.name.toLowerCase().contains(text.toLowerCase()) ||
            e.idNumber.toLowerCase().contains(text.toLowerCase()) ||
            e.university.name.toLowerCase().contains(text.toLowerCase()) ||
            e.user.phone.toLowerCase().contains(text.toLowerCase()) ||
            e.major.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    emit(SuccessUniversityApplicationsState());
  }
}
