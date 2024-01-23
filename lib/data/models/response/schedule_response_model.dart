import 'dart:convert';

class ScheduleResponseModel {
  final String course;
  final String lecturer;
  final String description;
  final String startTime;
  final String endTime;

  ScheduleResponseModel({
    required this.course,
    required this.lecturer,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  factory ScheduleResponseModel.fromJson(String str) =>
      ScheduleResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleResponseModel.fromMap(Map<String, dynamic> json) =>
      ScheduleResponseModel(
        course: json["course"],
        lecturer: json["lecturer"],
        description: json["description"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toMap() => {
        "course": course,
        "lecturer": lecturer,
        "description": description,
        "startTime": startTime,
        "endTime": endTime,
      };
}
