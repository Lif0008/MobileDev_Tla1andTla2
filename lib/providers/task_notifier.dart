import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(String title) {
    final task = Task(id: DateTime.now().toString(), title: title);
    state = [...state, task];
  }

  void toggleTaskCompletion(String id) {
    state = state.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}

// Create a provider for the TaskNotifier
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
