import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/app/core/theme/app_colors.dart';
import 'package:e_commerce/app/routes/app_pages.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textPrimary = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final textSecondary = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final surface = isDark ? AppColors.darkSurfaceCard : Colors.white;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => Text(
            'Keranjang Belanja (${controller.totalItems})',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Obx(
            () => IconButton(
              tooltip: 'Kosongkan Keranjang',
              icon: const Icon(
                Icons.delete_sweep_outlined,
                color: AppColors.error,
              ),
              onPressed: controller.cartItems.isEmpty
                  ? null
                  : () {
                      Get.defaultDialog(
                        title: 'Kosongkan Keranjang',
                        middleText: 'Yakin ingin menghapus seluruh belanjaan?',
                        textConfirm: 'Hapus',
                        textCancel: 'Batal',
                        confirmTextColor: Colors.white,
                        buttonColor: AppColors.error,
                        onConfirm: () {
                          controller.clearCart();
                          Get.back();
                        },
                      );
                    },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        final items = controller.cartItems;

        if (items.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 76,
                    color: textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yuk, temukan sepatu favoritmu!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textSecondary),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Mulai Belanja'),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = items[index];
            final imageUrl = item['image']?.toString() ?? '';
            final title = item['title']?.toString() ?? 'Produk';
            final price = item['price']?.toString() ?? 'Rp 0';
            final size = item['size'] ?? '-';
            final quantity = item['quantity'] as int? ?? 1;

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: border),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : const Color(0xFFF1F5F9),
                      child: imageUrl.isEmpty
                          ? const Icon(Icons.image_not_supported_outlined)
                          : Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.image_not_supported_outlined,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(20),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Size $size',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF0F172A)
                              : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: border),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () => controller.decreaseQuantity(index),
                              borderRadius: BorderRadius.circular(8),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.remove_rounded, size: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                '$quantity',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => controller.increaseQuantity(index),
                              borderRadius: BorderRadius.circular(8),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.add_rounded, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      IconButton(
                        tooltip: 'Hapus produk',
                        visualDensity: VisualDensity.compact,
                        onPressed: () => controller.removeItem(index),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 20,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final isEmpty = controller.cartItems.isEmpty;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(isDark ? 60 : 15),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SummaryRow(
                  label: 'Subtotal',
                  value: controller.formatRupiah(controller.subtotal),
                  textColor: textPrimary,
                ),
                const SizedBox(height: 6),
                _SummaryRow(
                  label: 'Diskon Spesial',
                  value: '- ${controller.formatRupiah(controller.discount)}',
                  textColor: AppColors.success,
                ),
                const Divider(height: 18),
                _SummaryRow(
                  label: 'Total Pembayaran',
                  value: controller.formatRupiah(controller.totalPayment),
                  textColor: AppColors.primary,
                  isTotal: true,
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.payment_rounded),
                    label: const Text('Lanjut ke Pembayaran'),
                    onPressed: isEmpty
                        ? null
                        : () => Get.toNamed(Routes.CHECKOUT),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.textColor,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final Color textColor;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
