import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/pages/todos/TodoDetailPage.dart';
import 'package:todos/pages/todos/widget/CardTodo.dart';
import '../../api/todoApi.dart';
import '../../main_controller/main_controller.dart';
import 'controller/home_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final themeCont = Get.find<ThemeController>();

  final DataController controller = Get.put(DataController());

  dynamic todoResponse;

  fetchTodos() async {
    controller.getTodosApi();
  }

  @override
  void initState() {
    fetchTodos();
    super.initState();
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
            icon: const Icon(Icons.invert_colors_on_outlined),
            tooltip: 'Show the alert',
            color: Colors.blue.shade400,
            onPressed: (() => themeCont.changeTheme()),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.apps_rounded),
          tooltip: 'Show the alert',
          color: Colors.blue.shade400,
          onPressed: (() => null),
        ),
      ),
      body: Obx(() => Container(
            child: controller.todos_model.isEmpty
                ? Center(
                    child: Text('There is no todos available'),
                  )
                : ListView.builder(
                    itemCount: controller.todos_model.value.isNotEmpty
                        ? controller.todos_model.value.length
                        : 0,
                    itemBuilder: ((context, index) {
                      final itemTodo = controller.todos_model.value[index];
                      return GestureDetector(
                        child: CardTodo(todo: itemTodo),
                      );
                    }),
                  ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => TodoDetailPage());
          // Get.toNamed('/details');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
