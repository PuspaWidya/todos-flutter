import 'package:flutter/material.dart';
import 'package:todos/pages/homepage/binding/Homepage_binding.dart';
import '../pages/homepage/Homepage.dart';
import '../pages/todos/TodoDetailPage.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/',
        page: () => MyHomePage(),
        transition: Transition.fade,
        binding: HomeScreenBinding(),
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/details',
        page: () => TodoDetailPage(),
        // middlewares: [MyMiddelware()],
        transition: Transition.fade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    ];
