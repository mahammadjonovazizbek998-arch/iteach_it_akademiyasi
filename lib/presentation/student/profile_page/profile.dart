import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/api_cubit/api_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/student/profile/profile_cubit.dart';
import 'package:iteach_it_akademiyasi/presentation/student/profile_page/componetn/bio.dart';
import 'package:iteach_it_akademiyasi/presentation/student/profile_page/componetn/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _rri(BuildContext ctx) async {
    ctx.read<ApiCubit>().userProfile();
  }

  @override
  Widget build(BuildContext context) {
    final myLanguage = AppLocalizations.of(context)!;
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          myLanguage.profile,
          style: TextStyle(color: myTheme.profilColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined, color: myTheme.profilColor),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (childContex, state) {
          return state is! SecondaryActions;
        },
        builder: (childContex, state) {
          if (state.iProfile != null && state.usersProfile != null) {
            return RefreshIndicator(
              onRefresh: () => _rri(context),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: Divider(radius: .circular(1))),
                  SliverToBoxAdapter(child: SizedBox(height: 30.h)),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: .center,
                      child: Card(
                        elevation: 10.r,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(62.r),
                        ),
                        color: state.iProfile!.isActive
                            ? myTheme.selectedItemColor
                            : Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(3.r),
                          child: CircleAvatar(
                            radius: 60.r,
                            child: Text(
                              state.iProfile!.fullName.toString().substring(
                                0,
                                1,
                              ),
                              style: TextStyle(
                                color: myTheme.profilColor,
                                fontSize: 35.sp,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: .center,
                      child: Text(
                        state.iProfile!.fullName,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 5.h)),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: .center,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: .circular(18.r),
                          color: myTheme.roleColor,
                        ),
                        child: Padding(
                          padding: .symmetric(vertical: 7.w, horizontal: 15.h),
                          child: Text(
                            state.iProfile!.role.toUpperCase(),
                            style: TextStyle(
                              color: myTheme.profilColor,
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: Card(
                        child: SizedBox(
                          width: .infinity,
                          child: Column(
                            mainAxisSize: .min,
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                              Padding(
                                padding: .only(left: 15.h, top: 25.w),
                                child: Text(
                                  myLanguage.data,
                                  style: TextStyle(
                                    color: myTheme.unselectedText,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),

                              ListTile(
                                leading: Card(
                                  child: Padding(
                                    padding: .all(8),
                                    child: Icon(
                                      Icons.login,
                                      color: myTheme.profilColor,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  myLanguage.loginLabel,
                                  style: TextStyle(
                                    color: myTheme.unselectedText,
                                  ),
                                ),
                                subtitle: Text(
                                  state.iProfile!.login,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                              ListTile(
                                leading: Card(
                                  child: Padding(
                                    padding: .all(8),
                                    child: Icon(
                                      Icons.phone,
                                      color: myTheme.profilColor,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  myLanguage.phoneNumber,
                                  style: TextStyle(
                                    color: myTheme.unselectedText,
                                  ),
                                ),
                                subtitle: Text(
                                  state.iProfile!.phoneNumber,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Column(
                            mainAxisSize: .min,
                            crossAxisAlignment: .start,
                            mainAxisAlignment: .start,
                            children: [
                              ListTile(
                                title: Text(
                                  myLanguage.biography,
                                  style: TextStyle(
                                    color: myTheme.unselectedText,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: childContex,
                                      barrierDismissible: false,
                                      builder: (dialogContex) {
                                        return BlocProvider.value(
                                          value: childContex
                                              .read<ProfileCubit>(),
                                          child: Bio(
                                            bioMatni: state.usersProfile?.bio,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.edit_outlined),
                                ),
                              ),
                              state.usersProfile!.bio.isNotEmpty
                                  ? Padding(
                                      padding: .only(left: 14.h, bottom: 15.w),
                                      child: Text(
                                        state.usersProfile!.bio,
                                        textAlign: .start,
                                      ),
                                    )
                                  : Padding(
                                      padding: .only(left: 14.h, bottom: 15.w),
                                      child: Text(
                                        myLanguage.biographyFieldEmpty,
                                        textAlign: .start,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: .symmetric(horizontal: 15.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myTheme.profilColor,
                          foregroundColor: Colors.white,
                          padding: .symmetric(vertical: 10.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(10),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: childContex,
                            barrierDismissible: false,
                            builder: (dialogContex) {
                              return BlocProvider.value(
                                value: childContex.read<ProfileCubit>(),
                                child: Profile(
                                  fullName: state.iProfile!.fullName,
                                  phoneNumber: state.iProfile!.phoneNumber,
                                  login: state.iProfile!.login,
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: .center,
                          children: [
                            Icon(Icons.edit_outlined),
                            SizedBox(width: 5.w),
                            Text(myLanguage.editProfile),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _rri(context),
            child: Center(child: Text(myLanguage.profileLoading)),
          );
        },
      ),
    );
  }
}
