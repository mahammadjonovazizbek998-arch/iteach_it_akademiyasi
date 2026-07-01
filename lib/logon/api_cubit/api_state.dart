part of 'api_cubit.dart';

@immutable
sealed class ApiState {
  final int currentIndex;
  final List<StudentGroupsClass>? studentGroupsClass;
  final List<GroupClass>? groupClass;
  final IProfile? iProfile;
  final UsersProfile? usersProfile;

  const ApiState({
    required this.currentIndex,
    this.studentGroupsClass,
    this.groupClass,
    this.usersProfile,
    this.iProfile,
  });
}

final class ApiInitial extends ApiState {
  const ApiInitial({required super.currentIndex});
}

final class ApiLoding extends ApiState {
  const ApiLoding({required super.currentIndex});
}

final class ApiFinish extends ApiState {
  const ApiFinish({
    required super.currentIndex,
    required super.studentGroupsClass,
    required super.groupClass,
    required super.usersProfile,
    required super.iProfile,
  });
}

final class ApiError extends ApiState {
  final String error;

  const ApiError({required super.currentIndex, required this.error});
}
