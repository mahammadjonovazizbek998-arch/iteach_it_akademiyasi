part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {
  final List<AssignmentsGet>? assignmentsGet;
  final List<SubmissionsGet>? submissionsGet;
  final List<SubmissionsGet>? gradesGet;
  final String? tasks;
  final String? open;
  final IProfile? iProfile;
  final int? selectedIndex;
  final List<StudentGroupsClass>? groupClass;
  final bool barchasi;

  const TasksState({
    this.assignmentsGet,
    this.gradesGet,
    this.submissionsGet,
    this.tasks = "assignments",
    this.iProfile,
    this.selectedIndex,
    this.groupClass,
    this.open,
    this.barchasi = false,
  });
}

final class TasksInitial extends TasksState {
  const TasksInitial({
    required super.tasks,
    required super.open,
    required super.barchasi,
  });
}

final class TasksFinish extends TasksState {
  const TasksFinish({
    required super.iProfile,
    required super.assignmentsGet,
    required super.submissionsGet,
    required super.gradesGet,
    required super.tasks,
    required super.selectedIndex,
    required super.groupClass,
    required super.open,
    required super.barchasi,
  });
}

final class TasksError extends TasksState {
  final String error;

  const TasksError({
    required this.error,
    required super.tasks,
    required super.barchasi,
  });
}

final class TasksLoding extends TasksState {
  const TasksLoding({required super.tasks, required super.barchasi});
}
