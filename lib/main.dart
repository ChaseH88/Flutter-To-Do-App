import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoWidget(),
    );
  }
}

class ToDoWidget extends StatefulWidget {
  @override
  _ToDoWidgetState createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  List<Map<String, dynamic>> toDoArr = [];
  String taskInput = '';

  void addToDoItem(String task) {
    String key = DateTime.now().millisecondsSinceEpoch.toString();
    setState(() {
      toDoArr.add({
        'key': key,
        'task': task,
        'isComplete': false,
      });
    });
  }

  void handleSubmit() {
    addToDoItem(taskInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add a To Do Item!',
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  taskInput = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: toDoArr.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(toDoArr[index]['task']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleSubmit,
        tooltip: 'Add To Do Item',
        child: Icon(Icons.add),
      ),
    );
  }
}
