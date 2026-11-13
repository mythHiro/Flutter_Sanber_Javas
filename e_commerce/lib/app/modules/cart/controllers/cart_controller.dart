import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class CartController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  List<Map<String, dynamic>> get cartItems => homeController.cartItems;

  int get totalItems => homeController.cartCount.value;

  int get subtotal {
    return cartItems.fold<int>(0, (total, item) {
      final price =
          int.tryParse(
            item['price'].toString().replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;

      final quantity = item['quantity'] as int? ?? 1;
      return total + (price * quantity);
    });
  }

  int get discount => subtotal >= 1000000 ? 150000 : 0;

  int get totalPayment => subtotal - discount;

  void increaseQuantity(int index) {
    final item = cartItems[index];
    final quantity = (item['quantity'] as int? ?? 1) + 1;

    homeController.updateCartQuantity(index, quantity);
  }

  void decreaseQuantity(int index) {
    final item = cartItems[index];
    final quantity = (item['quantity'] as int? ?? 1) - 1;

    if (quantity >= 1) {
      homeController.updateCartQuantity(index, quantity);
    }
  }

  void removeItem(int index) {
    homeController.removeCartItem(index);
  }

  void clearCart() {
    homeController.clearCart();
  }

  String formatRupiah(int amount) {
    final formatted = amount.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp $formatted';
  }
}
