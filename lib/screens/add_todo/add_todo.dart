import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/todo.dart';
import '../../client/hive_names.dart';

class AddTodo extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String task;
  String note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    initialValue: "",
                    decoration: const InputDecoration(
                      labelText: "Task",
                    ),
                    onChanged: (value) {
                      setState(() {
                        task = value;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: "",
                    decoration: const InputDecoration(
                      labelText: "Note",
                    ),
                    onChanged: (value) {
                      setState(() {
                        note = value;
                      });
                    },
                  ),
                  OutlineButton(
                    child: Text("Add"),
                    onPressed: _onFormSubmit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Todo> contactsBox = Hive.box<Todo>(HiveBoxes.todo);
    contactsBox.add(Todo(task: task, note: note));
    Navigator.of(context).pop();
  }
}
