import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/app/core/theme/app_colors.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buat Akun Baru 🚀',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Daftar untuk menikmati diskon eksklusif dan kemudahan belanja sneakers.',
                style: TextStyle(fontSize: 14, color: secondaryColor),
              ),
              const SizedBox(height: 28),

              // Form Registration
              Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Lengkap
                    _buildLabel('Nama Lengkap', textColor),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.nameController,
                      validator: controller.validateName,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: 'Contoh: Dimas Pratama',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Email
                    _buildLabel('Alamat Email', textColor),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.emailController,
                      validator: controller.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'nama@sekolah.sch.id',
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Password
                    _buildLabel('Kata Sandi', textColor),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        validator: controller.validatePassword,
                        obscureText: controller.isPasswordHidden.value,
                        onChanged: (_) {
                          controller.formKey.currentState?.validate();
                        },
                        decoration: InputDecoration(
                          hintText: 'Minimal 6 karakter + 1 angka',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Konfirmasi Password
                    _buildLabel('Konfirmasi Kata Sandi', textColor),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        controller: controller.confirmPasswordController,
                        validator: controller.validateConfirmPassword,
                        obscureText: controller.isConfirmPasswordHidden.value,
                        decoration: InputDecoration(
                          hintText: 'Ulangi kata sandi di atas',
                          prefixIcon: const Icon(Icons.lock_reset_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordHidden.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Tombol Daftar
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.register,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Daftar Akun Sekarang'),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Link Kembali ke Login
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: TextStyle(fontSize: 13, color: secondaryColor),
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Text(
                        'Masuk di Sini',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Label
  Widget _buildLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color),
    );
  }
}
