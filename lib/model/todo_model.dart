

import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';
@HiveType(typeId: 1)
class TodoModel{

@HiveField(0)
  String title;
  @HiveField(1)
  String category;
  @HiveField(2)
  bool isCompleted;

  TodoModel({required this.title, required this.category, required this.isCompleted});
}