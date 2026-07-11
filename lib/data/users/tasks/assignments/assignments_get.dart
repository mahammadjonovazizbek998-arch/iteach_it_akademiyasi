class AssignmentsGet {
  int id;
  String description;
  int teacherId;
  int groupId;
  int studentId;
  List<String> files;
  bool status;
  String createdAt;

  AssignmentsGet({
    required this.id,
    required this.description,
    required this.teacherId,
    required this.groupId,
    required this.studentId,
    required this.files,
    required this.status,
    required this.createdAt,
  });

  factory AssignmentsGet.formJson(Map<String, dynamic> json) {
    return AssignmentsGet(
      id: json["id"] ?? 0,
      description: json["description"] ?? "",
      teacherId: json["teacher_id"] ?? 0,
      groupId: json["group_id"] ?? 0,
      studentId: json["student_id"]??0,
      files: List<String>.from(json["files"]?.map((x) => x.toString()) ?? []),
      status: json["status"] ?? true,
      createdAt: json["created_at"] ?? "",
    );
  }
}
