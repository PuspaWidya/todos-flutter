import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todos/model/todosModel.dart';
import 'dart:io';

const String apiEndPoint = "https://jsonplaceholder.typicode.com/todos";

Future<dynamic> getTodos() async {
  try {
    final http.Response response = await http
        .get(Uri.parse(apiEndPoint), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final jsonObject = json.decode(response.body);
      return jsonObject.map((e) => TodosModel.fromJson(e)).toList();
    } else {
      throw Exception("Request error");
    }
  } on SocketException {
    print('No Internet connection ');
  }
}

Future<dynamic> changeComplete(int id, payload) async {
  try {
    final http.Response response = await http.put(
      Uri.parse('$apiEndPoint/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo.');
    }
  } on SocketException {
    print('No Internet connection 😑');
  }
}

Future<dynamic> deleteTodo(int id) async {
  try {
    final http.Response response = await http.delete(
      Uri.parse('${apiEndPoint}/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // return TodosModel.fromJson(jsonDecode(response.body));

      return {'statusCode': response.statusCode, 'message': 'success'};
    } else {
      throw Exception('Failed to delete todo.');
    }
  } on SocketException {
    print('No Internet connection ');
  }
}

Future<dynamic> saveTodo(payload) async {
  try {
    print(payload);
    final http.Response response = await http.post(
      Uri.parse(apiEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'title': payload}),
    );

    if (response.statusCode == 201) {
      // return TodosModel.fromJson(jsonDecode(response.body));
      return {'statusCode': response.statusCode, 'message': 'success'};
    } else {
      throw Exception('Failed to save todo.');
    }
  } on SocketException {
    print('No Internet connection ');
  }
}
