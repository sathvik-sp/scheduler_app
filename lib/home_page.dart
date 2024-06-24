import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Task> tasks = [];

  void addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));
    });
  }

  Future<void> addTaskDialogue() async {
    String newTask = "";
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(hintText: "Enter task here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Add"),
              onPressed: () {
                addTask(newTask);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addSubtaskDialogue(Task task) async {
    String newSubtask = "";
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Subtask"),
          content: TextField(
            onChanged: (value) {
              newSubtask = value;
            },
            decoration: InputDecoration(hintText: "Enter subtask here"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Add"),
              onPressed: () {
                setState(() {
                  task.subtasks.add(Subtask(name: newSubtask));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scheduler'),
        ),
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ExpansionTile(
                title: Text(task.name),
                children: task.subtasks.map((subtask) {
                  return ListTile(
                    leading: Checkbox(
                      value: subtask.completed,
                      onChanged: (bool? value) {
                        setState(() {
                          subtask.completed = value!;
                        });
                      },
                    ),
                    title: Text(subtask.name),
                  );
                }).toList(),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => addSubtaskDialogue(task),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addTaskDialogue,
          tooltip: "Add task",
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class Task {
  String name;
  List<Subtask> subtasks = [];

  Task({required this.name});
}

class Subtask {
  String name;
  bool completed = false;

  Subtask({required this.name});
}

void main() {
  runApp(HomePage());
}
