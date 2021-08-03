import 'package:test1/core/db/database.dart';
import 'package:test1/data/models/task_model.dart';

abstract class TaskDbDataSource {
  Future<void> addTaskToDb(String date, String description);
  Future<List<TaskModel>> getAllTasksByDate(String date);
}

class TaskDbDataSourceImpl implements TaskDbDataSource {
  final NotesDatabase db;
  TaskDbDataSourceImpl({required this.db});

  @override
  Future<void> addTaskToDb(date, description) async {
    await makeTask(date, description);
  }

  @override
  Future<List<TaskModel>> getAllTasksByDate(String date) async {
    final result = await NotesDatabase.instance.getAllTasksByDate(date);
    return result.map((json) => TaskModel.fromJson(json)).toList();
  }
}

Future makeTask(date, description) async {
  final task = TaskModel(
    date: date,
    description: description,
  );

  return await NotesDatabase.instance.create(task);
}
