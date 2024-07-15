import 'package:hive_flutter/adapters.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final DateTime dateTime;
  @HiveField(1)
  final bool isCompleted;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;

  TaskModel({
    required this.dateTime,
    required this.isCompleted,
    required this.title,
    required this.description,
  });
}
