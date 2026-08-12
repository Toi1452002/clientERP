import 'package:erp_client_1/features/system/menu_permission/data/model/menu_permission_model.dart';

abstract interface class IMenuPermissionRepository {
  Future<List<MenuPermissionModel>> getMenu(int roleId);

  Future<bool> updatePermission(int roleId, List<int> lst);
}