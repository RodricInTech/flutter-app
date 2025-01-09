import 'package:flutter/material.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: ToDoList(),
        );
    }
}

class ToDoList extends StatefulWidget {
    @override
    _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
    final List<String> _toDoItems = [];
    final TextEditingController _textController = TextEditingController();

    void _addToDoItem(String task) {
        if (task.isNotEmpty) {
            setState(() {
                _toDoItems.add(task);
            });
            _textController.clear();
        }
    }

    void _removeToDoItem(int index) {
        setState(() {
            _toDoItems.removeAt(index);
        });
    }

    Widget _buildToDoItem(String toDoText, int index) {
        return ListTile(
            title: Text(toDoText),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeToDoItem(index),
            ),
        );
    }

    Widget _buildToDoList() {
        return ListView.builder(
            itemCount: _toDoItems.length,
            itemBuilder: (context, index) {
                return _buildToDoItem(_toDoItems[index], index);
            },
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('To-Do List'),
            ),
            body: Column(
                children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: _textController,
                            onSubmitted: _addToDoItem,
                            decoration: InputDecoration(
                                labelText: 'Enter a task',
                                border: OutlineInputBorder(),
                            ),
                        ),
                    ),
                    Expanded(
                        child: _buildToDoList(),
                    ),
                ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => _addToDoItem(_textController.text),
                child: Icon(Icons.add),
            ),
        );
    }
}