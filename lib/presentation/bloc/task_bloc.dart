import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/error/failure.dart';
import 'package:test1/domain/usecases/get_tasks_usecase.dart';
import 'package:test1/domain/usecases/task_usecase.dart';
import 'package:test1/presentation/bloc/task_event.dart';
import 'package:test1/presentation/bloc/task_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final AddTaskUseCase addTaskUseCase;
  final GetTasksUseCase getTasksUseCase;
  TasksBloc({required this.addTaskUseCase, required this.getTasksUseCase})
      : super(TasksEmpty());

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is AddTask) {
      await addTaskUseCase(
          AddTasksParams(date: event.date, description: event.description));
      yield TaskAdded('Task was added');
    } else if (event is GetTasksByDate) {
      final result = await getTasksUseCase(AddTasksDateParam(date: event.date));
      yield result.fold(
          (failure) =>
              TasksLoadingError(message: _mapFailureToMessage(failure)),
          (task) {
        return TasksByDateLoaded(tasksList: task);
      });
    }
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Server Failure';
    default:
      return 'Unexpected Error';
  }
}
