import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/home_cubit/home_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/login/login_cubit.dart';
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
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (ctx) => LoginCubit()),
        BlocProvider(
          create: (_) => HomeCubit(loginCubit: context.read<LoginCubit>()),
        ),
      ],
      child: Builder(
        builder: (childContext) {
          return Scaffold(
            body: BlocBuilder<HomeCubit, HomeState>(
              builder: (childContext, stata) {
                if (stata is HomeLoding) {
                  return Center(child: CircularProgressIndicator());
                }
                return _pages[childContext
                    .read<HomeCubit>()
                    .state
                    .currentIndex];
              },
            ),
            bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
              builder: (childContext, stata) {
                return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  selectedItemColor: myTheme.selectedItemColor,
                  unselectedItemColor: myTheme.unselectedItemColor,
                  currentIndex: childContext
                      .read<HomeCubit>()
                      .state
                      .currentIndex,
                  onTap: (index) {
                    childContext.read<HomeCubit>().onItemTapped(index);
                  },
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon:
                          childContext.read<HomeCubit>().state.currentIndex == 0
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
                          childContext.read<HomeCubit>().state.currentIndex == 1
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
                      icon:  childContext.read<HomeCubit>().state.currentIndex == 2
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
                      ):Image.asset(
                        "assets/logo/to-do-list.png",
                        width: 20.w,
                        color: myTheme.unselectedItemColor,
                      ),
                      label: myLanguage.tasks,
                    ),
                    BottomNavigationBarItem(
                      icon: childContext.read<HomeCubit>().state.currentIndex == 3
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
                      ): Image.asset(
                        "assets/logo/bar-chart.png",
                        width: 20.w,
                        color:
                            childContext.read<HomeCubit>().state.currentIndex ==
                                3
                            ? myTheme.selectedItemColor
                            : myTheme.unselectedItemColor,
                      ),
                      label: myLanguage.rating,
                    ),
                    BottomNavigationBarItem(
                      icon:
                          childContext.read<HomeCubit>().state.currentIndex == 4
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
