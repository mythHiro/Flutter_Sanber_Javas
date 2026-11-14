import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/app/core/theme/app_colors.dart';

class RegisterController extends GetxController {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  // Reactive States
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  // Validasi Nama
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama lengkap wajib diisi';
    }

    if (value.trim().length < 3) {
      return 'Nama minimal 3 karakter';
    }

    return null;
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

  // Validasi Konfirmasi Password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi kata sandi wajib diisi';
    }

    if (value != passwordController.text) {
      return 'Konfirmasi kata sandi tidak cocok';
    }

    return null;
  }

  // Toggle Password
  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  // Toggle Confirm Password
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.toggle();
  }

  // Register
  Future<void> register() async {
    if (isLoading.value) return;

    if (formKey.currentState?.validate() != true) {
      return;
    }

    isLoading.value = true;

    // Simulasi request pendaftaran
    await Future.delayed(const Duration(seconds: 1));

    isLoading.value = false;

    Get.snackbar(
      'Pendaftaran Berhasil',
      'Akunmu berhasil didaftarkan. Silakan masuk menggunakan email dan password baru.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );

    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}
