import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/main_controller/main_controller.dart';
import 'package:todos/router/router.dart';
import 'pages/homepage/Homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeCont = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeCont.themeValue.value
                ? ThemeData.dark()
                : ThemeData(
                    primarySwatch: Colors.blue,
                  ),
            getPages: appRoutes(),
          )),
    );
  }
}
