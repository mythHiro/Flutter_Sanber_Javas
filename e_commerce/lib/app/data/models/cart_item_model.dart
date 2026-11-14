import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int selectedSize;
  int quantity;

  CartItemModel({
    required this.product,
    required this.selectedSize,
    this.quantity = 1,
  });

  // ID unik berdasarkan produk dan ukuran.
  String get id => '${product.id}_$selectedSize';

  // Total harga produk berdasarkan kuantitas.
  int get subtotal => product.price * quantity;

  // Format subtotal ke Rupiah.
  String get formattedSubtotal {
    final formatted = subtotal.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp $formatted';
  }

  // Konversi Map menjadi CartItemModel.
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      product: ProductModel.fromMap(Map<String, dynamic>.from(map['product'])),
      selectedSize: (map['selectedSize'] as num).toInt(),
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  // Konversi CartItemModel menjadi Map.
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'selectedSize': selectedSize,
      'quantity': quantity,
    };
  }
}
