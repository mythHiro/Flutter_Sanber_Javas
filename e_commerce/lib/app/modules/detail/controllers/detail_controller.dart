
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class DetailController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  final selectedSize = 42.obs;
  final quantity = 1.obs;

  final sizes = [39, 40, 41, 42, 43, 44];

  late Map<String, dynamic> product;

  @override
  void onInit() {
    super.onInit();

    product = (Get.arguments as Map<String, dynamic>?) ?? {
      'title': 'Nike Air Jordan 1 Retro High',
      'category': 'Basketball',
      'price': 'Rp 2.499.000',
      'rating': 4.9,
      'image':
          'https://images.unsplash.com/photo-1552346154-21d32810aba3?w=500&q=80',
    };
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

  bool get isFavorite =>
      homeController.isFavorite(product['title'] as String);

  void toggleFavorite() {
    homeController.toggleFavorite(
      product['title'] as String,
    );
  }

  void addToCart() {
  homeController.addToCart(
    product: product,
    size: selectedSize.value,
    quantity: quantity.value,
  );
}
}
