import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/api/todoApi.dart';

import '../TodoDetailPage.dart';

class CardTodo extends StatefulWidget {
  final todo;
  const CardTodo({super.key, this.todo});

  @override
  State<CardTodo> createState() => _CardTodoState();
}

changeCompleteTodo(id, value) {
  changeComplete(id, {'complete': value});
}

class _CardTodoState extends State<CardTodo> {
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
              onChanged: (bool? value) {
                setState(() {
                  widget.todo.completed = value;
                  print(widget.todo.completed);
                  changeCompleteTodo(widget.todo.id, value);
                });
              },
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => TodoDetailPage(), arguments: {
                    'todosTitle': widget.todo.title,
                    'id': widget.todo.id
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
