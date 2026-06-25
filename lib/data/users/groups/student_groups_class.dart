class StudentGroupsClass {
  int id;
  String name;
  List<String> scheduleDays;
  String startTime;
  String endTime;
  bool status;

  StudentGroupsClass({
    required this.id,
    required this.name,
    required this.scheduleDays,
    required this.endTime,
    required this.startTime,
    required this.status,
  });

  factory StudentGroupsClass.fromJson(Map<String, dynamic> json) {
    return StudentGroupsClass(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      scheduleDays: List<String>.from(json["schedule_days"] ?? []),
      endTime: json["start_time"] ?? "00:00:00",
      startTime: json["end_time"] ?? "00:00:00",
      status: json["status"] ?? false,
    );
  }
}
