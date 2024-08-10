import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simple_todo_app/core/constants.dart';
import 'package:simple_todo_app/core/local_notifications/local_notifications_service.dart';
import 'package:simple_todo_app/core/model/task_model.dart';

class PendingTasksDbServices with ChangeNotifier {
  late Box box;
  final List<TaskModel> _allTasks = []; // List to store tasks for display
  final List<Map<String, dynamic>> _hiveTasks =
      []; // List to store tasks for storing in Hive

  List<TaskModel> get getAllTasks => _allTasks;
  int get getCurrentTaskIndex => _allTasks.length;

  Future<void> initDatabase() async {
    box = await Hive.openBox(PENDING_TASK_HIVE_BOX_NAME);
  }

  void _addTasksToDisplayList() {
    List tasks = box.get(PENDING_TASK_HIVE_BOX_NAME);

    for (final task in tasks) {
      _allTasks.add(TaskModel.fromMap(Map.from(task)));
    }
  }

  void _addTasksToHiveList() {
    _hiveTasks.clear();

    for (final task in _allTasks) {
      _hiveTasks.add(task.toMap());
    }
  }

  Future<void> storePreviousData() async {
    await initDatabase();
    if (box.keys.contains(PENDING_TASK_HIVE_BOX_NAME)) {
      _addTasksToDisplayList();

      notifyListeners();
    }
  }

  void addTask({
    required TaskModel newTask,
  }) async {
    await initDatabase();

    _allTasks.insert(0, newTask);

    _addTasksToHiveList();

    box.put(PENDING_TASK_HIVE_BOX_NAME, _hiveTasks);

    notifyListeners();
  }

  void updateSpecificTask(TaskModel newTask, int taskIndex) async {
    await initDatabase();

    _allTasks[taskIndex] = newTask;

    _addTasksToHiveList();

    box.put(PENDING_TASK_HIVE_BOX_NAME, _hiveTasks);
    notifyListeners();
  }

  void deleteSpecificTask(int taskIndex) async {
    await initDatabase();

    _allTasks.removeAt(taskIndex);

    _addTasksToHiveList();

    box.put(PENDING_TASK_HIVE_BOX_NAME, _hiveTasks);
    notifyListeners();
  }

  void deleteDatabase() async {
    await initDatabase();
    
    LocalNotificationsService().cancelAllNotification();
    box.deleteFromDisk();
    _hiveTasks.clear();
    _allTasks.clear();
    notifyListeners();
  }
}
