import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/task_screen.dart';

void main() {
  runApp(ProviderScope(child: TaskMasterApp()));
}

class TaskMasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Master',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskScreen(),
    );
  }
}
