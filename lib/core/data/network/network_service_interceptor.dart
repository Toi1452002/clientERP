import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/system/auth/data/repository/auth_repository.dart';
import 'package:erp_client_1/features/system/auth/presentation/notifier/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/storage/storage_name.dart';
import '../local/storage/storage_provider.dart';

final networkServiceInterceptorProvider = Provider<NetworkServiceInterceptor>((ref) {
  return NetworkServiceInterceptor(ref);
});

class NetworkServiceInterceptor extends Interceptor {
  NetworkServiceInterceptor(this.ref);

  final Ref ref;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = ref.read(storageProvider);
    final token = await storage.getString(stToken);
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.headers['Authorization'] = "Bearer $token";
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError
    // super.onError(err, handler);
    if (err.response?.statusCode == 401) {
      // Token het han
      final storage = ref.read(storageProvider);
      final refreshToken = await storage.getString(stRefreshToken);
      if (refreshToken != null) {
        try {
          final dio = ref.read(networkServiceProvider);
          final auth = await ref.read(authRepositoryProvider).refreshToken(refreshToken);

          await ref.read(authNotifierProvider.notifier).setValue(auth);

          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer ${auth.accessToken}';
          final result = await dio.fetch(requestOptions);

          return handler.resolve(result);
        } on DioException catch (e) {
          return handler.reject(e);
        } on ApiException catch (e) {
          ref.read(authNotifierProvider.notifier).logout(isRefresh: true);
          return handler.reject(
            DioException(
              message: e.message,
              type: DioExceptionType.badResponse,
              requestOptions: err.requestOptions,
              error: e,
            ),
          );
        }
      }
    }
    return handler.next(err);
  }
}
