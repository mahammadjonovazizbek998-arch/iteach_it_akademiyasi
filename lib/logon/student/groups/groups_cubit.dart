import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:iteach_it_akademiyasi/data/repository/auth.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/group_class.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/student_groups_class.dart';
import 'package:iteach_it_akademiyasi/logon/api_cubit/api_cubit.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  final ApiCubit apiCubit;
  late final StreamSubscription _authSubscription;

  GroupsCubit({required this.apiCubit}) : super(GroupsInitial()) {
    todaysLessons();
    _authSubscription = apiCubit.stream.listen((apiState) {
      if (apiState is ApiError) {
        emit(GroupsError(error: apiState.error));
      }
    });
  }

  AuthRepository authRepository = AuthRepository();

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  void todaysLessons() {
    List<String> data = ["du", "se", "chor", "pay", "ju", "shan", "yak"];
    int today = 0;

    int dateTime = DateTime.now().weekday;
    if (apiCubit.state.studentGroupsClass != null) {
      List<StudentGroupsClass> stata = apiCubit.state.studentGroupsClass!;
      for (var i in stata) {
        for (var n in i.scheduleDays) {
          if (n.toLowerCase() == data[dateTime - 1].toLowerCase()) {
            today++;
          }
        }
      }
      final managedGroups = groupManagemen();
      time();
      final group = groupDetails(managedGroups);
      emit(
        GroupsFinish(
          today: today,
          startTime: time(),
          faol: managedGroups[0],
          noFaol: managedGroups[1],
          groupClasFaol: group[0],
          groupClasNoFaol: group[1],
        ),
      );
    }
  }

  List<List<StudentGroupsClass>> groupManagemen() {
    List<StudentGroupsClass> faolGroup = [];
    List<StudentGroupsClass> noFaolGroup = [];
    if (apiCubit.state.studentGroupsClass != null) {
      for (var i in apiCubit.state.studentGroupsClass!) {
        if (i.status == true) {
          faolGroup.add(i);
        } else {
          noFaolGroup.add(i);
        }
      }
      return [faolGroup, noFaolGroup];
    }
    return [[], []];
  }

  String time() {
    final now = TimeOfDay.now();
    if (apiCubit.state.studentGroupsClass != null) {
      final nowMinutes = now.hour * 60 + now.minute;
      String nearest = apiCubit.state.studentGroupsClass!.first.endTime;
      int minDiff = double.maxFinite.toInt();
      for (var list in apiCubit.state.studentGroupsClass!) {
        final parts = list.endTime.split(":");
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final timeM = hour * 60 + minute;
        final diff = (timeM - nowMinutes).abs();
        if (diff < minDiff) {
          minDiff = diff;
          nearest = list.endTime;
        }
      }
      return nearest;
    }
    return "00:00";
  }

  List<List<GroupClass>> groupDetails(
    List<List<StudentGroupsClass>> groupManagemen,
  ) {
    List<GroupClass> faolGroup = [];
    List<GroupClass> noFaolGroup = [];
    if (apiCubit.state.studentGroupsClass != null) {
      if (groupManagemen[0].isNotEmpty) {
        for (var i in groupManagemen[0]) {
          int index = apiCubit.state.studentGroupsClass!.indexWhere(
            (e) => e == i,
          );
          faolGroup.add(apiCubit.state.groupClass![index]);
        }
      }
      if (groupManagemen[1].isNotEmpty) {
        for (var i in groupManagemen[1]) {
          int index = apiCubit.state.studentGroupsClass!.indexWhere(
            (e) => e == i,
          );
          noFaolGroup.add(apiCubit.state.groupClass![index]);
        }
      }
      return [faolGroup, noFaolGroup];
    }
    return [[], []];
  }

  void contact(String tel) {
    authRepository.makeCall(tel);
  }

  void contactSms(String tel) {
    authRepository.sendSms(tel);
  }
}
