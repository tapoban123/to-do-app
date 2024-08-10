import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simple_todo_app/core/constants.dart';
import 'package:simple_todo_app/core/model/task_model.dart';

class CompletedTasksDbServices extends ChangeNotifier {
  late Box box;

  List<TaskModel> _allTasks = [];

  List<TaskModel> get allCompletedTasks => _allTasks;

  List<Map<String, dynamic>> _completedHiveTasks = [];

  Future<void> initHive() async {
    box = await Hive.openBox(COMPLETED_TASK_HIVE_BOX_NAME);
  }

  void _addAllTasksToHiveList() {
    _completedHiveTasks.clear();

    for (final task in _allTasks) {
      _completedHiveTasks.add(Map.from(task.toMap()));
    }
  }

  void _addAllTasksToDisplayList() {
    List getAllTasks = box.get(COMPLETED_TASK_HIVE_BOX_NAME);
    _allTasks.clear();

    for (final task in getAllTasks) {
      _allTasks.add(TaskModel.fromMap(Map.from(task)));
    }
  }

  void addTask(TaskModel completedTask) async {
    await initHive();
    _allTasks.insert(0, completedTask);

    _completedHiveTasks.clear();
    _addAllTasksToHiveList();
    box.put(COMPLETED_TASK_HIVE_BOX_NAME, _completedHiveTasks);
  }

  void getAllCompletedTasks() async {
    await initHive();

    if (box.keys.contains(COMPLETED_TASK_HIVE_BOX_NAME)) {
      _addAllTasksToDisplayList();
      notifyListeners();
    }
  }

  void deleteSpecificTask(int index) async {
    await initHive();

    _allTasks.removeAt(index);

    _addAllTasksToHiveList();
    box.put(COMPLETED_TASK_HIVE_BOX_NAME, _completedHiveTasks);
    notifyListeners();
  }

  void deleteAllCompletedTasks() async {
    await initHive();

    box.deleteFromDisk();
    _completedHiveTasks.clear();
    _allTasks.clear();
    notifyListeners();
  }
}
