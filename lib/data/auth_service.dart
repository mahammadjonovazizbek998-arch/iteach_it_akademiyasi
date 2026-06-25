import 'package:http/http.dart' as http;

class ApiService {
  final String url = "https://erp.iteach.uz";
  final Map<String, String> _headers = {
    "Content-Type": "application/x-www-form-urlencoded",
  };
  final Map<String, String> _refreshHeaders = {
    "Content-Type": "application/json",
  };

  Future<http.Response> login(String login, String parol) async {
    Uri uri = Uri.parse("$url/auth/login");
    return await http
        .post(
          uri,
          headers: _headers,
          body: {"username": login, "password": parol},
        )
        .timeout(Duration(seconds: 15));
  }

  Future<http.Response> refresh(String refreshToken) async {
    Uri uri = Uri.parse("$url/auth/refresh");
    return await http
        .post(
          uri,
          headers: _refreshHeaders,
          body: {"refresh_token": refreshToken},
        )
        .timeout(Duration(seconds: 10));
  }

  Future<http.Response> iGroups(String token) async {
    Uri uri = Uri.parse("$url/student-groups/my-groups");
    return await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  Future<http.Response> groups(int id) async {
    Uri uri = Uri.parse("$url/courses/$id");
    return await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
  }
  Future<http.Response> groupName() async {
    Uri uri = Uri.parse("$url/courses");
    return await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
  }
}
