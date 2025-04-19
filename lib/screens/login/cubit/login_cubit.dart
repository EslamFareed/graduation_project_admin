import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/screens/universities/models/university_model.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? adminData;
  void loginAsAdmin(String email, String password) async {
    emit(LoadingLoginAdminState());
    try {
      var dataAuth = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (dataAuth.user != null) {
        var data =
            await firestore.collection("admins").doc(dataAuth.user?.uid).get();
        if (data.exists) {
          adminData = {"email": email, "id": dataAuth.user!.uid};

          emit(SuccessLoginAdminState());
        } else {
          emit(ErrorLoginAdminState());
        }
      } else {
        emit(ErrorLoginAdminState());
      }
    } catch (e) {
      emit(ErrorLoginAdminState());
    }
  }

  UniversityModel? universityModel;
  void loginAsUniversity(String email, String password) async {
    emit(LoadingLoginUniversityState());
    try {
      var dataAuth = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (dataAuth.user != null) {
        var data = await firestore
            .collection("universities")
            .doc(dataAuth.user?.uid)
            .get();
        if (data.exists) {
          Map<String, dynamic> jsonData = data.data() ?? {};
          jsonData["id"] = data.id;
          universityModel = UniversityModel.fromJson(jsonData);

          emit(SuccessLoginUniversityState());
        } else {
          emit(ErrorLoginUniversityState());
        }
      } else {
        emit(ErrorLoginUniversityState());
      }
    } catch (e) {
      log(e.toString(), name: "error");
      emit(ErrorLoginUniversityState());
    }
  }
}
