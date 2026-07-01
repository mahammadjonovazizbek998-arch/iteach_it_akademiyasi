class Token {
  String? accessToken;
  String? refreshToken;
  String? role;

  Token({this.accessToken, this.refreshToken, this.role});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json["access_token"] ?? "",
      refreshToken: json["refresh_token"] ?? "",
      role: json["role"] ?? "",
    );
  }
}
