import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  static const String boxName = 'tasks';
  late Box<Task> _box;

  List<Task> get tasks => _box.values.toList();

  Future<void> init() async {
    _box = await Hive.openBox<Task>(boxName);
    notifyListeners();
  }

  void addTask(Task task) {
    _box.put(task.id, task);
    notifyListeners();
  }

  void deleteTask(String id) {
    _box.delete(id);
    notifyListeners();
  }

  void toggleTask(String id) {
    final task = _box.get(id);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      task.save();
      notifyListeners();
    }
  }

  void editTask(String id, Task updated) {
    _box.put(id, updated);
    notifyListeners();
  }
}
