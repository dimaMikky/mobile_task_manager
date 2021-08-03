import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test1/domain/entities/task_entity.dart';
import 'package:test1/presentation/bloc/task_bloc.dart';
import 'package:test1/presentation/bloc/task_event.dart';
import 'package:test1/presentation/bloc/task_state.dart';

class DayScreen extends StatelessWidget {
  final date;
  final month;
  final year;

  const DayScreen({
    Key? key,
    required this.date,
    required this.month,
    required this.year,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<TaskEntity> tasksList = [];
    String taskAddedInfo = '';
    String taskInfo = '';
    var msgController = TextEditingController();

    final _date = date;
    final _month = month;
    final _year = year;
    String dbDate = DateFormat('yMd').format(
        new DateTime(int.parse(_year), int.parse(_month), int.parse(_date)));

    return Scaffold(
      appBar: AppBar(
        title: Text(dbDate),
      ),
      body: BlocBuilder(
          bloc: BlocProvider.of<TasksBloc>(context),
          builder: (context, state) {
            if (state is TasksEmpty) {
              BlocProvider.of<TasksBloc>(context)
                  .add(GetTasksByDate(date: dbDate));
            } else if (state is TaskAdded) {
              BlocProvider.of<TasksBloc>(context)
                  .add(GetTasksByDate(date: dbDate));
              taskAddedInfo = state.message;
            } else if (state is TasksByDateLoaded) {
              BlocProvider.of<TasksBloc>(context)
                  .add(GetTasksByDate(date: dbDate));
              tasksList = state.tasksList;
            }
            return Container(
              child: Column(children: [
                //   ListView.builder(
                //       padding: const EdgeInsets.all(8),
                //       itemCount: tasksList.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         return Container(
                //           height: 50,
                //           color: Colors.amber,
                //           child: Center(child: Text(tasksList),
                //         );
                //       }),

                SizedBox(
                  height: 5,
                ),
                Column(children: getTasksf(tasksList)),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: msgController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Describe your task',
                  ),
                  onChanged: (string) {
                    taskInfo = string;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      BlocProvider.of<TasksBloc>(context)
                          .add(AddTask(date: dbDate, description: taskInfo));
                      msgController.text = '';
                    },
                    label: const Text('Put New Task'),
                    icon: const Icon(Icons.add),
                    backgroundColor: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    '$taskAddedInfo',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ]),
            );
          }),
    );
  }
}

List<Widget> getTasksf(tasksList) {
  final tasks = <Widget>[];
  for (var i = 0; i < tasksList.length; i++) {
    tasks.add(
      Card(
        child: ListTile(
          title: Text('${tasksList[i].description}'),
          subtitle: Text('${tasksList[i].date}'),
        ),
      ),
    );
  }
  return tasks;
}
