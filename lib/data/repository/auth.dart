import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:iteach_it_akademiyasi/data/auth_service.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/group_class.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/login_class.dart';
import 'package:iteach_it_akademiyasi/data/users/groups/student_groups_class.dart';
import 'package:iteach_it_akademiyasi/data/users/leaderBoard/leader_board.dart';
import 'package:iteach_it_akademiyasi/data/users/tasks/assignments/assignments_get.dart';
import 'package:iteach_it_akademiyasi/data/users/tasks/submissions/submissions_get.dart';
import 'package:iteach_it_akademiyasi/data/users/users/users.dart';
import 'package:iteach_it_akademiyasi/data/users/users/users_profile.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  //login
  Future<dynamic> signIn(String login, String parol) async {
    try {
      final response = await _apiService.login(login, parol);
      final data = jsonDecode(response.body);
      if (response.statusCode < 400) {
        if (data['error'] != null) {
          return data["error"]["message"] ?? "Xatolik yuz berdi";
        }
        return data;
      }
      return data["message"] ??
          "Xatolik yuz berdi (Status: ${response.statusCode})";
    } on SocketException {
      return "no_internet";
    } on TimeoutException {
      return "server_timeout";
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> refreshToken(String token) async {
    try {
      final response = await _apiService.refresh(token);
      final data = jsonDecode(response.body);
      if (response.statusCode < 400) {
        if (data["error"] != null) {
          return data["error"]["message"] ?? "Xatolik yuz berdi";
        }
        await setSharedPreferences(
          Token.fromJson(data).accessToken,
          Token.fromJson(data).refreshToken,
          Token.fromJson(data).role,
        );
        return Token.fromJson(data);
      }
      return data["message"];
    } catch (e) {
      return e.toString();
    }
  }

  Future<Token?> getSharedPreferences() async {
    final preference = await SharedPreferences.getInstance();
    String? accessToken = preference.getString("accessToken");
    String? refreshToken = preference.getString("refreshToken");
    String? role = preference.getString("role");
    if (accessToken == null || refreshToken == null || role == null) {
      return null;
    }
    return Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
      role: role,
    );
  }

  Future<dynamic> setSharedPreferences(
    String? accessToken,
    String? refreshToken,
    String? role,
  ) async {
    final preference = await SharedPreferences.getInstance();
    if (accessToken == null || accessToken.isEmpty) {
      await preference.remove("accessToken");
      await preference.remove("refreshToken");
      await preference.remove("role");
      return null;
    } else {
      await preference.setString("accessToken", accessToken);
      await preference.setString("refreshToken", refreshToken!);
      await preference.setString("role", role!);
      return "Finish";
    }
  }

  //gruhlar
  Future<dynamic> studentGroup(String token) async {
    try {
      final response = await _apiService.iGroups(token);

      if (response.statusCode < 400) {
        final List<dynamic> dataList = jsonDecode(response.body);
        List<StudentGroupsClass> groups = dataList
            .map((json) => StudentGroupsClass.fromJson(json))
            .toList();
        return groups;
      }
      if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> group(int id) async {
    try {
      final response = await _apiService.groups(id);
      if (response.statusCode < 400) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return GroupClass.fromJson(data);
      }

      if (response.statusCode == 401) {
        return "401";
      }
      return "Server xatosi: ${response.statusCode}";
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> groupName() async {
    try {
      final response = await _apiService.groupName();

      if (response.statusCode < 400) {
        final List<dynamic> dataList = jsonDecode(response.body);
        List<NameGroups> groups = dataList
            .map((json) => NameGroups.fromJson(json))
            .toList();
        return groups;
      }
      if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> makeCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> sendSms(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    }
  }

  //profile
  Future<dynamic> iProfile(String token) async {
    try {
      final response = await _apiService.myProfile(token);
      if (response.statusCode < 400) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return IProfile.formJson(data);
      }
      if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> profilr(String token) async {
    try {
      final response = await _apiService.userProfile(token);
      if (response.statusCode < 400) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return UsersProfile.formJson(data);
      }
      if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> bio(String bioMatin, String token) async {
    try {
      final response = await _apiService.bio(bioMatin, token);
      if (response.statusCode < 400) {
        return "200";
      }
      if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> putProfile(String token, IProfile iProfile) async {
    try {
      final response = await _apiService.putProfile(token, iProfile);

      if (response.statusCode < 400) {
        return "200";
      }
      if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> leaderBoard(
    String token,
    String data,
    int page,
    int? grupId,
  ) async {
    try {
      final response = await _apiService.leaderBoard(token, data, page, grupId);
      if (response.statusCode < 400) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return LeaderBoard.formJson(data);
      }
      if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> assignmentsGet(
    String token,
    String limit,
    String offset,
    String? groupId,
  ) async {
    try {
      final response = await _apiService.assignmentsGet(
        token,
        limit,
        offset,
        groupId,
      );
      if (response.statusCode < 400) {
        final List<dynamic> dataList = jsonDecode(response.body);

        List<AssignmentsGet> groups = dataList
            .map((json) => AssignmentsGet.formJson(json))
            .toList();
        return groups;
      } else if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> submissionsGet(
    String token,
    String limit,
    String offset,
  ) async {
    try {
      final response = await _apiService.submissionsGet(token, limit, offset);
      if (response.statusCode < 400) {
        final List<dynamic> dataList = jsonDecode(response.body);
        List<SubmissionsGet> groups = dataList
            .map((json) => SubmissionsGet.formJson(json))
            .toList();
        return groups;
      } else if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> gradesGet(String token, String limit, String offset) async {
    try {
      final response = await _apiService.gradesGet(token, limit, offset);
      if (response.statusCode < 400) {
        final List<dynamic> dataList = jsonDecode(response.body);

        List<SubmissionsGet> groups = dataList
            .map((json) => SubmissionsGet.formJson(json))
            .toList();
        return groups;
      } else if (response.statusCode == 401) {
        return "401";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> fileManager(String file) async {

    try {
      List<int> faylBaytlari=base64Decode(file);
      Directory papka = await getApplicationDocumentsDirectory();
      String faylManzili="${papka.path}/mening_hujjatim.pdf";
      File yangiFayl=File(faylManzili);
      await yangiFayl.writeAsBytes(faylBaytlari);
      await OpenFilex.open(faylManzili);
    } catch (e) {}
  }
}
