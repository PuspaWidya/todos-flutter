import 'package:flutter/material.dart';
import 'package:todos/pages/todos/widget/CardTodo.dart';
import '../../api/todoApi.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic todoResponse;

  fetchTodos() async {
    var response = await getTodos();
    setState(() {
      todoResponse = response;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // bottomOpacity: 0.0,
        elevation: 0.0,
        title: const Center(
          child: Text(
            'Homepage',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.circle_notifications_outlined),
            tooltip: 'Show the alert',
            color: Colors.blue.shade400,
            onPressed: (() => null),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.apps_rounded),
          tooltip: 'Show the alert',
          color: Colors.blue.shade400,
          onPressed: (() => null),
        ),
      ),
      body: ListView.builder(
        itemCount: todoResponse == null ? 0 : todoResponse.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            child: CardTodo(todo: todoResponse[index]),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/details');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
