import 'dart:developer';

// import 'package:api_getx/model/user_model.dart';
import 'package:get/get.dart';
import 'package:todos/model/todosModel.dart';

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
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
