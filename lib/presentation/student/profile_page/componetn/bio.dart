// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/student/profile/profile_cubit.dart';

class Bio extends StatefulWidget {
  String? bioMatni;

  Bio({super.key, this.bioMatni});

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  late TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.bioMatni);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  String? bio;

  void _onPressed() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<ProfileCubit>().bio(bio!);
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
            padding: .directional(end: 10.w, start: 15.w, top: 10.h),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(myLanguage.editBio, style: TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          Divider(radius: .circular(1)),
          Padding(
            padding: .directional(
              end: 10.w,
              start: 15.w,
              top: 7.h,
              bottom: 6.h,
            ),
            child: Text(
              myLanguage.personalInfo,
              style: TextStyle(fontSize: 14.sp, color: myTheme.unselectedText),
            ),
          ),

          Form(
            key: formKey,
            child: Padding(
              padding: .directional(
                end: 15.w,
                start: 15.w,
                top: 7.h,
                bottom: 6.h,
              ),
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (save) {
                      bio = save;
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    validator: (e) {
                      if (widget.bioMatni == e) {
                        return myLanguage.noChangesDetected;
                      } else {
                        return null;
                      }
                    },
                    maxLines: 4,
                  ),
                  SizedBox(height: 20.h),

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
                          onPressed: () => _onPressed(),
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
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
