import 'package:equatable/equatable.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class AddTask extends TasksEvent {
  final String date;
  final String description;

  AddTask({required this.date, required this.description});

  @override
  List<Object> get props => [date, description];
}

class GetTasksByDate extends TasksEvent {
  final String date;

  GetTasksByDate({required this.date});
}
