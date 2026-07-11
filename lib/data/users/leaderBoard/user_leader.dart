class UserLeader {
  int rank;
  int userId;
  String name;
  int score;

  UserLeader({
    required this.rank,
    required this.userId,
    required this.name,
    required this.score,
  });

  factory UserLeader.formJson(Map<String, dynamic> json) {
    return UserLeader(
      rank: json["rank"] ?? 0,
      userId: json["user_id"] ?? 0,
      name: json["name"] ?? "",
      score: json["score"] ?? 0,
    );
  }
}
