import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/student_groups_class.dart';
import 'package:iteach_it_akademiyasi/logon/home_cubit/home_cubit.dart';
import 'package:iteach_it_akademiyasi/presentation/student/groups_page/component/component.dart';
import 'package:iteach_it_akademiyasi/presentation/student/groups_page/component/groups_component.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myLanguage = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(myLanguage.groups),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.studentGroupsClass != null &&
              (state.faol != null || state.noFaol != null)) {
            return CustomScrollView(
              slivers: [
                if (state.studentGroupsClass != null)
                  SliverPadding(
                    padding: .symmetric(vertical: 15.w, horizontal: 15.h),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        if (state.today != 0)
                          SliverToBoxAdapter(
                            child: Component(
                              today: state.today,
                              startTime: state.startTime
                                  .substring(0, 5)
                                  .toString(),
                            ),
                          ),
                        SliverToBoxAdapter(child: SizedBox(height: 13.h)),
                        if (state.faol != null && state.faol!.isNotEmpty)
                          SliverMainAxisGroup(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Text(
                                  myLanguage.activeGroups,
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                              SliverList.builder(
                                itemCount: state.faol!.length,
                                itemBuilder: (ctx, index) {
                                  StudentGroupsClass studentGroupsClass =
                                      state.faol![index];
                                  return GroupsComponent(
                                    studentGroupsClass: studentGroupsClass,groupClas: state.groupClasFaol![index],
                                  );
                                },
                              ),
                            ],
                          ),
                        if (state.noFaol != null && state.noFaol!.isNotEmpty)
                          SliverMainAxisGroup(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Text(
                                  myLanguage.inactiveGroups,
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                              SliverList.builder(
                                itemCount: state.noFaol!.length,
                                itemBuilder: (ctx, index) {
                                  StudentGroupsClass studentGroupsClass =
                                  state.noFaol![index];
                                  return GroupsComponent(
                                    studentGroupsClass: studentGroupsClass,groupClas: state.groupClasNoFaol![index],
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
              ],
            );
          }
          return Center(child: Text(myLanguage.emptyGroups));
        },
      ),
    );
  }
}
