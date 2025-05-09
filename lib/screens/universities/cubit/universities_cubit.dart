import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/screens/universities/models/major_model.dart';
import 'package:graduation_project_admin/screens/universities/models/university_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'universities_state.dart';

class UniversitiesCubit extends Cubit<UniversitiesState> {
  UniversitiesCubit() : super(UniversitiesInitial());

  static UniversitiesCubit get(context) => BlocProvider.of(context);
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  List<Major> majorsAdded = [];

  void addMajor(Major m) {
    emit(LoadingAddNewMajorState());
    majorsAdded.add(m);
    emit(SuccessAddNewMajorState());
  }

  List<UniversityModel> universities = [];

  void getUniversities() async {
    emit(LoadingUniversitiesState());

    try {
      firestore.collection("universities").snapshots().listen((data) {
        universities = data.docs.map((e) {
          var university = e.data();
          university["id"] = e.id;

          return UniversityModel.fromJson(university);
        }).toList();

        emit(SuccessUniversitiesState());
      });
    } catch (e) {
      emit(ErrorUniversitiesState());
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  void createUniversity(UniversityModel item) async {
    emit(LoadingUniversitiesState());
    try {
      var data = await auth.createUserWithEmailAndPassword(
          email: item.email, password: item.password);
      if (data.user != null) {
        await firestore
            .collection("universities")
            .doc(data.user!.uid)
            .set(item.toJson());

        emit(SuccessUniversitiesState());
      } else {
        emit(ErrorUniversitiesState());
      }
    } catch (e) {
      emit(ErrorUniversitiesState());
    }
  }

  void editUniversity(UniversityModel item) async {
    emit(LoadingUniversitiesState());
    try {
      await firestore
          .collection("universities")
          .doc(item.id)
          .update(item.toJson());

      emit(SuccessUniversitiesState());
    } catch (e) {
      emit(ErrorUniversitiesState());
    }
  }

  void deleteUniversity(UniversityModel item) async {
    emit(LoadingUniversitiesState());
    try {
      await auth.signInWithEmailAndPassword(
          email: item.email, password: item.password);

      await auth.currentUser?.delete();

      await firestore.collection("universities").doc(item.id).delete();

      emit(SuccessUniversitiesState());
    } catch (e) {
      emit(ErrorUniversitiesState());
    }
  }

  String? imageLink;

  void selectImage() async {
    emit(LoadingImageState());

    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        File file = File(image.path);

        final storageRef = storage.ref();
        final imagesRef = storageRef.child("images/${image.name}");
        await imagesRef.putFile(file);
        String downloadURL = await imagesRef.getDownloadURL();
        imageLink = downloadURL;
        emit(SuccessImageState());
      } else {
        emit(ErrorImageState());
      }
    } catch (e) {
      emit(ErrorImageState());
    }
  }

  void makeAds(bool val, String id) async {
    emit(LoadingUniversitiesState());
    try {
      await firestore.collection("universities").doc(id).update({"isAds": val});
      emit(SuccessUniversitiesState());
    } catch (e) {
      emit(ErrorUniversitiesState());
    }
  }
}
