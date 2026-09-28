import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/role_model.dart';
import '../../data/repository/irole_repository.dart';
import '../../data/repository/role_repository.dart';

final roleEditProvider = AsyncNotifierProvider.autoDispose(RoleEditNotifier.new, retry:(_,_)=>null);

class RoleEditNotifier extends AsyncNotifier<RoleModel?>{
  IRoleRepository get _repo => ref.watch(roleRepositoryProvider);

  @override
  FutureOr<RoleModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> add(String roleName) async{
    if(roleName.isEmpty) {
      state = AsyncError("Vai trò trống!", StackTrace.current);
      return;
    }
    state =  AsyncLoading();

    state = await AsyncValue.guard(() async{
      return await _repo.add(roleName);
    });
  }

  Future<void> updateRow(int id, String roleName) async{
    state =  AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.update(roleName,id);
    });
  }

}