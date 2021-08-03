import 'package:dartz/dartz.dart';
import 'package:test1/core/error/exception.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/data/datasources/task_db_datasource.dart';
import 'package:test1/domain/entities/task_entity.dart';
import 'package:test1/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDbDataSource taskDbDataSource;

  TaskRepositoryImpl({required this.taskDbDataSource});

  @override
  Future<void> addTask(String date, String description) async {
    try {
      await taskDbDataSource.addTaskToDb(date, description);
    } on ServerException {
      throw ServerException();
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasksByDate(
      String date) async {
    try {
      final dbTasks = await taskDbDataSource.getAllTasksByDate(date);
      return Right(dbTasks);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
