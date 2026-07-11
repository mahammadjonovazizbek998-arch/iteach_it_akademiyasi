import 'package:iteach_it_akademiyasi/data/users/leaderBoard/user_leader.dart';

class LeaderBoard {
  List<UserLeader> top3;
  List<UserLeader> others;

  LeaderBoard({required this.top3, required this.others, });

  factory LeaderBoard.formJson(Map<String, dynamic> json) {
    var top = json["top_3"];
    List<UserLeader> topList = [];
    if (top is List) {
      topList = (top)
          .map((map) => UserLeader.formJson(map as Map<String, dynamic>))
          .toList();
    }
    var others = json["others"];
    List<UserLeader> othersList = [];
    if (others is List) {
      othersList = others
          .map((map) => UserLeader.formJson(map as Map<String, dynamic>))
          .toList();
    }
    return LeaderBoard(
      top3: topList,
      others: othersList,
    );
  }
}
