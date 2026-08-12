import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;

  static ApiException handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException('Kết nối quá thời gian');

      case DioExceptionType.sendTimeout:
        return ApiException('Gửi dữ liệu quá thời gian');

      case DioExceptionType.receiveTimeout:
        return ApiException('Nhận dữ liệu quá thời gian');

      case DioExceptionType.connectionError:
        return ApiException('Không thể kết nối đến máy chủ');

      case DioExceptionType.badResponse:
        final response = e.response;

        if (response?.statusCode == 400) {
          return ApiException(
            response?.data['message'] ?? 'Dữ liệu không hợp lệ',
          );
        }

        if (response?.statusCode == 401) {
          return ApiException('Phiên đăng nhập đã hết hạn');
        }

        if (response?.statusCode == 403) {
          return ApiException('Không có quyền truy cập');
        }

        if (response?.statusCode == 404) {
          return ApiException('Không tìm thấy dữ liệu');
        }

        if (response?.statusCode == 500) {
          return ApiException(
            response?.data['message'] ?? 'Lỗi máy chủ',
          );
        }

        return ApiException('Có lỗi xảy ra');

      default:
        return ApiException('Có lỗi xảy ra');
    }
  }
}