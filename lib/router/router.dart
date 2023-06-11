import 'package:flutter/material.dart';
import '../pages/homepage/Homepage.dart';
import '../pages/todos/TodoDetailPage.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  final args = routeSettings.arguments;

  switch (routeSettings.name) {
    case "/":
      return MaterialPageRoute(builder: ((context) => const MyHomePage()));

    case "/details":
      return MaterialPageRoute(
          builder: ((context) => TodoDetailPage(todo: args)));
    default:
      return MaterialPageRoute(builder: ((context) => const MyHomePage()));
  }
}
