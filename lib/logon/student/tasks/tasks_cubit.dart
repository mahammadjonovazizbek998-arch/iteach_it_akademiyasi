import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:iteach_it_akademiyasi/data/repository/auth.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/student_groups_class.dart';
import 'package:iteach_it_akademiyasi/data/users/tasks/assignments/assignments_get.dart';
import 'package:iteach_it_akademiyasi/data/users/tasks/submissions/submissions_get.dart';
import 'package:iteach_it_akademiyasi/data/users/users/users.dart';
import 'package:iteach_it_akademiyasi/logon/api_cubit/api_cubit.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final ApiCubit apiCubit;
  late final StreamSubscription _subscription;

  TasksCubit({required this.apiCubit})
    : super(TasksInitial(tasks: "assignments", open: "open", barchasi: false)) {
    if (apiCubit.state is ApiFinish &&
        apiCubit.state.submissionsGet != null &&
        apiCubit.state.groupClass != null &&
        apiCubit.state.iProfile != null) {
      emit(
        TasksFinish(
          iProfile: apiCubit.state.iProfile,
          assignmentsGet: apiCubit.state.assignmentsGet,
          submissionsGet: apiCubit.state.submissionsGet,
          gradesGet: apiCubit.state.gradesGet,
          tasks: state.tasks,
          selectedIndex: state.selectedIndex,
          groupClass: grup(),
          open: state.open,
          barchasi: state.barchasi,
        ),
      );
    }
    _subscription = apiCubit.stream.listen((apiState) {
      if (apiState is ApiError) {
        emit(
          TasksError(
            error: apiState.error,
            tasks: state.tasks,
            barchasi: state.barchasi,
          ),
        );
      } else if (apiState is ApiLoding) {
        emit(TasksLoding(tasks: state.tasks, barchasi: state.barchasi));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  List<StudentGroupsClass> grup() {
    final submissions = apiCubit.state.submissionsGet;
    final groups = apiCubit.state.studentGroupsClass;

    List<StudentGroupsClass> groupClass = [];

    if (submissions != null &&
        submissions.isNotEmpty &&
        groups != null &&
        groups.isNotEmpty) {
      for (var task in submissions) {
        for (var grup in groups) {
          if (task.assignment!.groupId == grup.id) {
            groupClass.add(grup);
          }
        }
      }
    }
    return groupClass;
  }

  void assignments(String? toshriq, int? index, String? open, bool? barchasi) {
    if (toshriq != null) {
      emit(
        TasksFinish(
          assignmentsGet: state.assignmentsGet,
          submissionsGet: state.submissionsGet,
          gradesGet: state.gradesGet,
          tasks: toshriq,
          iProfile: state.iProfile,
          selectedIndex: state.selectedIndex,
          groupClass: state.groupClass,
          open: state.open,
          barchasi: state.barchasi,
        ),
      );
    } else if (index != null) {
      if (state.selectedIndex != index) {
        emit(
          TasksFinish(
            assignmentsGet: state.assignmentsGet,
            submissionsGet: state.submissionsGet,
            gradesGet: state.gradesGet,
            tasks: state.tasks,
            iProfile: state.iProfile,
            selectedIndex: index,
            groupClass: state.groupClass,
            open: state.open,
            barchasi: state.barchasi,
          ),
        );
      } else {
        emit(
          TasksFinish(
            assignmentsGet: state.assignmentsGet,
            submissionsGet: state.submissionsGet,
            gradesGet: state.gradesGet,
            tasks: state.tasks,
            iProfile: state.iProfile,
            selectedIndex: null,
            groupClass: state.groupClass,
            open: null,
            barchasi: state.barchasi,
          ),
        );
      }
    } else if (open != null) {
      if (state.open == "open") {
        emit(
          TasksFinish(
            assignmentsGet: state.assignmentsGet,
            submissionsGet: state.submissionsGet,
            gradesGet: state.gradesGet,
            tasks: state.tasks,
            iProfile: state.iProfile,
            selectedIndex: state.selectedIndex,
            groupClass: state.groupClass,
            open: null,
            barchasi: state.barchasi,
          ),
        );
      } else {
        emit(
          TasksFinish(
            assignmentsGet: state.assignmentsGet,
            submissionsGet: state.submissionsGet,
            gradesGet: state.gradesGet,
            tasks: state.tasks,
            iProfile: state.iProfile,
            selectedIndex: state.selectedIndex,
            groupClass: state.groupClass,
            open: "open",
            barchasi: state.barchasi,
          ),
        );
      }
    } else if (barchasi != null) {
      emit(
        TasksFinish(
          iProfile: state.iProfile,
          assignmentsGet: state.assignmentsGet,
          submissionsGet: state.submissionsGet,
          gradesGet: state.gradesGet,
          tasks: state.tasks,
          selectedIndex: state.selectedIndex,
          groupClass: state.groupClass,
          open: state.open,
          barchasi: barchasi,
        ),
      );
    }
  }

  Future<void> fileManager(int tasksIndex, int fileIndex) async {
    AuthRepository authRepository = AuthRepository();
    try {
      final file = await authRepository.fileManager(
        state.submissionsGet![tasksIndex].files[fileIndex],
      );
    } catch (e) {}
  }
}
