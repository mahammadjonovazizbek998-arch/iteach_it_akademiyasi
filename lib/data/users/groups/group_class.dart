class GroupClass {
  int id;
  String name;
  String description;
  int duration;
  List<Teachers> teachers;
  int studentsCount;

  GroupClass({
    required this.id,
    required this.name,
    required this.duration,
    required this.description,
    required this.studentsCount,
    required this.teachers,
  });

  factory GroupClass.fromJson(Map<String, dynamic> json) {
    var teachersList = json["teachers"] as List? ?? [];
    List<Teachers> parsedTeachers = teachersList
        .map((map) => Teachers.fromJson(map as Map<String, dynamic>))
        .toList();

    return GroupClass(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      duration: json["duration"] ?? 0,
      description: json["description"] ?? "",
      studentsCount: json["students_count"] ?? 0,
      teachers: parsedTeachers,
    );
  }
}

class Teachers {
  int id;
  String fullName;
  String phoneNumber;

  Teachers({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
  });

  factory Teachers.fromJson(Map<String, dynamic> json) {
    return Teachers(
      id: json["id"] ?? 0,
      fullName: json["full_name"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
    );
  }
}

class NameGroups {
  int id;
  String name;

  NameGroups({required this.id, required this.name});

  factory NameGroups.fromJson(Map<String, dynamic> json) {
    return NameGroups(id: json["id"] ?? 0, name: json["name"] ?? "");
  }
}
