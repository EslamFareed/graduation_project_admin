import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/application_model.dart';

part 'applications_state.dart';

class ApplicationsCubit extends Cubit<ApplicationsState> {
  ApplicationsCubit() : super(ApplicationsInitial());

  static ApplicationsCubit get(context) => BlocProvider.of(context);

  List<StudentApplication> applications = [];
  final firestore = FirebaseFirestore.instance;
  void getApplications() async {
    emit(LoadingApplicationsState());
    try {
      firestore.collection("applications").snapshots().listen((data) {
        applications = data.docs
            .map((e) => StudentApplication.fromJson(e.data()))
            .toList();

        emit(SuccessApplicationsState());
      });
    } catch (e) {
      emit(ErrorApplicationsState());
    }
  }
}
