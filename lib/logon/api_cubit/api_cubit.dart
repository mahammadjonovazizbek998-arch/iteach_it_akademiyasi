import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:iteach_it_akademiyasi/data/repository/auth.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/group_class.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/student_groups_class.dart';
import 'package:iteach_it_akademiyasi/data/users/leaderBoard/leader_board.dart';
import 'package:iteach_it_akademiyasi/data/users/tasks/assignments/assignments_get.dart';
import 'package:iteach_it_akademiyasi/data/users/tasks/submissions/submissions_get.dart';
import 'package:iteach_it_akademiyasi/data/users/users/users.dart';
import 'package:iteach_it_akademiyasi/data/users/users/users_profile.dart';

import 'package:iteach_it_akademiyasi/logon/login/login_cubit.dart';
import 'package:iteach_it_akademiyasi/logon/login/login_state.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final LoginCubit loginCubit;
  late final StreamSubscription _authSubscription;

  ApiCubit({required this.loginCubit}) : super(ApiInitial(currentIndex: 2)) {
    if (loginCubit.state.token != null) {
      start();
    }
    _authSubscription = loginCubit.stream.listen((loginState) {
      if (loginState is LoginSignOut) {
        emit(ApiInitial(currentIndex: 0));
      }
    });
  }

  AuthRepository authRepository = AuthRepository();

  void onItemTapped(int index) {
    emit(
      ApiFinish(
        currentIndex: index,
        studentGroupsClass: state.studentGroupsClass,
        groupClass: state.groupClass,
        iProfile: state.iProfile,
        usersProfile: state.usersProfile,
        leaderBoard: state.leaderBoard,
        assignmentsGet: state.assignmentsGet,
        gradesGet: state.gradesGet,
        submissionsGet: state.submissionsGet,
      ),
    );
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  Future<void> start() async {
    emit(ApiLoding(currentIndex: state.currentIndex));
    if (loginCubit.state.token?.accessToken != null) {
      final result = await Future.wait([
        authRepository.studentGroup(loginCubit.state.token!.accessToken!),
        authRepository.groupName(),
        authRepository.iProfile(loginCubit.state.token!.accessToken!),
        authRepository.profilr(loginCubit.state.token!.accessToken!),
        authRepository.leaderBoard(
          loginCubit.state.token!.accessToken!,
          "all",
          1,
          null,
        ),
        authRepository.assignmentsGet(
          loginCubit.state.token!.accessToken!,
          "10",
          "0",
          null,
        ),
        authRepository.submissionsGet(
          loginCubit.state.token!.accessToken!,
          "10",
          "0",
        ),
        authRepository.gradesGet(
          loginCubit.state.token!.accessToken!,
          "10",
          "0",
        ),
      ]);
      if (result[0] is String ||
          result[1] is String ||
          result[2] is String ||
          result[3] is String ||
          result[4] is String ||
          result[5] is String ||
          result[6] is String ||
          result[7] is String) {
        if (result[0] == "401" ||
            result[1] == "401" ||
            result[2] == "401" ||
            result[3] == "401" ||
            result[4] == "401" ||
            result[5] == "401" ||
            result[6] == "401" ||
            result[7] == "401") {
          await loginCubit.refreshToken();
          return start();
        } else {
          if (result[0] is String || result[1] is String) {
            return studentGroups();
          }
          if (result[2] is String || result[3] is String) {
            return userProfile();
          }
          if (result[4] is String) {
            leaderBoard("all", 1, null);
          }
          if (result[5] is String ||
              result[6] is String ||
              result[7] is String) {
            tasksGet("10", "0", null);
          }
        }
      } else {
        await groups(
          result[0],
          result[1],
          result[2],
          result[3],
          result[4],
          result[5],
          result[6],
          result[7],
        );
      }
    }
  }

  Future<void> studentGroups() async {
    emit(ApiLoding(currentIndex: state.currentIndex));
    if (loginCubit.state.token?.accessToken != null) {
      final result = await Future.wait([
        authRepository.studentGroup(loginCubit.state.token!.accessToken!),
        authRepository.groupName(),
      ]);
      if (isClosed) return;
      final student = result[0];
      final groupName = result[1];
      if (student is String) {
        if (groupName == "401") {
          await loginCubit.refreshToken();
          return studentGroups();
        }
        emit(ApiError(currentIndex: state.currentIndex, error: student));
      } else if (groupName is String) {
        emit(ApiError(currentIndex: state.currentIndex, error: groupName));
      } else {
        await groups(
          student,
          groupName,
          state.iProfile,
          state.usersProfile,
          state.leaderBoard,
          state.assignmentsGet,
          state.submissionsGet,
          state.gradesGet,
        );
      }
    }
  }

  Future<void> groups(
    List<StudentGroupsClass>? stata,
    List<NameGroups>? name,
    IProfile? iProfile,
    UsersProfile? usersProfile,
    LeaderBoard? leaderBoard,
    List<AssignmentsGet>? assignmentsGet,
    List<SubmissionsGet>? submissionsGet,
    List<SubmissionsGet>? gradesGet,
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
            emit(ApiError(currentIndex: state.currentIndex, error: response));
          }
        }
      }

      emit(
        ApiFinish(
          currentIndex: state.currentIndex,
          studentGroupsClass: stata,
          groupClass: list,
          usersProfile:usersProfile,
          iProfile: iProfile,
          leaderBoard: leaderBoard,
          assignmentsGet:assignmentsGet,
          gradesGet: gradesGet,
          submissionsGet: submissionsGet,
        ),
      );
    }
  }

  Future<void> userProfile() async {
    emit(ApiLoding(currentIndex: state.currentIndex));
    if (loginCubit.state.token?.accessToken != null) {
      final result = await Future.wait([
        authRepository.iProfile(loginCubit.state.token!.accessToken!),
        authRepository.profilr(loginCubit.state.token!.accessToken!),
      ]);
      if (result[0] is String || result[1] is String) {
        await loginCubit.refreshToken();
        if (isClosed) return;
        if (result[0] is String) {
          emit(ApiError(currentIndex: state.currentIndex, error: result[0]));
        }
        if (result[1] is String) {
          emit(ApiError(currentIndex: state.currentIndex, error: result[1]));
        }
      } else {
        emit(
          ApiFinish(
            currentIndex: state.currentIndex,
            studentGroupsClass: state.studentGroupsClass,
            groupClass: state.groupClass,
            usersProfile: result[1],
            iProfile: result[0],
            leaderBoard: state.leaderBoard,
            assignmentsGet: state.assignmentsGet,
            gradesGet: state.gradesGet,
            submissionsGet: state.submissionsGet,
          ),
        );
      }
    }
  }

  Future<void> bio(String bioMatin) async {
    emit(ApiLoding(currentIndex: state.currentIndex));
    if (loginCubit.state.token?.accessToken != null) {
      final response = await authRepository.bio(
        bioMatin,
        loginCubit.state.token!.accessToken!,
      );
      if (isClosed) return;
      if (response == "200") {
        await userProfile();
      } else if (response == "401") {
        await loginCubit.refreshToken();
      } else {
        emit(ApiError(currentIndex: state.currentIndex, error: response));
      }
    }
  }

  Future<void> putProfile(IProfile iProfile) async {
    emit(ApiLoding(currentIndex: state.currentIndex));
    if (loginCubit.state.token?.accessToken != null) {
      final response = await authRepository.putProfile(
        loginCubit.state.token!.accessToken!,
        iProfile,
      );

      if (isClosed) return;
      if (response == "200") {
        await userProfile();
      } else if (response == "401") {
        await loginCubit.refreshToken();
      } else {
        emit(ApiError(currentIndex: state.currentIndex, error: response));
      }
    }
  }

  Future<void> leaderBoard(String data, int page, int? grupId) async {
    if (loginCubit.state.token?.accessToken != null) {
      final response = await authRepository.leaderBoard(
        loginCubit.state.token!.accessToken!,
        data,
        page,
        grupId,
      );
      if (response is String) {
        if (response == "401") {
          await loginCubit.refreshToken();
        }
        if (response != "401") {
          emit(ApiError(currentIndex: state.currentIndex, error: response));
        }
      } else {
        emit(
          ApiFinish(
            currentIndex: state.currentIndex,
            studentGroupsClass: state.studentGroupsClass,
            groupClass: state.groupClass,
            usersProfile: state.usersProfile,
            iProfile: state.iProfile,
            leaderBoard: response,
            assignmentsGet: state.assignmentsGet,
            gradesGet: state.gradesGet,
            submissionsGet: state.submissionsGet,
          ),
        );
      }
    }
  }

  Future<void> tasksGet(String limit, String offset, String? groupId) async {
    emit(ApiLoding(currentIndex: state.currentIndex));
    if (loginCubit.state.token?.accessToken != null) {
      final result = await Future.wait([
        authRepository.assignmentsGet(
          loginCubit.state.token!.accessToken!,
          limit,
          offset,
          groupId,
        ),
        authRepository.submissionsGet(
          loginCubit.state.token!.accessToken!,
          limit,
          offset,
        ),
        authRepository.gradesGet(
          loginCubit.state.token!.accessToken!,
          limit,
          offset,
        ),
      ]);

      if (result[0] is String || result[1] is String || result[2] is String) {
        if (result[0] == "401" || result[1] == "401" || result[2] == "401") {
          await loginCubit.refreshToken();
          return tasksGet(limit, offset, groupId);
        }
        if (result[0] != "401" || result[1] != "401" || result[2] != "401") {
          emit(ApiError(currentIndex: state.currentIndex, error: ""));
        }
      } else {
        emit(
          ApiFinish(
            currentIndex: state.currentIndex,
            studentGroupsClass: state.studentGroupsClass,
            groupClass: state.groupClass,
            usersProfile: state.usersProfile,
            iProfile: state.iProfile,
            leaderBoard: state.leaderBoard,
            submissionsGet: result[1],
            gradesGet: result[2],
            assignmentsGet: result[0],
          ),
        );
      }
    }
  }
}
