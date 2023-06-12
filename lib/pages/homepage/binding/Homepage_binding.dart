import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataController>(
      () => DataController(),
    );
  }
}
