
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';

class Component extends StatelessWidget {
 final int today;
 final String startTime;
  const Component({super.key,required this.today,required this.startTime});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(context)!;
    return Container(
      padding: .symmetric(vertical: 20.w, horizontal: 20.h),
      width: 320.w,
      height: 138.h,
      decoration: BoxDecoration(
        color: myTheme.containerBuilder,
        borderRadius: .circular(25),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Text(
                myLanguage.todaysLessons,
                style: TextStyle(
                  color: myTheme.unselectedText,
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                myLanguage.lessonsCount(today),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: .bold,
                ),
              ),
              SizedBox(height: 13.h),
              Container(
                padding: .symmetric(horizontal: 13.h),
                height: 30.h,
                decoration: BoxDecoration(
                  color: myTheme.dataColor,
                  borderRadius: .circular(18.r),
                ),
                child: Row(
                  crossAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: Colors.white,
                      weight: 5,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      myLanguage.lessonTime(startTime),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
