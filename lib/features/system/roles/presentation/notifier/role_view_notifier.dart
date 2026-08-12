import 'dart:async';

import 'package:erp_client_1/features/system/roles/data/model/role_model.dart';
import 'package:erp_client_1/features/system/roles/data/repository/irole_repository.dart';
import 'package:erp_client_1/features/system/roles/data/repository/role_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roleViewProvider = AsyncNotifierProvider<RoleViewNotifier, List<RoleModel>>(
  RoleViewNotifier.new,
  retry: (_, _) => null,
);

class RoleViewNotifier extends AsyncNotifier<List<RoleModel>> {
  IRoleRepository get _repo => ref.watch(roleRepositoryProvider);

  @override
  FutureOr<List<RoleModel>> build() {
    return getView();
  }

  Future<List<RoleModel>> getView() async {
    return await _repo.getView();
  }

  Future<void> add(String roleName) async {
    try {
      await _repo.add(roleName);
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        return build();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRoleName(int id, String roleName) async {
    try {
      await _repo.update(roleName, id);
      state = AsyncData(state.value!.map((e) => e.id == id ? e.copyWith(roleName: roleName) : e).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    try {
      await _repo.delete(id);
      state = AsyncData(state.value!.where((e) => e.id != id).toList());

    } catch (e) {
      rethrow;
    }
  }
}
