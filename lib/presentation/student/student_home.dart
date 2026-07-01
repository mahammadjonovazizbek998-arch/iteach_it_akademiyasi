import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/api_cubit/api_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/student/groups/groups_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/student/profile/profile_cubit.dart';
import 'package:iteach_it_akademiyasi/presentation/student/groups_page/groups.dart';
import 'package:iteach_it_akademiyasi/presentation/student/home_page/home.dart';
import 'package:iteach_it_akademiyasi/presentation/student/profile_page/profile.dart';
import 'package:iteach_it_akademiyasi/presentation/student/rating_page/rating.dart';
import 'package:iteach_it_akademiyasi/presentation/student/tasks_page/tasks.dart';

class StudentHome extends StatelessWidget {
  StudentHome({super.key});

  final List<Widget> _pages = <Widget>[
    HomePage(),
    GroupsPage(),
    TasksPage(),
    RatingPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext childContex) {
    final myTheme = Theme.of(childContex).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(childContex)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ProfileCubit(apiCubit: ctx.read<ApiCubit>()),
        ),
        BlocProvider(
          create: (context) => GroupsCubit(apiCubit: context.read<ApiCubit>()),
        ),
      ],
      child: Builder(
        builder: (contex) {
          return Scaffold(
            body: BlocBuilder<ApiCubit, ApiState>(
              builder: (childContext, stata) {
                if (stata is ApiLoding) {
                  return Center(child: CircularProgressIndicator());
                }
                return _pages[stata.currentIndex];
              },
            ),
            bottomNavigationBar: BlocBuilder<ApiCubit, ApiState>(
              builder: (childContext, stata) {
                return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  selectedItemColor: myTheme.selectedItemColor,
                  unselectedItemColor: myTheme.unselectedItemColor,
                  currentIndex: childContext
                      .read<ApiCubit>()
                      .state
                      .currentIndex,
                  onTap: (index) {
                    childContext.read<ApiCubit>().onItemTapped(index);
                  },
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon:
                          childContext.read<ApiCubit>().state.currentIndex == 0
                          ? Container(
                              padding: .all(10),
                              decoration: BoxDecoration(
                                color: myTheme.selectedItemColor,
                                borderRadius: .circular(25.r),
                              ),
                              child: Icon(
                                Icons.home_outlined,
                                size: 25.sp,
                                color: myTheme.unselectedItemColor,
                              ),
                            )
                          : Icon(Icons.home, size: 30.sp),
                      label: myLanguage.home,
                    ),
                    BottomNavigationBarItem(
                      icon:
                          childContext.read<ApiCubit>().state.currentIndex == 1
                          ? Container(
                              padding: .all(10.sp),
                              decoration: BoxDecoration(
                                color: myTheme.selectedItemColor,
                                borderRadius: .circular(25.r),
                              ),
                              child: Image.asset(
                                "assets/logo/layers.png",
                                width: 20.w,
                                color: myTheme.unselectedItemColor,
                              ),
                            )
                          : Image.asset(
                              "assets/logo/layer.png",
                              width: 20.w,
                              color: myTheme.unselectedItemColor,
                            ),
                      label: myLanguage.groups,
                    ),
                    BottomNavigationBarItem(
                      icon:
                          childContext.read<ApiCubit>().state.currentIndex == 2
                          ? Container(
                              padding: .all(10.sp),
                              decoration: BoxDecoration(
                                color: myTheme.selectedItemColor,
                                borderRadius: .circular(25),
                              ),
                              child: Image.asset(
                                "assets/logo/to-do-list(1).png",
                                width: 20.w,
                                color: myTheme.unselectedItemColor,
                              ),
                            )
                          : Image.asset(
                              "assets/logo/to-do-list.png",
                              width: 20.w,
                              color: myTheme.unselectedItemColor,
                            ),
                      label: myLanguage.tasks,
                    ),
                    BottomNavigationBarItem(
                      icon:
                          childContext.read<ApiCubit>().state.currentIndex == 3
                          ? Container(
                              padding: .all(10.sp),
                              decoration: BoxDecoration(
                                color: myTheme.selectedItemColor,
                                borderRadius: .circular(25),
                              ),
                              child: Image.asset(
                                "assets/logo/bar-chart(2).png",
                                width: 20.w,
                                color: myTheme.unselectedItemColor,
                              ),
                            )
                          : Image.asset(
                              "assets/logo/bar-chart.png",
                              width: 20.w,
                              color:
                                  childContext
                                          .read<ApiCubit>()
                                          .state
                                          .currentIndex ==
                                      3
                                  ? myTheme.selectedItemColor
                                  : myTheme.unselectedItemColor,
                            ),
                      label: myLanguage.rating,
                    ),
                    BottomNavigationBarItem(
                      icon:
                          childContext.read<ApiCubit>().state.currentIndex == 4
                          ? Container(
                              padding: .all(10.sp),
                              decoration: BoxDecoration(
                                color: myTheme.selectedItemColor,
                                borderRadius: .circular(25),
                              ),
                              child: Icon(
                                Icons.perm_identity_outlined,
                                size: 25.sp,
                                color: myTheme.unselectedItemColor,
                              ),
                            )
                          : Icon(Icons.person),
                      label: myLanguage.profile,
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
