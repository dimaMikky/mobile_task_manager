import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test1/data/models/task_model.dart';
import 'dart:async';

import 'package:test1/domain/entities/task_entity.dart';

class NotesDatabase {
  final _dbName = 'tasks';
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE $_dbName ( 
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  date STRING,
  description TEXT
  )
  ''');
  }

  Future<void> create(TaskModel task) async {
    final db = await instance.database;

    await db.insert(_dbName, task.toMap());
  }

  Future<List<Map<String, Object?>>> getAllTasksByDate(date) async {
    final db = await instance.database;

    final result =
        await db.rawQuery('SELECT * FROM $_dbName WHERE date = "$date"');
    // await db.rawDelete(
    //     'DELETE FROM $_dbName WHERE description = ?', ['my first task']);
    return result;
  }
}
