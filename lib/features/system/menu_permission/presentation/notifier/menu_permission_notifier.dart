import 'dart:async';

import 'package:erp_client_1/features/system/menu_permission/data/model/menu_permission_model.dart';
import 'package:erp_client_1/features/system/menu_permission/data/repository/imenu_permisson_repository.dart';
import 'package:erp_client_1/features/system/menu_permission/data/repository/menu_permission_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuPermissionProvider = AsyncNotifierProvider.autoDispose<MenuPermissionNotifier, List<MenuPermissionModel>>(
  MenuPermissionNotifier.new,
  retry: (_, _) => null,
);

class MenuPermissionNotifier extends AsyncNotifier<List<MenuPermissionModel>> {
  IMenuPermissionRepository get _repo => ref.read(menuPermissionRepositoryProvider);

  @override
  FutureOr<List<MenuPermissionModel>> build() {
    return [];
  }

  Future<void> loadMenu(int roleId) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getMenu(roleId);
    });
  }

  Future<bool> updatePermission(int roleId, List<int> lstMenuId) async {
    try{
      return await _repo.updatePermission(roleId, lstMenuId);
    }catch(e){
      rethrow;
    }
  }
}
