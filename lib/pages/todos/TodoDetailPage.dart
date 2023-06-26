import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/model/todosModel.dart';
import 'dart:math';
import '../../api/todoApi.dart';
import '../homepage/controller/home_controller.dart';

enum menuItems { delete, save }

class TodoDetailPage extends StatefulWidget {
  // dynamic todo;
  TodoDetailPage({super.key});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  TextEditingController controllerText = TextEditingController();

  final DataController controller = Get.put(DataController());

  Random random = new Random();

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
      controllerText.text = todos;
    }
  }

  @override
  void dispose() {
    controllerText.dispose();
    super.dispose();
  }

  void handleDeleteAndSave(payload) async {
    var response;
    if (payload == menuItems.delete) {
      if (todos != null) {
        // response = await deleteTodo(id);
        response = await controller.deleteTodo(id);
      }
    } else {
      if (id == null) {
        // response = await saveTodo(controllerText.text);
        response = await controller.createTodo(controllerText.text);
      } else {
        // response = await updateTodo(id, _controller.text);
        response = await controller.updateTodo(id, controllerText.text);
      }
    }

    if (response == true) {
      Get.back();

      Get.snackbar(
        'Success!',
        'May you have a good day',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
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
          controller: controllerText,
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
