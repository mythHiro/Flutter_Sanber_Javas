import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../home/controllers/home_controller.dart';

class DetailController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final CartController cartController = Get.find<CartController>();

  final selectedSize = 42.obs;
  final quantity = 1.obs;

  final sizes = [39, 40, 41, 42, 43, 44];

  late ProductModel product;

  @override
  void onInit() {
    super.onInit();

    final argument = Get.arguments;

    product = argument is ProductModel
        ? argument
        : homeController.products.first;
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void selectSize(int size) {
    selectedSize.value = size;
  }

  bool get isFavorite => homeController.isFavorite(product.id);

  void toggleFavorite() {
    homeController.toggleFavorite(product.id);
  }

  void addToCart() {
    cartController.addItem(
      product,
      size: selectedSize.value,
      quantity: quantity.value,
    );
  }
}
