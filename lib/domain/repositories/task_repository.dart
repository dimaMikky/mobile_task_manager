import 'package:dartz/dartz.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<void> addTask(String date, String description);
  Future<Either<Failure, List<TaskEntity>>> getAllTasksByDate(String date);
}
