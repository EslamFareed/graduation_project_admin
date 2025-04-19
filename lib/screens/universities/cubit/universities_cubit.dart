import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/screens/universities/models/university_model.dart';
import 'package:meta/meta.dart';

part 'universities_state.dart';

class UniversitiesCubit extends Cubit<UniversitiesState> {
  UniversitiesCubit() : super(UniversitiesInitial());

  static UniversitiesCubit get(context) => BlocProvider.of(context);
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  List<UniversityModel> universities = [];

  void getUniversities() async {
    emit(LoadingUniversitiesState());

    try {
      var data = await firestore.collection("universities").get();

      universities =
          data.docs.map((e) => UniversityModel.fromFirbase(e)).toList();

      emit(SuccessUniversitiesState());
    } catch (e) {
      emit(ErrorUniversitiesState());
    }
  }

  void createUniversity(UniversityModel item) async {
    emit(LoadingUniversitiesState());
    try {
      var data = await auth.createUserWithEmailAndPassword(
          email: item.email!, password: item.password!);
      if (data.user != null) {
        await firestore.collection("universities").doc(data.user!.uid).set(item.toJson());

        emit(SuccessUniversitiesState());
      } else {
        emit(ErrorUniversitiesState());
      }
    } catch (e) {
      emit(ErrorUniversitiesState());
    }
  }
}
