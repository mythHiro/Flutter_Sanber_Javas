import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/product_model.dart';
import '../../../data/repository/product_repository.dart';
import '../../../core/network/result.dart';

class HomeController extends GetxController {
  final ProductRepository repository;

  HomeController({required this.repository});

  // Katalog lokal sebagai fallback ketika API gagal.
  final RxList<ProductModel> products = <ProductModel>[
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
  ].obs;

  final List<String> categories = [
    'Semua',
    'Lifestyle',
    'Running',
    'Basketball',
    'Skate',
    'Casual',
  ];

  final selectedCategory = 'Semua'.obs;
  final favoriteIds = <String>{}.obs;

  // State networking.
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await repository.fetchProducts();

      if (result is Success<List<ProductModel>, String>) {
        final remoteProducts = result.data;

        products.assignAll(remoteProducts);

        Get.snackbar(
          'Katalog Berhasil Diperbarui',
          'Berhasil mengunduh ${remoteProducts.length} sepatu terbaru dari server!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF10B981),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          icon: const Icon(Icons.cloud_done, color: Colors.white),
        );
      } else if (result is Failure<List<ProductModel>, String>) {
        errorMessage.value = result.error;

        if (products.isNotEmpty) {
          Get.snackbar(
            'Mode Offline',
            'Koneksi server terputus. Menampilkan katalog offline.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
            icon: const Icon(Icons.cloud_off, color: Colors.white),
          );
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Filter kategori.
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

  // Wishlist.
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
