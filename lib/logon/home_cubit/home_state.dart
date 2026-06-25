part of 'home_cubit.dart';

@immutable
sealed class HomeState {
  final int currentIndex;
  final List<StudentGroupsClass>? studentGroupsClass;
  final List<GroupClass>? groupClass;
  final List<GroupClass>? groupClasFaol;
  final List<GroupClass>? groupClasNoFaol;
  final int today;
  final String startTime;
  final List<StudentGroupsClass>? faol;
  final List<StudentGroupsClass>? noFaol;

  const HomeState({
    required this.currentIndex,
    this.studentGroupsClass,
    this.groupClass,
    this.today = 0,
    this.startTime = "",
    this.faol,
    this.noFaol,
    this.groupClasFaol,
    this.groupClasNoFaol,
  });
}

final class HomeInitial extends HomeState {
  const HomeInitial({required super.currentIndex});
}

final class HomeLoding extends HomeState {
  const HomeLoding({required super.currentIndex});
}

final class HomeFinish extends HomeState {
  const HomeFinish({
    required super.currentIndex,
    required super.studentGroupsClass,
    required super.groupClass,
    required super.today,
    required super.startTime,
    required super.faol,
    required super.noFaol,
    required super.groupClasFaol,
    required super.groupClasNoFaol,
  });
}

final class HomeError extends HomeState {
  final String error;

  const HomeError({required super.currentIndex, required this.error});
}
