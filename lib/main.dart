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

  void removeToDoItem(String key) {
    setState(() {
      toDoArr.removeWhere((item) => item['key'] == key);
    });
  }

  void markToDoItemComplete(String key) {
    setState(() {
      var item = toDoArr.firstWhere((item) => item['key'] == key);
      item['isComplete'] = !item['isComplete'];
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
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'To Do List',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(14),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      taskInput = value;
                    });
                  },
                )),
            ToDoListWidget(
              toDoArr: toDoArr,
              markToDoItemComplete: markToDoItemComplete,
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

class ToDoListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> toDoArr;
  final Function markToDoItemComplete;

  ToDoListWidget({this.toDoArr, this.markToDoItemComplete});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: toDoArr.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: toDoArr[index]['isComplete']
                ? Text(
                    toDoArr[index]['task'],
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  )
                : Text(toDoArr[index]['task']),
            trailing: Checkbox(
              value: toDoArr[index]['isComplete'],
              onChanged: (value) {
                markToDoItemComplete(toDoArr[index]['key']);
              },
            ),
          );
        },
      ),
    );
  }
}
