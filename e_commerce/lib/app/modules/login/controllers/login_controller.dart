import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  // Reactive States
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;
  final rememberMe = true.obs;

  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  // Validasi Email
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Alamat email wajib diisi';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // Validasi Password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi wajib diisi';
    }

    if (value.length < 6) {
      return 'Kata sandi minimal 6 karakter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Kata sandi harus mengandung minimal 1 angka (0-9)';
    }

    return null;
  }

  // Toggle Password Visibility
  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  // Login
  Future<void> login() async {
    if (isLoading.value) return;

    // Jalankan validasi seluruh field
    if (formKey.currentState?.validate() != true) {
      return;
    }

    isLoading.value = true;

    // Simulasi request login
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;

    Get.snackbar(
      'Berhasil Masuk',
      'Selamat datang kembali di KicksStore!',
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}
