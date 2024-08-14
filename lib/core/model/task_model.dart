// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final int taskId;
  final String taskTitle;
  final String taskDescription;
  final bool isImportant;
  final bool remindMe;
  final String creationDate;
  final String creationTime;

  TaskModel({
    required this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.isImportant,
    required this.remindMe,
    required this.creationDate,
    required this.creationTime,
  });

  TaskModel copyWith({
    int? taskId,
    String? taskTitle,
    String? taskDescription,
    bool? isImportant,
    bool? remindMe,
    String? creationDate,
    String? creationTime,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      taskDescription: taskDescription ?? this.taskDescription,
      isImportant: isImportant ?? this.isImportant,
      remindMe: remindMe ?? this.remindMe,
      creationDate: creationDate ?? this.creationDate,
      creationTime: creationTime ?? this.creationTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'isImportant': isImportant,
      'remindMe': remindMe,
      'creationDate': creationDate,
      'creationTime': creationTime,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'] as int,
      taskTitle: map['taskTitle'] as String,
      taskDescription: map['taskDescription'] as String,
      isImportant: map['isImportant'] as bool,
      remindMe: map['remindMe'] as bool,
      creationDate: map['creationDate'] as String,
      creationTime: map['creationTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(taskId: $taskId, taskTitle: $taskTitle, taskDescription: $taskDescription, isImportant: $isImportant, remindMe: $remindMe, creationDate: $creationDate, creationTime: $creationTime)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.taskId == taskId &&
        other.taskTitle == taskTitle &&
        other.taskDescription == taskDescription &&
        other.isImportant == isImportant &&
        other.remindMe == remindMe &&
        other.creationDate == creationDate &&
        other.creationTime == creationTime;
  }

  @override
  int get hashCode {
    return taskId.hashCode ^
        taskTitle.hashCode ^
        taskDescription.hashCode ^
        isImportant.hashCode ^
        remindMe.hashCode ^
        creationDate.hashCode ^
        creationTime.hashCode;
  }
}
