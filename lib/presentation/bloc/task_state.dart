import 'package:equatable/equatable.dart';
import 'package:test1/domain/entities/task_entity.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksEmpty extends TasksState {}

class TaskAdded extends TasksState {
  final message;

  TaskAdded(this.message);
}

class TasksByDateLoaded extends TasksState {
  final List<TaskEntity> tasksList;

  TasksByDateLoaded({required this.tasksList});

  @override
  List<Object?> get props => [tasksList];
}

class TasksLoadingError extends TasksState {
  final String message;

  TasksLoadingError({required this.message});
}
