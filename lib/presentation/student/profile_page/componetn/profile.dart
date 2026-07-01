import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/student/profile/profile_cubit.dart';

class Profile extends StatefulWidget {
  final String fullName;
  final String login;
  final String phoneNumber;

  const Profile({
    super.key,
    required this.login,
    required this.fullName,
    required this.phoneNumber,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _fullName = TextEditingController();
  late TextEditingController _login = TextEditingController();
  late TextEditingController _phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullName = TextEditingController(text: widget.fullName);
    _login = TextEditingController(text: widget.login);
    _phoneNumber = TextEditingController(
      text: widget.phoneNumber.trim().replaceAll(" ", ""),
    );
  }

  @override
  void dispose() {
    _fullName.dispose();
    _login.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  String? fullName;
  String? login;
  String? password;
  String? phoneNumber;

  void _onPressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<ProfileCubit>().putProfile(
        fullName!,
        login!,
        password!,
        phoneNumber!
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final myLanguage = AppLocalizations.of(context)!;
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: .circular(20.r)),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Padding(
            padding: .directional(end: 10.w, start: 15.w, top: 15.h),
            child: SizedBox(
              width: 320.w,
              child: Row(
                mainAxisSize: .min,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      myLanguage.editPersonalInfo,
                      style: TextStyle(fontSize: 18, overflow: .ellipsis),
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
          Divider(radius: .circular(1)),
          Form(
            key: formKey,
            child: Padding(
              padding: .symmetric(vertical: 15.w, horizontal: 15.h),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                mainAxisAlignment: .start,
                children: [
                  Text(myLanguage.phoneNumber),
                  TextFormField(
                    keyboardType: .text,
                    controller: _fullName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.perm_identity),

                      border: OutlineInputBorder(borderRadius: .circular(10.r)),
                    ),
                    validator: (e) {
                      if (e == null || e.isEmpty || e.length < 3) {
                        return myLanguage.invalidFullName;
                      } else {
                        return null;
                      }
                    },
                    onSaved: (saved) {
                      fullName = saved!;
                    },
                  ),
                  SizedBox(height: 15.h),
                  Text(myLanguage.loginLabel),
                  TextFormField(
                    controller: _login,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      border: OutlineInputBorder(borderRadius: .circular(10.r)),
                    ),
                    validator: (error) {
                      if (error == null || error.isEmpty || error.length < 4) {
                        return myLanguage.loginCannotBeEmpty;
                      } else {
                        return null;
                      }
                    },
                    onSaved: (saved) {
                      login = saved!;
                    },
                  ),
                  SizedBox(height: 15.h),
                  Text(myLanguage.phoneNumber),
                  TextFormField(
                    keyboardType: .phone,
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(borderRadius: .circular(10.r)),
                    ),
                    validator: (e) {
                      if (e == null || e.isEmpty || e.length != 13) {
                        return myLanguage.invalidPhoneNumber;
                      } else {
                        return null;
                      }
                    },
                    onSaved: (saved) {
                      phoneNumber = saved!;
                    },
                  ),
                  SizedBox(height: 15.h),
                  Text(myLanguage.password),
                  TextFormField(
                    obscureText: context.watch<ProfileCubit>().state.parol,
                    decoration: InputDecoration(
                      hintText: myLanguage.password,
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(borderRadius: .circular(10.r)),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            context.read<ProfileCubit>().password(),
                        icon: Icon(
                          context.watch<ProfileCubit>().state.parol
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: myTheme.unselectedText,
                        ),
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
                    onSaved: (saved) {
                      password = saved!;
                    },
                  ),
                  SizedBox(height: 10.h),
                  BlocConsumer<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoding) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: myTheme.profilColor,
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 35.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: .circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: myTheme.profilColor,
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 35.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: .circular(10),
                            ),
                          ),
                          onPressed: () => _onPressed(),
                          child: Text(myLanguage.save),
                        );
                      }
                    },
                    listener: (blocContext, state) {
                      if (state is ProfileFinish) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(height: 5.h),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 35.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(10),
                      ),
                    ),
                    child: Text(myLanguage.cancel),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
