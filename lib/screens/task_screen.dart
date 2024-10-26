import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../providers/task_notifier.dart';

class TaskScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Task Master')),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'No tasks available. Add a task to get started!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: task.isCompleted ? Colors.lightGreen[100] : Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) {
                        ref.read(taskProvider.notifier).toggleTaskCompletion(task.id);
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        ref.read(taskProvider.notifier).deleteTask(task.id);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, ref),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final title = _controller.text;
                if (title.isNotEmpty) {
                  ref.read(taskProvider.notifier).addTask(title);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
