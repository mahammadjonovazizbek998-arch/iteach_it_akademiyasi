part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {
  final IProfile? iProfile;
  final UsersProfile? usersProfile;
  final bool parol;

  const ProfileState({this.iProfile, this.usersProfile, this.parol = true});
}

final class ProfileInitial extends ProfileState {}

final class ProfileFinish extends ProfileState {
  const ProfileFinish({required super.iProfile, required super.usersProfile});
}

final class SecondaryActions extends ProfileState {
  const SecondaryActions({required super.parol});
}

final class ProfileLoding extends ProfileState {}

final class ProfileError extends ProfileState {
  final String error;

  const ProfileError({required this.error});
}
