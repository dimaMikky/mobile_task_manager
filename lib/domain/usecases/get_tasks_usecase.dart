import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/domain/entities/task_entity.dart';
import 'package:test1/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository taskRepository;

  GetTasksUseCase({required this.taskRepository});

  Future<Either<Failure, List<TaskEntity>>> call(
      AddTasksDateParam params) async {
    return await taskRepository.getAllTasksByDate(params.date);
  }
}

class AddTasksDateParam extends Equatable {
  final String date;

  AddTasksDateParam({required this.date});

  @override
  List<Object?> get props => [date];
}
