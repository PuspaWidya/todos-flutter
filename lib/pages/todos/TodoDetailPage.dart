import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/todoApi.dart';

enum menuItems { delete, save }

class TodoDetailPage extends StatefulWidget {
  // dynamic todo;
  TodoDetailPage({super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  final TextEditingController _controller = TextEditingController();

  var todos;
  var id;

  void onInit() {
    if (Get.arguments != null) {
      todos = Get.arguments['todosTitle'];
      id = Get.arguments['id'];
    }
  }

  @override
  void initState() {
    super.initState();
    onInit();
    if (todos != null) {
      _controller.text = todos;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleDeleteAndSave(payload) async {
    var response;
    if (payload == menuItems.delete) {
      if (todos != null) {
        response = await deleteTodo(id);
      }
    } else {
      if (id == null) {
        response = await saveTodo(_controller.text);
      } else {
        response = await updateTodo(id, _controller.text);
      }
    }

    Get.snackbar(
      'Success!',
      'May you have a good day',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
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
                Get.back();
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
