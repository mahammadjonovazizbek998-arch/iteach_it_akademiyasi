part of 'rating_cubit.dart';

@immutable
sealed class RatingState {
  final String data;
  final int page;
  final LeaderBoard? leaderBoard;
  final String gurp;

  const RatingState({
    this.leaderBoard,
    this.data = "all",
    this.page = 1,
    this.gurp = "all",
  });
}

final class RatingInitial extends RatingState {}

final class RatingFinish extends RatingState {
  const RatingFinish({
    required super.leaderBoard,
    required super.data,
    required super.page,
    required super.gurp,
  });
}

final class RatingData extends RatingState {
  const RatingData({
    required super.data,
    required,
    super.page,
    required super.gurp,
  });
}

final class RatingError extends RatingState {
  final String error;

  const RatingError({required this.error});
}

final class RatingLoding extends RatingState {
  const RatingLoding({
    required super.page,
    required super.data,
    required super.gurp,
  });
}
