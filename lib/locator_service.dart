import 'package:get_it/get_it.dart';
import 'package:test1/core/db/database.dart';
import 'package:test1/data/datasources/task_db_datasource.dart';
import 'package:test1/data/repositories/task_repository_impl.dart';
import 'package:test1/domain/repositories/task_repository.dart';
import 'package:test1/domain/usecases/get_tasks_usecase.dart';
import 'package:test1/domain/usecases/task_usecase.dart';
import 'package:test1/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc/cubit
  sl.registerFactory(
      () => TasksBloc(addTaskUseCase: sl(), getTasksUseCase: sl()));

  //useCases
  sl.registerLazySingleton(() => AddTaskUseCase(taskRepository: sl()));
  sl.registerLazySingleton(() => GetTasksUseCase(taskRepository: sl()));

  //Repository
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
        taskDbDataSource: sl(),
      ));
  //datasourses
  sl.registerLazySingleton<TaskDbDataSource>(() => TaskDbDataSourceImpl(
        db: sl(),
      ));

  // External
  sl.registerLazySingleton(() => NotesDatabase.instance);
}
