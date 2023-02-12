import 'package:flutter/material.dart';

class ToDoListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> toDoArr;
  final Function markToDoItemComplete;
  final Function removeToDoItem;

  ToDoListWidget(
      {this.toDoArr, this.markToDoItemComplete, this.removeToDoItem});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: toDoArr.length,
        itemBuilder: (context, index) {
          final item = toDoArr[index];

          return Dismissible(
            key: Key(item['key']),
            onDismissed: (direction) {
              removeToDoItem(item['key']);
            },
            child: ListTile(
              title: item['isComplete']
                  ? Text(
                      item['task'],
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  : Text(item['task']),
              trailing: Checkbox(
                value: item['isComplete'],
                onChanged: (value) {
                  markToDoItemComplete(item['key']);
                },
              ),
            ),
            background: Container(
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
