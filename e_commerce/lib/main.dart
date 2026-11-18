import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/bindings/app_bindings.dart';
import 'app/core/theme/app_theme.dart';
import 'app/data/local/storage_service.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  // Pastikan Flutter binding siap sebelum mengakses local storage.
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi StorageService sebelum aplikasi dijalankan.
  final storageService = await Get.putAsync(() => StorageService().init());

  runApp(
    GetMaterialApp(
      title: 'KicksStore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Gunakan tema yang sudah dibaca dari SharedPreferences.
      themeMode: storageService.themeMode,

      // Pertahankan binding dari sesi sebelumnya.
      initialBinding: AppBinding(),

      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
