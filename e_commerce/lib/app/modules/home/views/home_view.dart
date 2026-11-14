import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/app/core/theme/app_colors.dart';
import 'package:e_commerce/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import 'components/product_card.dart';
import 'components/promo_banner.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 600;

    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.directions_run_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                  children: const [
                    TextSpan(text: 'JaVs'),
                    TextSpan(
                      text: 'Store',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          // Tombol aksi untuk layar lebar
          if (!isCompact) ...[
            IconButton(
              tooltip: 'Wishlist Favorit',
              icon: const Icon(Icons.favorite_border_rounded),
              onPressed: () => Get.toNamed(Routes.WISHLIST),
            ),
            IconButton(
              tooltip: 'Riwayat Pesanan',
              icon: const Icon(Icons.receipt_long_outlined),
              onPressed: () => Get.toNamed(Routes.ORDERS),
            ),
            IconButton(
              tooltip: 'Ganti Tema',
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: isDark ? AppColors.accent : AppColors.lightTextPrimary,
              ),
              onPressed: () {
                Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                );
              },
            ),
          ],

          // Menu popup untuk layar sempit
          if (isCompact)
            PopupMenuButton<String>(
              tooltip: 'Menu lainnya',
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: (value) {
                switch (value) {
                  case 'wishlist':
                    Get.toNamed(Routes.WISHLIST);
                    break;
                  case 'orders':
                    Get.toNamed(Routes.ORDERS);
                    break;
                  case 'theme':
                    Get.changeThemeMode(
                      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    );
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'wishlist',
                  child: Row(
                    children: [
                      Icon(Icons.favorite_border_rounded),
                      SizedBox(width: 12),
                      Text('Wishlist Favorit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'orders',
                  child: Row(
                    children: [
                      Icon(Icons.receipt_long_outlined),
                      SizedBox(width: 12),
                      Text('Riwayat Pesanan'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'theme',
                  child: Row(
                    children: [
                      Icon(
                        isDark
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                      ),
                      const SizedBox(width: 12),
                      const Text('Ganti Tema'),
                    ],
                  ),
                ),
              ],
            ),

          // Keranjang tetap tersedia di semua ukuran layar
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                tooltip: 'Keranjang Belanja',
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => Get.toNamed(Routes.CART),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Obx(() {
                  final count = cartController.totalItems;

                  if (count == 0) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      count > 99 ? '99+' : '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari sneakers favoritmu...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Banner promosi
            const PromoBanner(),
            const SizedBox(height: 20),

            // Filter kategori reaktif
            // Filter kategori reaktif
            SizedBox(
              height: 38,
              child: Obx(() {
                // Baca state reaktif langsung di dalam Obx.
                final selectedCategory = controller.selectedCategory.value;

                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    final isSelected = selectedCategory == category;

                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => controller.selectCategory(category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark
                                    ? AppColors.darkSurfaceCard
                                    : Colors.white),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 20),

            // Judul katalog dan jumlah produk
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Katalog Sneakers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                Obx(
                  () => Text(
                    '${controller.productCount} Produk',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Grid produk reaktif
            Obx(() {
              final products = controller.filteredProducts;

              if (products.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: Text('Produk tidak ditemukan.')),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Obx(
                    () => ProductCard(
                      title: product.name,
                      category: product.category,
                      price: product.formattedPrice,
                      rating: product.rating,
                      imageUrl: product.imageUrl,
                      isFavorite: controller.isFavorite(product.id),
                      onToggleFavorite: () {
                        controller.toggleFavorite(product.id);
                      },
                      onAddToCart: () {
                        cartController.addItem(product, size: 42);

                        Get.snackbar(
                          'Ditambahkan',
                          '${product.name} ditambahkan ke keranjang!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.success,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(16),
                          borderRadius: 12,
                          duration: const Duration(seconds: 2),
                        );
                      },
                      onTap: () {
                        Get.toNamed(Routes.DETAIL, arguments: product);
                      },
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
