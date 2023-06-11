import 'package:flutter/material.dart';

import 'api/todoApi.dart';

enum menuItems { delete, save }

class TodoDetailPage extends StatefulWidget {
  dynamic todo;
  TodoDetailPage({super.key, this.todo});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _controller.text = '${widget.todo.title}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleDeleteAndSave(payload) async {
    if (payload == menuItems.delete) {
      if (widget.todo != null) {
        await deleteTodo(widget.todo.id);
      }
    } else {
      if (widget.todo == null) {
        saveTodo(_controller.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.blue,
        ),
        actions: [
          PopupMenuButton(
            onSelected: (item) async {
              setState(() {
                handleDeleteAndSave(item);
                Navigator.pop(context);
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<menuItems>>[
              const PopupMenuItem<menuItems>(
                value: menuItems.save,
                child: Text('Save'),
              ),
              const PopupMenuItem<menuItems>(
                value: menuItems.delete,
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          expands: true,
          decoration: const InputDecoration.collapsed(
            hintText: 'Write yout todo here',
          ),
        ),
      ),
    );
  }
}
