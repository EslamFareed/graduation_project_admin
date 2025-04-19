import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_admin/core/utils/shared_helper.dart';
import 'package:graduation_project_admin/screens/admins/cubit/admins_cubit.dart';
import 'package:graduation_project_admin/screens/login/cubit/login_cubit.dart';
import 'package:graduation_project_admin/screens/universities/cubit/universities_cubit.dart';

import 'firebase_options.dart';
import 'screens/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => AdminsCubit()),
        BlocProvider(create: (context) => UniversitiesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
