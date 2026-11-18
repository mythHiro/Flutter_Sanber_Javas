import 'package:dio/dio.dart';

import '../../core/network/dio_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    final Response response = await dioClient.get(
      '/products/category/mens-shoes',
    );

    final data = response.data;

    if (data is! Map<String, dynamic>) {
      throw const FormatException('Format respons API tidak valid.');
    }

    final products = data['products'];

    if (products is! List) {
      throw const FormatException('Data produk tidak ditemukan.');
    }

    return products
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();
  }
}
