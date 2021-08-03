import 'package:test1/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    id,
    required date,
    required description,
  }) : super(
          id: id,
          date: date,
          description: description,
        );

  TaskModel copy({
    int? id,
    String? date,
    String? description,
  }) =>
      TaskModel(
        id: id ?? this.id,
        date: date ?? this.date,
        description: description ?? this.description,
      );

  factory TaskModel.fromJson(Map<String, dynamic> res) {
    return TaskModel(
      id: res['id'],
      date: res['date'],
      description: res['description'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'description': description,
    };
  }
}
