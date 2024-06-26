import 'package:flutter/material.dart';
import 'package:scheduler_app/sub_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Task> tasks = [];
  final TextEditingController _taskController = TextEditingController();
  bool isButtonEnabled = false;

  void addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));
    });
  }

  @override
  void initState() {
    super.initState();
    _taskController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      isButtonEnabled = _taskController.text.isNotEmpty;
    });
  }

  Future<void> addTaskDialogue() async {
    String newTask = "";
    _taskController.text = ""; // Clear the text field when showing the dialog
    isButtonEnabled = false; // Initially disable the button
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: 160, // Adjust the height as needed
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _taskController,
                        onChanged: (value) {
                          newTask = value;
                          setState(() {
                            isButtonEnabled = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'New Task',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: isButtonEnabled
                                ? () {
                                    addTask(newTask);
                                    Navigator.pop(context);
                                  }
                                : null,
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                isButtonEnabled ? Colors.blue : Colors.grey,
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scheduler'),
        ),
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubtasksPage(task: task),
                  ),
                )
              },
              contentPadding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey[900], // Example background color
                ),
                child: ListTile(
                  title: Text(
                    task.name,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addTaskDialogue,
          tooltip: "Add task",
          backgroundColor: Color.fromARGB(255, 136, 255, 0),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
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
