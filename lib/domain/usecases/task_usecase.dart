import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/domain/entities/task_entity.dart';
import 'package:test1/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository taskRepository;

  AddTaskUseCase({
    required this.taskRepository,
  });

  Future<void> call(AddTasksParams params) async {
    return await taskRepository.addTask(params.date, params.description);
  }
}

class AddTasksParams extends Equatable {
  final String date;
  final String description;

  AddTasksParams({required this.date, required this.description});

  @override
  List<Object?> get props => [date, description];
}
