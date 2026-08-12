import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/system/auth/data/model/auth_info_model.dart';
import 'package:erp_client_1/features/system/auth/data/model/auth_menu_model.dart';
import 'package:erp_client_1/features/system/auth/data/model/auth_model.dart';
import 'package:erp_client_1/features/system/auth/data/repository/iauth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_config.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  final options = BaseOptions(
    baseUrl: NetworkConfig.apiUrl,
    // baseUrl: "https://localhost:7157/api",
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
  );
  final refresh = Dio(options);
  return AuthRepository(dio, refresh);
});

class AuthRepository implements IAuthRepository {
  final Dio _dio;
  final Dio _refreshDio;

  AuthRepository(this._dio, this._refreshDio);

  @override
  Future<AuthModel> login(String username, String password) async {
    try {
      final response = await _dio.post("/auth", queryParameters: {'username': username, 'password': password});
      final data = response.data as Map<String, dynamic>;
      final info = data['info'] as Map<String, dynamic>;
      return AuthModel(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
        info: AuthInfoModel.fromMap(info),
      );
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post("/auth/logout");
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<AuthInfoModel> getMe() async {
    try {
      final response = await _dio.get("/auth/me");
      final data = response.data as Map<String, dynamic>;
      return AuthInfoModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<AuthModel> refreshToken(String refreshToken) async {
    // TODO: implement refreshToken
    try {
      final response = await _refreshDio.post("/auth/refresh", queryParameters: {"token": refreshToken});
      final data = response.data as Map<String, dynamic>;
      return AuthModel(accessToken: data['accessToken'], refreshToken: data['refreshToken'], info: null);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<List<AuthMenuModel>> getMenu(int roleId) async {
    // TODO: implement getMenu
    try {
      final response = await _dio.get("/auth/menu/$roleId");
      final data = response.data as List;
      return data.map((e) => AuthMenuModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }
}
