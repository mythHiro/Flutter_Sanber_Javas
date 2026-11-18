import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  final RxBool _isDarkMode = false.obs;

  static const String _themeKey = 'is_dark_mode';

  bool get isDarkMode => _isDarkMode.value;

  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // Inisialisasi SharedPreferences dan Hive CE.
  Future<StorageService> init({bool initHive = true}) async {
    _prefs = await SharedPreferences.getInstance();

    _isDarkMode.value = _prefs.getBool(_themeKey) ?? false;

    if (initHive) {
      await Hive.initFlutter();
    }

    return this;
  }

  // Mengubah tema sekaligus menyimpan preferensi pengguna.
  Future<void> toggleTheme() async {
    final newTheme = !_isDarkMode.value;

    await _prefs.setBool(_themeKey, newTheme);

    _isDarkMode.value = newTheme;

    Get.changeThemeMode(themeMode);

    // Feedback SnackBar sesuai tema yang aktif.
    Get.snackbar(
      newTheme ? 'Mode Gelap Diaktifkan' : 'Mode Terang Diaktifkan',
      newTheme
          ? 'Tampilan hemat daya dan nyaman untuk mata telah aktif.'
          : 'Tampilan cerah bersemangat telah aktif.',
      icon: Icon(
        newTheme ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
        color: newTheme ? const Color(0xFFFFC107) : Colors.white,
      ),
      backgroundColor: newTheme
          ? const Color(0xFF1E293B)
          : const Color(0xFF4F46E5),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
      borderRadius: 12,
    );
  }
}
