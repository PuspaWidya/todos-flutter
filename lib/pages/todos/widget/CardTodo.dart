import 'package:flutter/material.dart';
import 'package:todos/api/todoApi.dart';

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
                  changeCompleteTodo(widget.todo.id, value);
                });
              },
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: widget.todo,
                  );
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
