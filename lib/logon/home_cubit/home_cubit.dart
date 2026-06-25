import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:iteach_it_akademiyasi/data/repository/auth.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/group_class.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/student_groups_class.dart';

import 'package:iteach_it_akademiyasi/logon/login/login_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/login/login_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LoginCubit loginCubit;
  late final StreamSubscription _authSubscription;

  HomeCubit({required this.loginCubit}) : super(HomeInitial(currentIndex: 0)) {
    studentGroups();
    _authSubscription = loginCubit.stream.listen((loginState) {
      if (loginState is LoginSignOut) {
        emit(HomeInitial(currentIndex: 0));
      }
    });
  }

  AuthRepository authRepository = AuthRepository();

  void onItemTapped(int index) {
    emit(
      HomeFinish(
        today: state.today,
        currentIndex: index,
        studentGroupsClass: state.studentGroupsClass,
        groupClass: state.groupClass,
        startTime: state.startTime,
        faol: state.faol,
        noFaol: state.noFaol,
        groupClasFaol: state.groupClasFaol,
        groupClasNoFaol: state.groupClasNoFaol,
      ),
    );
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  Future<void> studentGroups() async {
    emit(HomeLoding(currentIndex: state.currentIndex));
    if (loginCubit.state.token?.accessToken != null) {
      final result = await Future.wait([
        authRepository.studentGroup(loginCubit.state.token!.accessToken!),
        authRepository.groupName(),
      ]);
      final student = result[0];
      final groupName = result[1];
      if (student is String) {
        if (groupName == "401") {
          await loginCubit.refreshToken();
          return studentGroups();
        }
        emit(HomeError(currentIndex: state.currentIndex, error: student));
      } else if (groups is String) {
        emit(HomeError(currentIndex: state.currentIndex, error: groupName));
      } else {
        await groups(student, groupName);
      }
    }
  }

  Future<void> groups(
    List<StudentGroupsClass>? stata,
    List<NameGroups>? name,
  ) async {
    if (stata != null && name != null) {
      List<GroupClass> list = [];
      for (int i = 0; i < stata.length; i++) {
        String groupsName = stata[i].name;
        int id = name.indexWhere(
          (e) => groupsName.toLowerCase().contains(e.name.toLowerCase()),
        );
        if (id != -1) {
          final response = await authRepository.group(name[id].id);
          if (response is GroupClass) {
            list.add(response);
          } else {
            emit(HomeError(currentIndex: state.currentIndex, error: response));
          }
        }
      }
      emit(
        HomeFinish(
          currentIndex: state.currentIndex,
          studentGroupsClass: stata,
          groupClass: list,
          today: state.today,
          startTime: state.startTime,
          faol: state.faol,
          noFaol: state.noFaol,
          groupClasNoFaol: state.groupClasNoFaol,
          groupClasFaol: state.groupClasFaol,
        ),
      );
      todaysLessons();
    }
  }

  void todaysLessons() {
    List<String> data = ["du", "se", "chor", "pay", "ju", "shan", "yak"];
    int today = 0;

    int dateTime = DateTime.now().weekday;
    if (state.studentGroupsClass != null) {
      List<StudentGroupsClass> stata = state.studentGroupsClass!;
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
        HomeFinish(
          currentIndex: state.currentIndex,
          studentGroupsClass: state.studentGroupsClass,
          groupClass: state.groupClass,
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
    if (state.studentGroupsClass != null) {
      for (var i in state.studentGroupsClass!) {
        if (i.status == true) {
          faolGroup.add(i);
        } else {
          noFaolGroup.add(i);
        }
      }
      return [faolGroup, noFaolGroup];
    }
    return [[],[]];
  }

  String time() {
    final now = TimeOfDay.now();
    if (state.studentGroupsClass != null) {
      final nowMinutes = now.hour * 60 + now.minute;
      String nearest = state.studentGroupsClass!.first.endTime;
      int minDiff = double.maxFinite.toInt();
      for (var list in state.studentGroupsClass!) {
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
    if (state.studentGroupsClass != null) {
      if (groupManagemen[0].isNotEmpty) {
        for (var i in groupManagemen[0]) {
          int index = state.studentGroupsClass!.indexWhere((e) => e == i);
          faolGroup.add(state.groupClass![index]);
        }
      }
      if (groupManagemen[1].isNotEmpty) {
        for (var i in groupManagemen[1]) {
          int index = state.studentGroupsClass!.indexWhere((e) => e == i);
          noFaolGroup.add(state.groupClass![index]);
        }
      }
      return [faolGroup, noFaolGroup];
    }
    return [[],[]];
  }
   void contact(String tel){
     authRepository.makeCall(tel);
   }
   void contactSms(String tel){
     authRepository.sendSms(tel);
   }
}
