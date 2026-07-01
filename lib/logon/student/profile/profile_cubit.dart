import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:iteach_it_akademiyasi/data/users/users/users.dart';
import 'package:iteach_it_akademiyasi/data/users/users/users_profile.dart';
import 'package:iteach_it_akademiyasi/logon/api_cubit/api_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ApiCubit apiCubit;
  late final StreamSubscription _authSubscription;

  ProfileCubit({required this.apiCubit}) : super(ProfileInitial()) {
    start();
    _authSubscription = apiCubit.stream.listen((apiState) {
      if (apiState is ApiLoding) {
        emit(ProfileLoding());
      }
      if (apiState is ApiError) {
        emit(ProfileError(error: apiState.error));
      }
      if (apiState is ApiFinish) {
        start();
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  Future<void> start() async {
    emit(
      ProfileFinish(
        iProfile: apiCubit.state.iProfile,
        usersProfile: apiCubit.state.usersProfile,
      ),
    );
  }

  Future<void> rri() async {
    await apiCubit.userProfile();
    _authSubscription;
  }

  Future<void> bio(String bioMatin) async {
    emit(ProfileLoding());

    await apiCubit.bio(bioMatin);
  }

  Future<void> putProfile(
    String fullName,
    String login,
    String password,
    String phoneNumber,
  ) async {
    IProfile iProfile = IProfile(
      id: state.iProfile!.id,
      fullName: fullName,
      login: login,
      phoneNumber: phoneNumber,
      role: state.iProfile!.role,
      isActive: state.iProfile!.isActive,
      createdAt: state.iProfile!.createdAt,
    );
    emit(ProfileLoding());
    await apiCubit.putProfile(iProfile);
  }

  void password() {
    emit(SecondaryActions(parol: !state.parol));
  }
}
