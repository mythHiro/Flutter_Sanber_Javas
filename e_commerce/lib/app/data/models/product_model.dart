class ProductModel {
  final String id;
  final String name;
  final String category;
  final int price;
  final double rating;
  final String imageUrl;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  // Format harga ke Rupiah
  String get formattedPrice {
    final formatted = price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp $formatted';
  }

  // Konversi Map menjadi ProductModel
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final rawPrice = map['price'].toString();

    return ProductModel(
      id: map['id']?.toString() ?? '',
      name: (map['name'] ?? map['title']).toString(),
      category: map['category'].toString(),
      price: int.tryParse(rawPrice.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: (map['imageUrl'] ?? map['image']).toString(),
    );
  }

  // Konversi ProductModel menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
    };
  }
}
