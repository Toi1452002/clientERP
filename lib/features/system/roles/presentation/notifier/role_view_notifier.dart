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

  Future<void> changedRow(RoleModel model) async {
    final current = state.value ?? [];

    if (current.indexWhere((e) => e.id == model.id) == -1) {
      state = AsyncData([...current, model]);
    } else {
      final newList = current.map((e) {
        if (e.id == model.id) {
          return model;
        }

        return e;
      });
      state = AsyncData(newList.toList());
    }
  }

  // Future<void> updateRoleName(int id, String roleName) async {
  //   // try {
  //   state = AsyncLoading();
  //   final result = await _repo.update(roleName, id);
  //   final current = state.value ?? [];
  //
  //   // } catch (e) {
  //   //   rethrow;
  //   // }
  // }

  Future<void> delete(int id) async {
    // try {
    // state = AsyncLoading();
    final result = await _repo.delete(id);
    if (result > 0) {
      state = AsyncData(state.value!.where((e) => e.id != id).toList());
    }

    // } catch (e) {
    //   rethrow;
    // }
  }
}
