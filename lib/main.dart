import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/api_cubit/api_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/login/login_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/login/login_state.dart';
import 'package:iteach_it_akademiyasi/logon/theme/theme_cubit.dart';
import 'package:iteach_it_akademiyasi/presentation/login/login.dart';
import 'package:iteach_it_akademiyasi/presentation/student/student_home.dart';
import 'package:iteach_it_akademiyasi/presentation/teacher/teacher_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ThemeCubit()),
        BlocProvider(create: (ctx) => LoginCubit()),
        BlocProvider(create: (ctx) => ApiCubit(loginCubit: LoginCubit())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        final administration = BlocProvider.of<ThemeCubit>(context);
        return MaterialApp(
          supportedLocales: const [Locale('en'), Locale('uz'), Locale('ru')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale(administration.state.language!.name),
          title: 'Flutter Demo',
          theme: administration.state.theme!
              ? ThemeData.light().copyWith(extensions: [lightCustom])
              : ThemeData.dark().copyWith(extensions: [darkCustom]),
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<LoginCubit, LoginState>(
            builder: (ctx, state) {
              if (state is LoginLoding) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (state.token != null && state is LoginFinish) {
                if (state.token!.role == "student") {
                  return StudentHome();
                } else if (state.token!.role == "teacher") {
                  return TeacherHome();
                }
              }
              return Login();
            },
          ),
        );
      },
    );
  }
}
