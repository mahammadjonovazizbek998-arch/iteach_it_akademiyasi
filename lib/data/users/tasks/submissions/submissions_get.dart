class SubmissionsGet {
  int id;
  int assignmentId;
  int studentId;
  String description;
  List<String> files;
  String status;
  String submittedAt;
  Assignment? assignment;
  Grade? grade;

  SubmissionsGet({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.description,
    required this.files,
    required this.status,
    required this.submittedAt,
    this.assignment,
    this.grade,
  });

  factory SubmissionsGet.formJson(Map<String, dynamic> json) {
    return SubmissionsGet(
      id: json["id"] ?? 0,
      assignmentId: json["assignment_id"] ?? 0,
      studentId: json["student_id"] ?? 0,
      description: json["description"] ?? "",
      files: List<String>.from(json["files"]?.map((x) => x.toString()) ?? []),
      status: json["status"] ?? "",
      submittedAt: json["submitted_at"] ?? "",
      assignment: json["assignment"] != null
          ? Assignment.formJson(json["assignment"])
          : null,
      grade: json["grade"] != null ? Grade.fromJson(json["grade"]) : null,
    );
  }
}

class Assignment {
  int id;
  String description;
  int groupId;
  int studentId;

  Assignment({
    required this.id,
    required this.description,
    required this.groupId,
    required this.studentId,
  });

  factory Assignment.formJson(Map<String, dynamic> json) {
    return Assignment(
      id: json["id"] ?? 0,
      description: json["description"] ?? "",
      groupId: json["group_id"] ?? 0,
      studentId: json["student_id"] ?? 0,
    );
  }
}

class Grade {
  int id;
  int score;
  String comment;
  String gradedAt;

  Grade({
    required this.id,
    required this.score,
    required this.comment,
    required this.gradedAt,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json["id"] ?? 0,
      score: json["score"] ?? 0,
      comment: json["comment"] ?? "",
      gradedAt: json["graded_at"] ?? "",
    );
  }
}
