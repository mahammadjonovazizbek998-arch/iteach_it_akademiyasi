class UsersProfile {
  int id;
  int userId;
  String bio;
  String createdAt;
  ProfiUser profiUser;

  UsersProfile({
    required this.id,
    required this.userId,
    required this.bio,
    required this.createdAt,
    required this.profiUser,
  });

  factory UsersProfile.formJson(Map<String, dynamic> map) {
    return UsersProfile(
      id: map["id"] ?? 0,
      userId: map["user_id"] ?? 0,
      bio: map["bio"] ?? "",
      createdAt: map["created_at"] ?? "",
      profiUser: ProfiUser.formJson(map["user"] ?? {}),
    );
  }
}

class ProfiUser {
  int id;
  String fullName;
  String login;
  String phoneNumber;
  String role;

  ProfiUser({
    required this.id,
    required this.fullName,
    required this.login,
    required this.phoneNumber,
    required this.role,
  });

  factory ProfiUser.formJson(Map<String, dynamic> json) {
    return ProfiUser(
      id: json["id"] ?? 0,
      fullName: json["full_name"] ?? "",
      login: json["login"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      role: json["role"] ?? "",
    );
  }
}
