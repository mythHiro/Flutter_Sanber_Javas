import '../../core/network/dio_exception.dart';
import '../../core/network/result.dart';
import '../models/product_model.dart';
import '../remote/product_remote_datasource.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository({required this.remoteDataSource});

  Future<Result<List<ProductModel>, String>> fetchProducts() async {
    try {
      final products = await remoteDataSource.getProducts();

      return Success<List<ProductModel>, String>(products);
    } on NetworkFailure catch (e) {
      return Failure<List<ProductModel>, String>(e.message);
    } catch (e) {
      return Failure<List<ProductModel>, String>(
        'Gagal mengambil data produk: $e',
      );
    }
  }
}
