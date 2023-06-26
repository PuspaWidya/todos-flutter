import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/api/todoApi.dart';

import '../../homepage/controller/home_controller.dart';
import '../TodoDetailPage.dart';

class CardTodo extends StatefulWidget {
  final todo;
  const CardTodo({super.key, this.todo});

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {
  final DataController controller = Get.put(DataController());

  changeCompleteTodo(id, value) async {
    await controller.updateIsFinished(id, {'completed': value});
  }

  var completed;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 300,
        height: 100,
        child: Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              value: widget.todo.completed,
              // value: completed,
              onChanged: (bool? value) {
                setState(() {
                  changeCompleteTodo(widget.todo.id, value);
                });
              },
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => TodoDetailPage(), arguments: {
                    'todosTitle': widget.todo.title,
                    'id': widget.todo.id,
                  });
                },
                child: Text(
                  '${widget.todo.title}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
