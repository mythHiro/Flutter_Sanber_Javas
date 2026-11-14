import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../../data/models/cart_item_model.dart';

class CartController extends GetxController {
  // Satu sumber data untuk seluruh item keranjang.
  final RxList<CartItemModel> items = <CartItemModel>[].obs;

  // Jumlah seluruh produk dalam keranjang.
  int get totalItems {
    return items.fold(0, (total, item) => total + item.quantity);
  }

  // Subtotal sebelum pajak dan ongkir.
  int get subtotal {
    return items.fold(0, (total, item) => total + item.subtotal);
  }

  // PPN 11%.
  int get tax => (subtotal * 0.11).round();

  // Gratis ongkir jika subtotal minimal Rp2.000.000.
  // Tarif ongkir normal akan disesuaikan dengan ketentuan materi.
  static const int standardShippingFee = 20000;

  int get shippingCost {
    if (subtotal >= 2000000) return 0;
    return items.isEmpty ? 0 : standardShippingFee;
  }

  // Total pembayaran.
  int get totalAmount => subtotal + tax + shippingCost;

  // Menambahkan produk ke keranjang.
  // Produk dengan ID dan ukuran sama akan digabung.
  void addItem(ProductModel product, {int quantity = 1, int size = 42}) {
    if (quantity <= 0) return;

    final itemId = '${product.id}_$size';

    final index = items.indexWhere((item) => item.id == itemId);

    if (index != -1) {
      items[index].quantity += quantity;
      items.refresh();
    } else {
      items.add(
        CartItemModel(product: product, selectedSize: size, quantity: quantity),
      );
    }
  }

  // Menambah kuantitas item.
  void increaseQuantity(String id) {
    final index = items.indexWhere((item) => item.id == id);

    if (index == -1) return;

    items[index].quantity++;
    items.refresh();
  }

  // Mengurangi kuantitas item.
  // Jika mencapai nol, item otomatis dihapus.
  void decreaseQuantity(String id) {
    final index = items.indexWhere((item) => item.id == id);

    if (index == -1) return;

    if (items[index].quantity > 1) {
      items[index].quantity--;
      items.refresh();
    } else {
      items.removeAt(index);
    }
  }

  // Menghapus satu item.
  void removeItem(String id) {
    items.removeWhere((item) => item.id == id);
  }

  // Mengosongkan keranjang.
  void clearCart() {
    items.clear();
  }

  // Format angka menjadi Rupiah.
  String formatRupiah(int amount) {
    final formatted = amount.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp $formatted';
  }
}
