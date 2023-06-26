import 'dart:developer';

// import 'package:api_getx/model/user_model.dart';
import 'package:get/get.dart';
import 'package:todos/model/todosModel.dart';
import 'dart:math';

const String apiEndPoint = "https://64867bc9beba6297278ed1ac.mockapi.io/todos";

class DataController extends GetxController {
  var isDataLoading = false.obs;
  var isError = false.obs;
  var todos_model = [].obs;

  final GetConnect connect = GetConnect();

  void getTodosApi() async {
    try {
      isDataLoading(true);
      final response = await connect.get(apiEndPoint);
      if (response.statusCode == 200) {
        ///data successfully
        todos_model.value = response.body
            .map<TodosModel>((e) => TodosModel.fromJson(e))
            .toList();
      } else {
        isError(true);
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }

  Future<bool> updateTodo(id, payload) async {
    try {
      isDataLoading(true);
      final response =
          await connect.put("$apiEndPoint/$id", {"title": payload});

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Failed to make put request to edit todo");
      }

      final TodosModel targetTodo = TodosModel.fromJson(response.body);

      todos_model.value = todos_model.value.map<TodosModel>((e) {
        if (e.id == id) {
          return targetTodo;
        }
        return e;
      }).toList();

      todos_model.refresh();
      return true;
    } catch (error) {
      print('Error while update data is $error');
    } finally {
      isDataLoading(false);
    }
    return false;
  }

  Future<bool> deleteTodo(id) async {
    try {
      isDataLoading(true);
      final response = await connect.delete("$apiEndPoint/$id");
      if (response.statusCode != 200) {
        throw Exception("Failed to delete todo id : $id");
      }

      todos_model.value =
          todos_model.value.where((todo) => todo.id != id).toList();

      todos_model.refresh();
      return true;
    } catch (error) {
      print('Error while update data is $error');
    }
    isDataLoading(false);
    return false;
  }

  Future<dynamic> createTodo(payload) async {
    try {
      final Response response = await connect.post(apiEndPoint, {
        "userId": Random().nextInt(10000),
        "title": payload,
        "completed": false
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Failed to make post request to add todo");
      }

      todos_model.value.insert(0, TodosModel.fromJson(response.body));

      todos_model.refresh();
      update();
      return true;
    } catch (error) {
      print('Error while create data is $error');
    }
    return false;
  }

  Future<dynamic> updateIsFinished(id, payload) async {
    try {
      isDataLoading(true);
      final response = await connect.put("$apiEndPoint/$id", payload);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Failed to make put request to edit todo");
      }

      final TodosModel targetTodo = TodosModel.fromJson(response.body);

      todos_model.value = todos_model.value.map<TodosModel>((e) {
        if (e.id == id) {
          return targetTodo;
        }
        return e;
      }).toList();

      todos_model.refresh();
      return true;
    } catch (error) {
      print('Error while edit data is $error');
    }
  }
}
