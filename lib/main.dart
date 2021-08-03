import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test1/locator_service.dart';
import 'package:test1/presentation/bloc/task_bloc.dart';
import 'package:test1/presentation/pages/day_screen.dart';
import 'locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TasksBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          title: Text('My Calendar'),
        ),
        body: Container(
          child: Calendar(),
        ),
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> listOfdays = {
      "Mon": 01,
      "Tue": 02,
      "Wed": 03,
      "Thu": 04,
      "Fri": 05,
      "Sat": 06,
      "Sun": 07,
    };
    var currentDate = DateTime.now();

    //(первый день недели текущего месяца)
    var firstDateOfMonth = listOfdays[DateFormat('E').format(new DateTime(
        currentDate.year,
        currentDate.month,
        1))]; //тут можно динамично менять месяц

    //Кол-во дней в месяце
    var daysInMonth = DateUtils.getDaysInMonth(
        currentDate.year, currentDate.month); //тут можно динамично менять месяц

    // Последнее число предыдущего месяца
    var prevMonthLastDay = new DateTime(currentDate.year, currentDate.month, 0)
        .day; //тут можно динамично менять месяц

    //   Первое число следующего месяца
    var nextMonthFirsttDay =
        new DateTime(currentDate.year, currentDate.month + 1, 1).day;

    var date = 1;
    String getMonth(int needMonth) {
      var month = DateFormat('M').format(
          new DateTime(currentDate.year, currentDate.month + needMonth, 1));
      return month;
    }

    String getYear() {
      var year = DateFormat('y')
          .format(new DateTime(currentDate.year, currentDate.month, 1));
      return year;
    }

    var _dateCounter = 0;

    List<Widget> getWidget(i) {
      //прокинуть данные с блока
      final widgets = <Widget>[];
      for (var j = 1; j <= 7; j++) {
        if (i == 0 && j < firstDateOfMonth!) {
          //Верхний хвост календаря
          var lastDayNumBeforeCurMonth =
              prevMonthLastDay - (firstDateOfMonth - j) - 1;
          widgets.add(cellWidget(lastDayNumBeforeCurMonth.toString(), 'grey',
              getMonth(-1), getYear()));
        } else if (i >= 4 && date > daysInMonth) {
          //Нижний хвост календаря
          var firstDayNumberAfterCurMonth = nextMonthFirsttDay + _dateCounter;
          _dateCounter++;
          widgets.add(cellWidget(firstDayNumberAfterCurMonth.toString(), 'grey',
              getMonth(1), getYear()));
        } else if (date > daysInMonth) {
          break;
        } else {
          var dates = date.toString();
          widgets
              .add(cellWidget(dates, 'black', getMonth(0), getYear())); //сюда
          date++;
        }
      }
      return widgets;
    }

    List<Widget> getList() {
      //bloc
      final children = <Widget>[];
      for (var i = 0; i < 6; i++) {
        children.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getWidget(i), // отправить данные с блока
        ));
      }
      return children;
    }

    return Column(
      children: getList(), //bloc
    );
  }

  Widget cellWidget(String text, String color, String month, String year) {
    var textColor;
    switch (color) {
      case 'grey':
        textColor = Colors.grey;
        break;
      case 'black':
        textColor = Colors.black;
        break;
      default:
        textColor = Colors.black;
    }

    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(100),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DayScreen(date: text, month: month, year: year)),
          );
        },
        child: SizedBox(
          width: 45,
          height: 45,
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: textColor),
          )),
        ),
      ),
    );
  }
}
