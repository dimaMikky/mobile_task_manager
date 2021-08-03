import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String date;
  final String description;

  TaskEntity({
    this.id,
    required this.date,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        description,
      ];
}
