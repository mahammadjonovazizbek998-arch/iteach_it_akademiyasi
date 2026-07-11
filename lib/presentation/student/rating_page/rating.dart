import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iteach_it_akademiyasi/data/language/app_localizations.dart';
import 'package:iteach_it_akademiyasi/data/theme/theme_class.dart';
import 'package:iteach_it_akademiyasi/logon/student/rating/rating_cubit.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final myLanguage = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(myLanguage.rating), centerTitle: true),
      body: BlocBuilder<RatingCubit, RatingState>(
        buildWhen: (ctx, state) {
          return state is! RatingData;
        },
        builder: (context, holat) {
          if (holat.leaderBoard == null) {
            return Center(child: Text(myLanguage.ratingLoading));
          } else if (holat is RatingError) {
            return Center(child: Text(myLanguage.ratingLoadError));
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: BlocBuilder<RatingCubit, RatingState>(
                    builder: (context, state) {
                      return Padding(
                        padding: .symmetric(horizontal: 15.w),
                        child: Card(
                          child: Row(
                            mainAxisAlignment: .center,
                            children: [
                              ActionChip(
                                label: SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    textAlign: .center,
                                    myLanguage.all,
                                    style: TextStyle(
                                      color: state.gurp == "all"
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                ),
                                onPressed: () => context
                                    .read<RatingCubit>()
                                    .deadline(state.data, state.page, "all"),
                                backgroundColor: state.gurp == "all"
                                    ? myTheme.profilColor
                                    : Colors.transparent,
                              ),
                              SizedBox(width: 10.w),

                              ActionChip(
                                label: SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    textAlign: .center,
                                    myLanguage.groups,
                                    style: TextStyle(
                                      color: state.gurp == "groups"
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                side: BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                ),
                                onPressed: () => context
                                    .read<RatingCubit>()
                                    .deadline(state.data, state.page, "groups"),
                                backgroundColor: state.gurp == "groups"
                                    ? myTheme.profilColor
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: BlocBuilder<RatingCubit, RatingState>(
                        builder: (context, state) {
                          return Padding(
                            padding: .symmetric(horizontal: 15.w),
                            child: Card(
                              child: Row(
                                mainAxisAlignment: .center,
                                children: [
                                  ActionChip(
                                    label: SizedBox(
                                      width: 60.w,
                                      child: Text(
                                        myLanguage.all,
                                        style: TextStyle(
                                          color: state.data == "all"
                                              ? Colors.white
                                              : myTheme.text,
                                        ),
                                      ),
                                    ),
                                    side: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                    onPressed: () =>
                                        context.read<RatingCubit>().deadline(
                                          "all",
                                          state.page,
                                          state.gurp,
                                        ),
                                    backgroundColor: state.data == "all"
                                        ? myTheme.profilColor
                                        : Colors.transparent,
                                  ),
                                  SizedBox(width: 10.w),
                                  ActionChip(
                                    label: SizedBox(
                                      width: 60.w,
                                      child: Text(
                                        textAlign: .center,
                                        myLanguage.month,
                                        style: TextStyle(
                                          color: state.data == "monthly"
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    side: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                    onPressed: () =>
                                        context.read<RatingCubit>().deadline(
                                          "monthly",
                                          state.page,
                                          state.gurp,
                                        ),
                                    backgroundColor: state.data == "monthly"
                                        ? myTheme.profilColor
                                        : Colors.transparent,
                                  ),
                                  SizedBox(width: 10.w),

                                  ActionChip(
                                    label: SizedBox(
                                      width: 60.w,
                                      child: Text(
                                        textAlign: .center,
                                        myLanguage.week,
                                        style: TextStyle(
                                          color: state.data == "weekly"
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    side: BorderSide(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                                    onPressed: () =>
                                        context.read<RatingCubit>().deadline(
                                          "weekly",
                                          state.page,
                                          state.gurp,
                                        ),
                                    backgroundColor: state.data == "weekly"
                                        ? myTheme.profilColor
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    context
                            .read<RatingCubit>()
                            .state
                            .leaderBoard!
                            .top3
                            .isNotEmpty
                        ? SliverPadding(
                            padding: .symmetric(
                              vertical: 15.h,
                              horizontal: 15.w,
                            ),
                            sliver: SliverMainAxisGroup(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Row(
                                    mainAxisAlignment: .spaceAround,
                                    crossAxisAlignment: .end,
                                    children: [
                                      holat.leaderBoard!.top3.length >= 2
                                          ? SizedBox(
                                              width: 90.w,
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Card(
                                                        elevation: 10.r,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadiusDirectional.circular(
                                                                41.r,
                                                              ),
                                                        ),
                                                        color: Color(
                                                          0xFFC0C0C0,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                3.r,
                                                              ),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Color(
                                                                  0xFF0B132B,
                                                                ),
                                                            radius: 38.r,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  holat
                                                                      .leaderBoard!
                                                                      .top3[1]
                                                                      .name
                                                                      .toString()
                                                                      .split(
                                                                        " ",
                                                                      )[0]
                                                                      .substring(
                                                                        0,
                                                                        1,
                                                                      ),
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        26.sp,
                                                                    fontWeight:
                                                                        .bold,
                                                                  ),
                                                                ),
                                                                if (holat
                                                                        .leaderBoard!
                                                                        .top3[1]
                                                                        .name
                                                                        .toString()
                                                                        .split(
                                                                          " ",
                                                                        )
                                                                        .length ==
                                                                    2)
                                                                  Text(
                                                                    holat
                                                                        .leaderBoard!
                                                                        .top3[1]
                                                                        .name
                                                                        .toString()
                                                                        .split(
                                                                          " ",
                                                                        )[1]
                                                                        .substring(
                                                                          0,
                                                                          1,
                                                                        ),
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          26.sp,
                                                                      fontWeight:
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        maxLines: 1,
                                                        overflow: .ellipsis,
                                                        holat
                                                            .leaderBoard!
                                                            .top3[1]
                                                            .name,
                                                        style: TextStyle(
                                                          fontWeight: .bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Text(
                                                        maxLines: 2,
                                                        "${holat.leaderBoard!.top3[1].score} ${myLanguage.score}",
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: myTheme
                                                              .profilColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.h),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    bottom: 28.h,
                                                    right: 29.w,
                                                    child: Card(
                                                      shape: CircleBorder(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8,
                                                            ),
                                                        child: Text(
                                                          holat
                                                              .leaderBoard!
                                                              .top3[1]
                                                              .rank
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(width: 90.w),
                                      holat.leaderBoard!.top3.length > 1
                                          ? SizedBox(
                                              width: 150,
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Card(
                                                        elevation: 10.r,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadiusDirectional.circular(
                                                                48.r,
                                                              ),
                                                        ),
                                                        color: Color(
                                                          0xFFFFD700,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                3.r,
                                                              ),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Color(
                                                                  0xFF1E88E5,
                                                                ),
                                                            radius: 45.r,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  holat
                                                                      .leaderBoard!
                                                                      .top3[0]
                                                                      .name
                                                                      .toString()
                                                                      .split(
                                                                        " ",
                                                                      )[0]
                                                                      .substring(
                                                                        0,
                                                                        1,
                                                                      ),
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        26.sp,
                                                                    fontWeight:
                                                                        .bold,
                                                                  ),
                                                                ),
                                                                if (holat
                                                                        .leaderBoard!
                                                                        .top3[0]
                                                                        .name
                                                                        .toString()
                                                                        .split(
                                                                          " ",
                                                                        )
                                                                        .length ==
                                                                    2)
                                                                  Text(
                                                                    holat
                                                                        .leaderBoard!
                                                                        .top3[0]
                                                                        .name
                                                                        .toString()
                                                                        .split(
                                                                          " ",
                                                                        )[1]
                                                                        .substring(
                                                                          0,
                                                                          1,
                                                                        ),
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          26.sp,
                                                                      fontWeight:
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Text(
                                                        maxLines: 1,
                                                        overflow: .ellipsis,
                                                        holat
                                                            .leaderBoard!
                                                            .top3[0]
                                                            .name,
                                                        style: TextStyle(
                                                          fontWeight: .bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Text(
                                                        maxLines: 2,
                                                        "${holat.leaderBoard!.top3[0].score} ${myLanguage.score}",
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: myTheme
                                                              .profilColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    bottom: 42,
                                                    right: 51.w,
                                                    child: Card(
                                                      shape: CircleBorder(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              11,
                                                            ),
                                                        child: Text(
                                                          holat
                                                              .leaderBoard!
                                                              .top3[0]
                                                              .rank
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(width: 150.w),
                                      holat.leaderBoard!.top3.length == 3
                                          ? SizedBox(
                                              width: 90.w,
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Card(
                                                        elevation: 10.r,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadiusDirectional.circular(
                                                                41.r,
                                                              ),
                                                        ),
                                                        color: Color(
                                                          0xFFCD7F32,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                3.r,
                                                              ),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Color(
                                                                  0xFF4A0E17,
                                                                ),
                                                            radius: 38.r,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  holat
                                                                      .leaderBoard!
                                                                      .top3[2]
                                                                      .name
                                                                      .toString()
                                                                      .split(
                                                                        " ",
                                                                      )[0]
                                                                      .substring(
                                                                        0,
                                                                        1,
                                                                      ),
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        26.sp,
                                                                    fontWeight:
                                                                        .bold,
                                                                  ),
                                                                ),
                                                                if (holat
                                                                        .leaderBoard!
                                                                        .top3[2]
                                                                        .name
                                                                        .toString()
                                                                        .split(
                                                                          " ",
                                                                        )
                                                                        .length ==
                                                                    2)
                                                                  Text(
                                                                    holat
                                                                        .leaderBoard!
                                                                        .top3[2]
                                                                        .name
                                                                        .toString()
                                                                        .split(
                                                                          " ",
                                                                        )[1]
                                                                        .substring(
                                                                          0,
                                                                          1,
                                                                        ),
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          26.sp,
                                                                      fontWeight:
                                                                          .bold,
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        maxLines: 1,
                                                        overflow: .ellipsis,
                                                        holat
                                                            .leaderBoard!
                                                            .top3[2]
                                                            .name,
                                                        style: TextStyle(
                                                          fontWeight: .bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Text(
                                                        maxLines: 2,
                                                        "${holat.leaderBoard!.top3[2].score} ${myLanguage.score}",
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: myTheme
                                                              .profilColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.h),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    bottom: 28.h,
                                                    right: 29.w,
                                                    child: Card(
                                                      shape: CircleBorder(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              8,
                                                            ),
                                                        child: Text(
                                                          holat
                                                              .leaderBoard!
                                                              .top3[2]
                                                              .rank
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(width: 90.w),
                                    ],
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: SizedBox(height: 10.h),
                                ),
                                SliverList.builder(
                                  itemCount: holat.leaderBoard!.top3.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        leading: Row(
                                          mainAxisSize: .min,
                                          children: [
                                            Text(
                                              holat
                                                  .leaderBoard!
                                                  .top3[index]
                                                  .rank
                                                  .toString(),
                                              style: TextStyle(
                                                color: myTheme.profilColor,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            SizedBox(width: 10.h),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusDirectional.circular(
                                                      20.r,
                                                    ),
                                              ),
                                              color: myTheme.selectedItemColor,
                                              child: Padding(
                                                padding: EdgeInsets.all(1.r),
                                                child: CircleAvatar(
                                                  radius: 18.r,
                                                  child: Row(
                                                    mainAxisAlignment: .center,
                                                    children: [
                                                      Text(
                                                        holat
                                                            .leaderBoard!
                                                            .top3[index]
                                                            .name
                                                            .toString()
                                                            .split(" ")[0]
                                                            .substring(0, 1),
                                                        style: TextStyle(
                                                          color: myTheme
                                                              .profilColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: .bold,
                                                        ),
                                                      ),
                                                      if (holat
                                                              .leaderBoard!
                                                              .top3[index]
                                                              .name
                                                              .toString()
                                                              .split(" ")
                                                              .length ==
                                                          2)
                                                        Text(
                                                          holat
                                                              .leaderBoard!
                                                              .top3[index]
                                                              .name
                                                              .toString()
                                                              .split(" ")[1]
                                                              .substring(0, 1),
                                                          style: TextStyle(
                                                            color: myTheme
                                                                .profilColor,
                                                            fontSize: 14.sp,
                                                            fontWeight: .bold,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        title: Text(
                                          holat.leaderBoard!.top3[index].name
                                              .toString(),
                                        ),
                                        trailing: Text(
                                          maxLines: 2,
                                          "${holat.leaderBoard!.top3[index].score}\n ${myLanguage.score}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: myTheme.profilColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SliverToBoxAdapter(),
                              ],
                            ),
                          )
                        : SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(child: Text(myLanguage.noDataFound)),
                          ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
