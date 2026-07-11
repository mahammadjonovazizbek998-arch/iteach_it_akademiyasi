import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/student/tasks/tasks_cubit.dart';

class Newtasks extends StatefulWidget {
  const Newtasks({super.key});

  @override
  State<Newtasks> createState() => _NewtasksState();
}

class _NewtasksState extends State<Newtasks> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(context)!;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: .min,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  myLanguage.tasks,
                  style: TextStyle(fontSize: 20.sp, fontWeight: .bold),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TasksCubit>().assignments(
                      null,
                      state.selectedIndex,
                      null,
                      !state.barchasi,
                    );
                  },
                  child: Text(
                    myLanguage.all,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: myTheme.profilColor,
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.assignmentsGet!.isEmpty
                  ? 1
                  : state.assignmentsGet!.length >= 2
                  ? state.barchasi?state.assignmentsGet!.length:2
                  : state.assignmentsGet!.length,
              itemBuilder: (context, index) {
                if ((state.assignmentsGet == null ||
                        state.assignmentsGet!.isEmpty) ||
                    state.groupClass == null ||
                    state.groupClass!.isEmpty) {
                  return SizedBox(
                    height: 200.h,
                    child: Center(child: Text(myLanguage.noTasksAvailable)),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      context.read<TasksCubit>().assignments(
                        null,
                        index,
                        null,
                        null
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: myTheme.unselectedText,
                        ),
                        borderRadius: .circular(10.r),
                      ),
                      child: state.assignmentsGet != index
                          ? ListTile(
                              title: Text(
                                state.groupClass![0].name,
                                style: TextStyle(fontSize: 17.sp),
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
                                  state.groupClass![index].name.substring(0, 1),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              titleAlignment: .center,
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    state.assignmentsGet![index].createdAt
                                        .split("T")[0],
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                  SizedBox(width: 10.w),
                                  Icon(Icons.access_time_outlined, size: 20.sp),
                                  SizedBox(width: 3.w),
                                  Text(
                                    state.assignmentsGet![index].createdAt
                                        .split("T")[1],
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 200.w,
                              child: Padding(
                                padding: .symmetric(
                                  vertical: 10.h,
                                  horizontal: 20.w,
                                ),
                                child: Column(
                                  mainAxisAlignment: .start,
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text(
                                      state.groupClass![0].name,
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                    Text(
                                      maxLines: 1,
                                      state.assignmentsGet![index].files.single,
                                      overflow: .ellipsis,
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    if (state
                                        .assignmentsGet![index]
                                        .description
                                        .isNotEmpty)
                                      Text(
                                        maxLines: 1,
                                        state
                                            .assignmentsGet![index]
                                            .description,
                                        overflow: .ellipsis,
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    SizedBox(height: 8.h),
                                    Divider(),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          size: 18.sp,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          state
                                              .assignmentsGet![index]
                                              .createdAt
                                              .split("T")[0],
                                          style: TextStyle(fontSize: 13.sp),
                                        ),
                                        SizedBox(width: 10.w),
                                        Icon(
                                          Icons.access_time_outlined,
                                          size: 20.sp,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          state
                                              .assignmentsGet![index]
                                              .createdAt
                                              .split("T")[1],
                                          style: TextStyle(fontSize: 13.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.h),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<TasksCubit>().assignments(
                                          null,
                                          null,
                                          "open",
                                          null
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 35.w,
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              color: myTheme.roleColor,
                                              borderRadius: .circular(10.r),
                                            ),
                                            alignment: .center,
                                            child: Image.asset(
                                              "assets/logo/img_3.png",
                                              width: 20.w,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              myLanguage.taskFiles,
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                          ),
                                          Icon(
                                            state.open == null
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            size: 30.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    if (state.open == null)
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state
                                            .assignmentsGet![index]
                                            .files
                                            .length,
                                        itemBuilder: (context, ind) {
                                          if (state
                                              .assignmentsGet![index]
                                              .files
                                              .isEmpty) {
                                            return SizedBox(
                                              height: 50.h,
                                              child: Center(
                                                child: Text(
                                                  myLanguage.noTasksAvailable,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: .symmetric(
                                                vertical: 8.w,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<TasksCubit>()
                                                      .fileManager(index, ind);
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: .circular(
                                                      10.r,
                                                    ),
                                                    side: BorderSide(
                                                      color: myTheme
                                                          .unselectedText,
                                                    ),
                                                  ),
                                                  child: ListTile(
                                                    leading: Image.asset(
                                                      "assets/logo/img_4.png",
                                                      width: 20.w,
                                                      color: Color(0xFFBA1C1C),
                                                    ),
                                                    title: Text(
                                                      maxLines: 2,
                                                      state
                                                          .assignmentsGet![index]
                                                          .files[ind],
                                                      overflow: .ellipsis,
                                                    ),
                                                    trailing: Image.asset(
                                                      "assets/logo/img_5.png",
                                                      width: 18.w,
                                                      color: myTheme
                                                          .unselectedText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    SizedBox(height: 10.h),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(.infinity, 35.h),
                                        backgroundColor: myTheme.profilColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: .center,
                                        children: [
                                          Image.asset(
                                            "assets/logo/img_2.png",
                                            height: 12.h,
                                          ),
                                          SizedBox(width: 5.h),
                                          Text(
                                            myLanguage.submitTask,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
