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

  // Format harga ke Rupiah.
  String get formattedPrice {
    final formatted = price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return 'Rp $formatted';
  }

  // Konversi JSON dari API DummyJSON menjadi ProductModel.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawPrice = json['price'];
    final rawRating = json['rating'];

    final parsedPrice = rawPrice is num ? (rawPrice * 15000).round() : 0;

    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: (json['title'] ?? json['name'] ?? 'Produk tanpa nama').toString(),
      category: (json['category'] ?? 'Uncategorized').toString(),
      price: parsedPrice,
      rating: rawRating is num ? rawRating.toDouble() : 0.0,
      imageUrl: (json['thumbnail'] ?? json['imageUrl'] ?? json['image'] ?? '')
          .toString(),
    );
  }

  // Konversi Map menjadi ProductModel.
  // Dipertahankan untuk kompatibilitas dengan fitur Cart.
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

  // Konversi ProductModel menjadi Map.
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
