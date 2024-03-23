import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
  final DateTime dueDate; // Ajout de la date prévue pour la tâche

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
      'dueDate': dueDate.millisecondsSinceEpoch, // Enregistrement de la date prévue en millisecondes
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      completed: map['completed'] == 1,
      dueDate: DateTime.fromMillisecondsSinceEpoch(
          map['dueDate']), // Récupération de la date à partir des millisecondes
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

  @override
  void initState() {
    super.initState();
    _initDatabase();
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
  }

Future<void> _addTask(String title, DateTime dueDate) async {
  final Database db = await _database;
  await db.insert(
    'tasks',
    {
      'title': title,
      'completed': 0,
      'dueDate': dueDate
          .millisecondsSinceEpoch, // Enregistrement de la date prévue en millisecondes
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
        
    'channel_id', // Change to your desired channel id
    'Channel Name', // Change to your desired channel name
    'Channel Description', // Change to your desired channel description
  );
  final NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // Change to a unique id for the notification
    'Task Reminder', // Notification title
    'Task "$title" is due!', // Notification body
    tz.TZDateTime.from(dueDate, tz.local), // Scheduled date and time
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text("Due: ${task.dueDate}"),
                  trailing: Checkbox(
                    value: task.completed,
                    onChanged: (value) {
                      setState(() {
                        task.completed = value!;
                        // Update the task completion status in the database
                        _updateTask(task);
                      });
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
                  decoration: InputDecoration(
                    labelText: 'Enter task',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select date:"),
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
                  child: Text("Add Task"),
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
