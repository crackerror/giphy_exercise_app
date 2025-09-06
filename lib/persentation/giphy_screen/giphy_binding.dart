import 'package:get/get.dart';
import 'package:giphy_exercise_app/persentation/giphy_screen/giphy_controller.dart';

class GiphyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GiphyController());
  }
}
