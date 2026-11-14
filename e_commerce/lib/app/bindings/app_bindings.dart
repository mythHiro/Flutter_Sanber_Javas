import 'package:get/get.dart';

import '../modules/cart/controllers/cart_controller.dart';
import '../modules/home/controllers/home_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true);

    Get.put<CartController>(CartController(), permanent: true);
  }
}
