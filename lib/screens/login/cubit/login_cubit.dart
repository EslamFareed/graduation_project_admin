import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_admin/core/utils/shared_helper.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  final auth = FirebaseAuth.instance;
  void login(String email, String password) async {
    emit(LoadingLoginState());
    try {
      var data = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (data.user != null) {
        await SharedHelper.loginAsAdmin(email, data.user!.uid);
        emit(SuccessLoginState());
      } else {
        emit(ErrorLoginState());
      }
    } catch (e) {
      emit(ErrorLoginState());
    }
  }
}
