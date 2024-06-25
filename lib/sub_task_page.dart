import 'package:flutter/material.dart';
import 'package:scheduler_app/home_page.dart';

class SubtasksPage extends StatelessWidget {
  final Task task;

  const SubtasksPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
      ),
      body: ListView(
        children: [
          // Display subtasks here
          // Example:
          ...task.subtasks.map((subtask) {
            return ListTile(
              leading: Checkbox(
                value: subtask.completed,
                onChanged: (bool? value) {
                  // Update subtask completion
                  subtask.completed = value!;
                },
              ),
              title: Text(subtask.name),
            );
          }).toList(),
        ],
      ),
    );
  }
}
