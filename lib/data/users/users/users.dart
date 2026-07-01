class IProfile {
  int id;
  String fullName;
  String login;
  String phoneNumber;
  String role;
  bool isActive;
  String createdAt;
  String? password;

  IProfile({
    required this.id,
    required this.fullName,
    required this.login,
    required this.phoneNumber,
    required this.role,
    required this.isActive,
    required this.createdAt,
    this.password,
  });

  factory IProfile.formJson(Map<String, dynamic> json) {
    return IProfile(
      id: json["id"] ?? 0,
      fullName: json["full_name"] ?? "",
      login: json["login"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      role: json["role"] ?? "",
      isActive: json["is_active"] ?? true,
      createdAt: json["created_at"] ?? "",
    );
  }
}
