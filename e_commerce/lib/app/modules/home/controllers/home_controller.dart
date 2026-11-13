import 'package:get/get.dart';

class HomeController extends GetxController {
  // Data produk
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Nike Air Jordan 1 Retro High',
      'category': 'Basketball',
      'price': 'Rp 2.499.000',
      'rating': 4.9,
      'image':
          'https://images.unsplash.com/photo-1552346154-21d32810aba3?w=500&q=80',
    },
    {
      'title': 'Nike Air Force 1 07 Triple White',
      'category': 'Lifestyle',
      'price': 'Rp 1.549.000',
      'rating': 4.8,
      'image':
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=500&q=80',
    },
    {
      'title': 'Adidas Ultraboost Light Running',
      'category': 'Running',
      'price': 'Rp 2.899.000',
      'rating': 4.7,
      'image':
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=500&q=80',
    },
    {
      'title': 'Puma Suede Classic XXI Black',
      'category': 'Casual',
      'price': 'Rp 1.099.000',
      'rating': 4.6,
      'image':
          'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500&q=80',
    },
    {
      'title': 'New Balance 574 Core Grey',
      'category': 'Lifestyle',
      'price': 'Rp 1.499.000',
      'rating': 4.8,
      'image':
          'https://images.unsplash.com/photo-1539185441755-769473a23570?w=500&q=80',
    },
    {
      'title': 'Vans Old Skool Classic Skate',
      'category': 'Skate',
      'price': 'Rp 999.000',
      'rating': 4.7,
      'image':
          'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=500&q=80',
    },
  ];

  // Daftar kategori
  final List<String> categories = [
    'Semua',
    'Lifestyle',
    'Running',
    'Basketball',
    'Skate',
    'Casual',
  ];

  // Reactive state
  final cartItems = <Map<String, dynamic>>[].obs;
  final cartCount = 0.obs;
  final selectedCategory = 'Semua'.obs;
  final favoriteProducts = <String>{}.obs;

  // Produk berdasarkan kategori aktif
  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory.value == 'Semua') {
      return products;
    }

    return products
        .where(
          (product) =>
              product['category'] == selectedCategory.value,
        )
        .toList();
  }

  // Jumlah produk yang sedang ditampilkan
  int get productCount => filteredProducts.length;

  // Memilih kategori
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Menambahkan produk ke keranjang
  void addToCart({
    required Map<String, dynamic> product,
    int size = 42,
    int quantity = 1,
  }) {
    if (quantity < 1) return;

    final index = cartItems.indexWhere(
      (item) =>
          item['title'] == product['title'] &&
          item['size'] == size,
    );

    if (index != -1) {
      final currentQuantity = cartItems[index]['quantity'] as int;
      cartItems[index]['quantity'] = currentQuantity + quantity;
      cartItems.refresh();
    } else {
      cartItems.add({
        ...product,
        'size': size,
        'quantity': quantity,
      });
    }

    _updateCartCount();
  }

  // Memperbarui jumlah item di keranjang
  void updateCartQuantity(int index, int quantity) {
    if (index < 0 || index >= cartItems.length || quantity < 1) return;

    cartItems[index]['quantity'] = quantity;
    cartItems.refresh();
    _updateCartCount();
  }

  // Menghapus item dari keranjang
  void removeCartItem(int index) {
    if (index < 0 || index >= cartItems.length) return;

    cartItems.removeAt(index);
    _updateCartCount();
  }

  // Mengosongkan keranjang
  void clearCart() {
    cartItems.clear();
    _updateCartCount();
  }

  // Menghitung total item di keranjang
  void _updateCartCount() {
    cartCount.value = cartItems.fold<int>(
      0,
      (total, item) => total + (item['quantity'] as int? ?? 1),
    );
  }

  // Mengecek status favorit
  bool isFavorite(String productTitle) {
    return favoriteProducts.contains(productTitle);
  }

  // Toggle wishlist
  void toggleFavorite(String productTitle) {
    if (favoriteProducts.contains(productTitle)) {
      favoriteProducts.remove(productTitle);
    } else {
      favoriteProducts.add(productTitle);
    }
  }
}
