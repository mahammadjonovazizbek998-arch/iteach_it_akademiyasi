import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/student/tasks/tasks_cubit.dart';
import 'package:iteach_it_akademiyasi/presentation/student/tasks_page/componeta/new_tasks.dart';
import 'package:iteach_it_akademiyasi/presentation/student/tasks_page/componeta/sent_items.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(myLanguage.tasks), centerTitle: true),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksLoding) {
            return Center(child: Text(myLanguage.tasksLoading));
          } else if (state is TasksError) {
            return Center(child: Text(myLanguage.tasksLoadError));
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: Divider()),
                SliverPadding(
                  padding: .symmetric(horizontal: 15.w, vertical: 10.h),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Text(
                          myLanguage.greetingWithName(
                            state.iProfile!.fullName.split(" ")[0],
                          ),

                          style: TextStyle(fontSize: 22.sp, fontWeight: .bold),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 3.h)),
                      SliverToBoxAdapter(
                        child: Text(
                          myLanguage.greatDayToLearn,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: myTheme.unselectedText,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            ActionChip(
                              label: SizedBox(
                                width: 125.w,
                                height: 80.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 7.h,
                                    horizontal: 5.w,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: .spaceAround,
                                    crossAxisAlignment: .start,
                                    children: [
                                      Image.asset(
                                        "assets/logo/img.png",
                                        color: state.tasks == "assignments"
                                            ? myTheme.loginBackgroun
                                            : myTheme.text,
                                        height: 15.h,
                                      ),
                                      Text(
                                        myLanguage.fourItems(
                                          state.assignmentsGet!.length
                                              .toString(),
                                        ),
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: state.tasks == "assignments"
                                              ? myTheme.loginBackgroun
                                              : myTheme.text,
                                        ),
                                      ),
                                      Text(
                                        myLanguage.newTasks,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: state.tasks == "assignments"
                                              ? myTheme.loginBackgroun
                                              : myTheme.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              backgroundColor: state.tasks == "assignments"
                                  ? myTheme.profilColor
                                  : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: .circular(14.sp),
                              ),
                              onPressed: () {
                                context.read<TasksCubit>().assignments(
                                  "assignments",null,null
                                ,state.barchasi);
                              },
                            ),
                            ActionChip(
                              label: SizedBox(
                                width: 125.w,
                                height: 80.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 7.h,
                                    horizontal: 5.w,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: .spaceAround,
                                    crossAxisAlignment: .start,
                                    children: [
                                      Image.asset(
                                        "assets/logo/img_1.png",
                                        color: state.tasks == "submissions"
                                            ? myTheme.loginBackgroun
                                            : myTheme.text,
                                        height: 15.h,
                                      ),
                                      Text(
                                        myLanguage.fourItems(
                                          state.gradesGet!.length.toString(),
                                        ),
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: state.tasks == "submissions"
                                              ? myTheme.loginBackgroun
                                              : myTheme.text,
                                        ),
                                      ),
                                      Text(
                                        myLanguage.sentItems,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: state.tasks == "submissions"
                                              ? myTheme.loginBackgroun
                                              : myTheme.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              backgroundColor: state.tasks == "submissions"
                                  ? myTheme.profilColor
                                  : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: .circular(14.sp),
                              ),
                              onPressed: () {
                                context.read<TasksCubit>().assignments(
                                  "submissions",null,null,state.barchasi
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      if (state.tasks == "assignments")
                        SliverToBoxAdapter(child: Newtasks()),

                      if (state.tasks == "submissions")
                        SliverToBoxAdapter(child: SentItems()),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
