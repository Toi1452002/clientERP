import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/system/menu_permission/data/model/menu_permission_model.dart';
import 'package:erp_client_1/features/system/menu_permission/data/repository/imenu_permisson_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuPermissionRepositoryProvider = Provider<IMenuPermissionRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return MenuPermissionRepository(dio);
});

class MenuPermissionRepository implements IMenuPermissionRepository {
  final Dio _dio;

  MenuPermissionRepository(this._dio);

  @override
  Future<List<MenuPermissionModel>> getMenu(int roleId) async {
    // TODO: implement getMenu
    try {
      final response = await _dio.get("/MenuPermission/$roleId");
      final data = response.data as List;
      return data.map((e) => MenuPermissionModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updatePermission(int roleId, List<int> lst) async {
    // TODO: implement updatePermission
    try {
      final response = await _dio.post(
        "/MenuPermission/$roleId",
        data: lst,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) return true;
      return false;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }
}
