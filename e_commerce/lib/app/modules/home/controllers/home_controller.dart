import 'package:get/get.dart';

import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  final List<ProductModel> products = [
    const ProductModel(
      id: 'nike-air-jordan-1-retro-high',
      name: 'Nike Air Jordan 1 Retro High',
      category: 'Basketball',
      price: 2499000,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1552346154-21d32810aba3?w=500&q=80',
    ),
    const ProductModel(
      id: 'nike-air-force-1-07-triple-white',
      name: 'Nike Air Force 1 07 Triple White',
      category: 'Lifestyle',
      price: 1549000,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=500&q=80',
    ),
    const ProductModel(
      id: 'adidas-ultraboost-light-running',
      name: 'Adidas Ultraboost Light Running',
      category: 'Running',
      price: 2899000,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=500&q=80',
    ),
    const ProductModel(
      id: 'puma-suede-classic-xxi-black',
      name: 'Puma Suede Classic XXI Black',
      category: 'Casual',
      price: 1099000,
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500&q=80',
    ),
    const ProductModel(
      id: 'new-balance-574-core-grey',
      name: 'New Balance 574 Core Grey',
      category: 'Lifestyle',
      price: 1499000,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1539185441755-769473a23570?w=500&q=80',
    ),
    const ProductModel(
      id: 'vans-old-skool-classic-skate',
      name: 'Vans Old Skool Classic Skate',
      category: 'Skate',
      price: 999000,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=500&q=80',
    ),
  ];

  final List<String> categories = [
    'Semua',
    'Lifestyle',
    'Running',
    'Basketball',
    'Skate',
    'Casual',
  ];

  final selectedCategory = 'Semua'.obs;

  // Menyimpan ID produk yang masuk wishlist.
  final favoriteIds = <String>{}.obs;

  List<ProductModel> get filteredProducts {
    if (selectedCategory.value == 'Semua') {
      return products;
    }

    return products
        .where((product) => product.category == selectedCategory.value)
        .toList();
  }

  int get productCount => filteredProducts.length;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  bool isFavorite(String productId) {
    return favoriteIds.contains(productId);
  }

  void toggleFavorite(String productId) {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }
  }
}
