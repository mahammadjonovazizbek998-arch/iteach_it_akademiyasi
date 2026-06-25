import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/group_class.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/student_groups_class.dart';
import 'package:iteach_it_akademiyasi/logon/home_cubit/home_cubit.dart';

class GroupsComponent extends StatelessWidget {
  final StudentGroupsClass studentGroupsClass;
  final GroupClass? groupClas;

  const GroupsComponent({
    super.key,
    required this.studentGroupsClass,
    required this.groupClas,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: .all(2.r),
        child: Column(
          children: [
            ListTile(
              title: Text(
                studentGroupsClass.name,
                style: TextStyle(fontSize: 17.sp),
              ),
              subtitle: studentGroupsClass.status
                  ? Row(
                      mainAxisSize: .min,
                      crossAxisAlignment: .center,
                      children: [
                        Container(
                          width: 7.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: .circular(4.r),
                            color: Color(0xFF4BDE81),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          myLanguage.active,
                          style: TextStyle(
                            color: Color(0xFF4BDE81),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisSize: .min,
                      crossAxisAlignment: .center,
                      children: [
                        Container(
                          width: 7.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: .circular(4.r),
                            color: Color(0xFFBA1C1C),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          myLanguage.inactive,
                          style: TextStyle(
                            color: Color(0xFFBA1C1C),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
              leading: Container(
                width: 40.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Color(0xFF5047E5),
                  borderRadius: .circular(10.r),
                ),
                alignment: .center,
                child: Text(
                  studentGroupsClass.name.substring(0, 1),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              titleAlignment: .center,
              trailing: GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert, color: myTheme.unselectedText),
              ),
            ),
            Container(
              margin: .symmetric(horizontal: 10.h),
              padding: .symmetric(horizontal: 10.h),
              width: .infinity,
              height: 30.h,
              decoration: BoxDecoration(
                color: Color(0xFF202B3D),
                borderRadius: .circular(10.r),
              ),
              alignment: .centerLeft,
              child: Row(
                mainAxisSize: .min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: myTheme.containerBuilder,
                    size: 20.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    studentGroupsClass.scheduleDays.toString().substring(1, 13),
                    style: TextStyle(color: Colors.white54),
                  ),
                  SizedBox(width: 20.w),
                  Icon(
                    Icons.access_time_outlined,
                    color: myTheme.containerBuilder,
                    size: 20.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${studentGroupsClass.endTime.toString().substring(0, 5)} - ${studentGroupsClass.startTime.toString().substring(0, 5)}",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                groupClas!.teachers[0].fullName,
                maxLines: 1,
                overflow: .ellipsis,
              ),
              subtitle: Text(groupClas!.teachers[0].phoneNumber, maxLines: 1),
              leading: Container(
                width: 38.w,
                height: 33.h,
                decoration: BoxDecoration(
                  color: myTheme.dataColor,
                  borderRadius: .circular(20),
                ),
                alignment: .center,
                child: Text(
                  groupClas!.teachers[0].fullName.substring(0, 1),
                  style: TextStyle(color: Colors.white, fontSize: 17.sp),
                ),
              ),
              trailing: Row(
                mainAxisSize: .min,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 3,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.read<HomeCubit>().contactSms(groupClas!.teachers[0].phoneNumber);
                        },
                        child: Icon(Icons.message_outlined),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 3,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.read<HomeCubit>().contact(groupClas!.teachers[0].phoneNumber);
                        },
                        child: Icon(Icons.phone),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
