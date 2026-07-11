import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:iteach_it_akademiyasi/data/users/leaderBoard/leader_board.dart';
import 'package:iteach_it_akademiyasi/logon/api_cubit/api_cubit.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  final ApiCubit apiCubit;
  late final StreamSubscription _subscription;

  RatingCubit({required this.apiCubit}) : super(RatingInitial()) {
    if (apiCubit.state is ApiFinish && apiCubit.state.leaderBoard != null) {
      finish();
    }
    _subscription = apiCubit.stream.listen((apiState) {
      if (apiState is ApiError) {
        emit(RatingError(error: apiState.error));
      }
      if (apiState is ApiLoding) {
        emit(
          RatingLoding(page: state.page, data: state.data, gurp: state.gurp),
        );
      }
      if (apiState is ApiFinish && apiCubit.state.leaderBoard != null) {
        finish();
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  void finish() {
    emit(
      RatingFinish(
        leaderBoard: apiCubit.state.leaderBoard,
        data: state.data,
        page: state.page,
        gurp: state.gurp,
      ),
    );
  }

  void deadline(String malumot, int page, String grup) {
    emit(RatingData(data: malumot, page: page, gurp: grup));
    grup == "all"
        ? leaderBoard(malumot, page, null)
        : leaderBoard(malumot, page, apiCubit.state.studentGroupsClass![0].id);
  }

  void leaderBoard(String malumot, int page, int? grupId) async {
    emit(RatingLoding(page: state.page, data: state.data, gurp: state.gurp));
    await apiCubit.leaderBoard(state.data, state.page, grupId);
  }
}
