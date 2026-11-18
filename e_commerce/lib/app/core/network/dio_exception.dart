import 'package:dio/dio.dart';

// Informasi kegagalan jaringan.
class NetworkFailure {
  final int code;
  final String message;

  const NetworkFailure({required this.code, required this.message});
}

// Penerjemah error Dio menjadi pesan yang ramah pengguna.
class ErrorHandler {
  static NetworkFailure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    return const NetworkFailure(
      code: -999,
      message: 'Terjadi kesalahan yang tidak diketahui.',
    );
  }

  static NetworkFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          code: -1,
          message:
              'Waktu koneksi habis (Timeout). Periksa koneksi internet Anda.',
        );

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          code: -6,
          message:
              'Gagal terhubung ke server. Pastikan perangkat terhubung ke internet.',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      default:
        return NetworkFailure(
          code: -8,
          message:
              'Gangguan koneksi: ${error.message ?? 'Terjadi kesalahan tidak diketahui'}',
        );
    }
  }

  static NetworkFailure _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;

    return NetworkFailure(
      code: statusCode,
      message: _getFallbackMessage(statusCode),
    );
  }

  static String _getFallbackMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Permintaan tidak valid.';
      case 401:
        return 'Anda tidak memiliki izin untuk mengakses data ini.';
      case 404:
        return 'Data yang diminta tidak ditemukan.';
      case 500:
        return 'Server sedang mengalami gangguan.';
      default:
        return 'Terjadi kesalahan pada server (Kode: $statusCode).';
    }
  }
}
