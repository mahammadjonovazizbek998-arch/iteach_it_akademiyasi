part of 'groups_cubit.dart';

@immutable
sealed class GroupsState {
  final List<GroupClass>? groupClasFaol;
  final List<GroupClass>? groupClasNoFaol;
  final int today;
  final String startTime;
  final List<StudentGroupsClass>? faol;
  final List<StudentGroupsClass>? noFaol;

  const GroupsState({
    this.today = 0,
    this.startTime = "",
    this.faol,
    this.noFaol,
    this.groupClasFaol,
    this.groupClasNoFaol,
  });
}

final class GroupsLoding extends GroupsState {}

final class GroupsInitial extends GroupsState {}

final class GroupsFinish extends GroupsState {
  const GroupsFinish({
    required super.today,
    required super.startTime,
    required super.faol,
    required super.noFaol,
    required super.groupClasFaol,
    required super.groupClasNoFaol,
  });
}

final class GroupsError extends GroupsState {
  final String error;

  const GroupsError({required this.error});
}
