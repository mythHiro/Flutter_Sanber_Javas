import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../home/controllers/home_controller.dart';

class WishlistController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final CartController cartController = Get.find<CartController>();

  List<ProductModel> get wishlistProducts {
    return homeController.products
        .where((product) => homeController.isFavorite(product.id))
        .toList();
  }

  void removeFromWishlist(ProductModel product) {
    homeController.toggleFavorite(product.id);
  }

  void addToCart(ProductModel product) {
    cartController.addItem(product);
  }
}
