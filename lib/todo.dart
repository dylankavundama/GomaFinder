import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:upato/m.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}



class _TaskListPageState extends State<TaskListPage> {


  // @override
  // void initState() {
  //   super.initState();
  //   _initDatabase();
  //   _startTimer();
  // }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }



  Future<void> _initDatabase() async {
    // Initialisation de la base de données
  }

  Future<void> _refreshTasks() async {
    // Actualisation des tâches
  }

  Future<void> _addTask(String title, DateTime dueDate) async {
    // Ajout d'une tâche
  }

  Future<void> _updateTask(Task task) async {
    // Mise à jour d'une tâche
  }

  Future<void> _scheduleNotification(String title, DateTime dueDate) async {
    // Planification d'une notification
  }

  // void _updateMinutesRemaining() {
  //   final now = DateTime.now();
  //   final closestTask = _tasks
  //       .where((task) => task.dueDate.isAfter(now))
  //       .reduce((a, b) => a.dueDate.difference(now) < b.dueDate.difference(now) ? a : b);
  //   final difference = closestTask.dueDate.difference(now);
  //   setState(() {
  //     _minutesRemaining = difference.inMinutes;
  //   });
  // }


late Future<Database> _database;
  TextEditingController _textEditingController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<Task> _tasks = [];
  late Timer _timer;
  int _minutesRemaining = 0;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _updateMinutesRemaining();
      });
    });
  }

  void _updateMinutesRemaining() {
    final now = DateTime.now();
    final closestTask = _tasks
        .where((task) => task.dueDate.isAfter(now))
        .reduce((a, b) => a.dueDate.difference(now) < b.dueDate.difference(now) ? a : b);
    final difference = closestTask.dueDate.difference(now);
    final totalMinutes = difference.inMinutes;
    setState(() {
      _minutesRemaining = totalMinutes;
    });
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
                  subtitle:             Text(
            '$_minutesRemaining minutes remaining',
            style: TextStyle(fontSize: 18,
            
            color: Colors.amber),
          ),
                  trailing: Checkbox(
                    value: task.completed,
                    onChanged: (value) {
                      setState(() {
                        task.completed = value!;
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
                Text("$_minutesRemaining minutes remaining"),
              ],
            ),
          ),
        ],
      ),
    );

    
  }

  
}



  

