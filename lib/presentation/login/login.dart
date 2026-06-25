import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/login/login_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/login/login_state.dart';
import 'package:iteach_it_akademiyasi/presentation/login/component/snack_bar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final Map<String, String> map = {"loginni": "", "parol": ""};

  void _onPressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context.read<LoginCubit>().signIn(map["loginni"]!, map["parol"]!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: .only(left: 20.w, right: 20.w, top: 70.h),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: .symmetric(vertical: 20.w, horizontal: 15.h),
                    height: 184.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          myTheme.logoBegin,
                          myTheme.logoBegin2,
                          myTheme.logoBegin3,
                          myTheme.logoBegin2,
                          myTheme.logoBegin,
                        ],
                        begin: .topLeft,
                        end: AlignmentGeometry.bottomRight,
                      ),
                      borderRadius: BorderRadius.vertical(top: .circular(20.r)),
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Image.asset("assets/logo/iTeach_logo.png"),
                        SizedBox(height: 10.h),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: .bold,
                              color: myTheme.text,
                            ),
                            children: [
                              TextSpan(text: "${myLanguage.iTeach} "),
                              TextSpan(
                                text: myLanguage.iT,
                                style: TextStyle(color: myTheme.textIT),
                              ),
                              TextSpan(text: " ${myLanguage.akademiyasi}"),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          myLanguage.logotext,
                          style: TextStyle(
                            color: myTheme.text,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: .only(left: 20.w, right: 20.w, bottom: 70.h),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: .symmetric(vertical: 13.w, horizontal: 15.h),
                    height: 340.h,
                    decoration: BoxDecoration(
                      color: myTheme.loginBackgroun,
                      borderRadius: BorderRadius.vertical(
                        bottom: .circular(20.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          " ${myLanguage.tizimga}",
                          style: TextStyle(fontWeight: .bold, fontSize: 25.sp),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          " ${myLanguage.hisobingizgaKiring}",
                          style: TextStyle(
                            color: myTheme.unselectedText,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Divider(color: myTheme.logoBegin2),
                        SizedBox(height: 5.h),
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            mainAxisSize: .min,
                            children: [
                              Text(
                                myLanguage.login,
                                style: TextStyle(
                                  color: myTheme.unselectedText,
                                  fontSize: 15.sp,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: myLanguage.enterLogin,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: myTheme.unselectedText,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: .circular(15.r),
                                  ),
                                ),
                                validator: (error) {
                                  if (error == null || error.isEmpty) {
                                    return myLanguage.loginCannotBeEmpty;
                                  }
                                  return null;
                                },
                                onSaved: (login) {
                                  map["loginni"] = login!;
                                },
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                myLanguage.password,
                                style: TextStyle(
                                  color: myTheme.unselectedText,
                                  fontSize: 15.sp,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              BlocBuilder<LoginCubit, LoginState>(
                                builder: (builderContext, holat) {
                                  return TextFormField(
                                    obscureText: holat.toHider,
                                    decoration: InputDecoration(
                                      labelText: myLanguage.enterPassword,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: myTheme.unselectedText,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            context.read<LoginCubit>().hider(),
                                        icon: Icon(
                                          holat.toHider
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: myTheme.unselectedText,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: .circular(15.r),
                                      ),
                                    ),
                                    validator: (parol) {
                                      if (parol == null || parol.isEmpty) {
                                        return myLanguage.passwordCannotBeEmpty;
                                      } else if (parol.length < 6) {
                                        return myLanguage.passwordTooShort;
                                      }
                                      return null;
                                    },
                                    onSaved: (parol) {
                                      map["parol"] = parol!;
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 19.h),
                              BlocConsumer<LoginCubit, LoginState>(
                                builder: (ctx, holat) {
                                  if (holat is LoginLoding) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ElevatedButton(
                                      onPressed: () => _onPressed(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: myTheme.logoBegin2,
                                        foregroundColor: myTheme.text,
                                        minimumSize: Size(
                                          double.infinity,
                                          40.h,
                                        ),
                                      ),
                                      child: Text(myLanguage.login),
                                    );
                                  }
                                },
                                listenWhen: (loginCubit, loginState) {
                                  return loginState is! LoginButton;
                                },
                                listener: (ctx, holat) {
                                  if (holat is LoginError) {
                                    if (holat.error.contains("Null") ||
                                        holat.error.contains(
                                          "Xatolik yuz berdi",
                                        )) {
                                      showiDalog(
                                        myLanguage.userNotFound,
                                        context,
                                      );
                                    } else if (holat.error.contains(
                                          "no_internet",
                                        ) ||
                                        holat.error.contains(
                                          "server_timeout",
                                        )) {
                                      showiDalog(
                                        myLanguage.serverConnectionError,
                                        context,
                                      );
                                    } else {
                                      showiDalog(holat.error, context);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
