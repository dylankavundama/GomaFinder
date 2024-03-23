import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:upato/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListPage(),
    );
  }
}

class Task {
  final int id;
  final String title;
  late final bool completed;
  final DateTime dueDate;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed ? 1 : 0,
      'dueDate': dueDate.millisecondsSinceEpoch,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      completed: map['completed'] == 1,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
    );
  }
}

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late Future<Database> _database;
  TextEditingController _textEditingController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<Task> _tasks = [];
  int _minutesRemaining = 0;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _startTimer(); // Start the timer
  }

  Future<void> _initDatabase() async {
    _database = openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, completed INTEGER, dueDate INTEGER)',
        );
      },
      version: 1,
    );
    _refreshTasks();
  }

  Future<void> _refreshTasks() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    setState(() {
      _tasks = List.generate(
        maps.length,
        (i) {
          return Task(
              id: maps[i]['id'],
              title: maps[i]['title'],
              completed: maps[i]['completed'] == 1,
              dueDate: DateTime.fromMillisecondsSinceEpoch(maps[i]['dueDate']));
        },
      );
    });
    _updateMinutesRemaining();
  }

  Future<void> _addTask(String title, DateTime dueDate) async {
    final Database db = await _database;
    await db.insert(
      'tasks',
      {
        'title': title,
        'completed': 0,
        'dueDate': dueDate.millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Schedule a notification for the due date of the task
    await _scheduleNotification(title, dueDate);

    _refreshTasks();
  }

  Future<void> _scheduleNotification(String title, DateTime dueDate) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Create a notification details
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      'Channel Description',
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Task Reminder',
      'Task "$title" is due!',
      tz.TZDateTime.from(dueDate, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  void _updateMinutesRemaining() {
    setState(() {
      _minutesRemaining = 0;
      final now = DateTime.now();
      for (final task in _tasks) {
        final difference = task.dueDate.difference(now);
        final minutes = difference.inMinutes;
        if (minutes > 0 &&
            (_minutesRemaining == 0 || minutes < _minutesRemaining)) {
          _minutesRemaining = minutes;
        }
      }
    });
  }

  void _startTimer() {
    const Duration updateInterval = Duration(minutes: 1);
    Timer.periodic(updateInterval, (timer) {
      if (_minutesRemaining > 0) {
        setState(() {
          _minutesRemaining--;
        });
      }
    });
  }

  void _deleteTask(int taskId) async {
    _confirmDeleteTask(taskId); // Show confirmation dialog
  }

  Future<void> _confirmDeleteTask(int taskId) async {
    final BuildContext context =
        this.context; // Récupérer explicitement le contexte

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible:
          false, // L'utilisateur doit appuyer sur un bouton pour fermer la boîte de dialogue
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer la tâche'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Êtes-vous sûr de vouloir supprimer cette tâche ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: SousTStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Supprimer', style: SousTStyle),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _deleteTaskConfirmed(taskId);
    }
  }

  Future<void> _deleteTaskConfirmed(int taskId) async {
    final db = await _database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
    _refreshTasks(); // Rafraîchir la liste des tâches après la suppression
  }

  String _formatDueDate(DateTime dueDate) {
    // Your formatting logic here
    // For example:
    return dueDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CouleurPrincipale),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 0),
            ),
            Text(
              'Bloc Note',
              style: DescStyle,
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  leading: Icon(
                    Icons.task_alt_outlined,
                    color: CouleurPrincipale,
                  ),

                  title: Text(task.title),
                  subtitle: Text(
                      "Due: ${_formatDueDate(task.dueDate)}"), // Format the due date
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteTask(task.id);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    labelText: "Entrer l'intitulé de la tache",
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Select date:"),
                    TextButton(
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            _selectedDate = selectedDate;
                          });
                        }
                      },
                      child: Text(
                        "${_selectedDate.toLocal()}".split(' ')[0],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            _selectedTime = selectedTime;
                          });
                        }
                      },
                      child: Text(
                        "${_selectedTime.hour}:${_selectedTime.minute}",
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(CouleurPrincipale)),
                  onPressed: () {
                    if (_textEditingController.text.isNotEmpty) {
                      final dueDateTime = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        _selectedTime.hour,
                        _selectedTime.minute,
                      );
                      _addTask(_textEditingController.text, dueDateTime);
                      _textEditingController.clear();
                    }
                  },
                  child: Text("Ajouter la tâche ?"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateTask(Task task) async {
    final db = await _database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
