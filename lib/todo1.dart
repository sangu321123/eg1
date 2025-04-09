import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addOrUpdateTask({int? index}) {
    if (_controller.text.isNotEmpty) {
      setState(() {
        if (index == null) {
          tasks.add(_controller.text.trim());
        } else {
          tasks[index] = _controller.text.trim();
        }
      });
      _controller.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() => tasks.removeAt(index));
  }

  void _showTaskDialog({int? index}) {
    if (index != null) _controller.text = tasks[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? "Add Task" : "Edit Task"),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Enter task",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _controller.clear();
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _addOrUpdateTask(index: index);
              Navigator.pop(context);
            },
            child: Text(index == null ? "Add" : "Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: tasks.isEmpty
            ? Center(child: Text("No tasks yet. Tap + to add one."))
            : ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Card(
              child: ListTile(
                title: Text(tasks[index]),
                onTap: () => _showTaskDialog(index: index),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteTask(index),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
