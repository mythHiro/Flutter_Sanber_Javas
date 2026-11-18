import 'package:get/get.dart';

import '../../../core/network/dio_client.dart';
import '../../../data/remote/product_remote_datasource.dart';
import '../../../data/repository/product_repository.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // 1. HTTP Client
    Get.lazyPut<DioClient>(() => DioClient());

    // 2. Remote Data Source
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(dioClient: Get.find<DioClient>()),
    );

    // 3. Repository
    Get.lazyPut<ProductRepository>(
      () => ProductRepository(
        remoteDataSource: Get.find<ProductRemoteDataSource>(),
      ),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(repository: Get.find<ProductRepository>()),
    );
  }
}
