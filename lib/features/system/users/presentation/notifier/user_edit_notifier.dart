import 'dart:async';

import 'package:erp_client_1/features/system/users/data/model/user_add_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_edit_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_update_model.dart';
import 'package:erp_client_1/features/system/users/data/repository/iuser_repository.dart';
import 'package:erp_client_1/features/system/users/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userEditProvider = AsyncNotifierProvider.autoDispose<UserEditNotifier, void>(UserEditNotifier.new, retry: (_, _) => null);

class UserEditNotifier extends AsyncNotifier<void> {
  IUserRepository get _repo => ref.read(userRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> add(UserAddModel user) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.add(user);
    });
  }
  Future<void> updateUser(UserUpdateModel user, int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.update(user, id);
    });
  }
  Future<void> updatePassword(String password, int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.updatePassword(password, id);
    });
  }

  Future<UserEditModel?> loadUser(int id) async => await _repo.getEdit(id);
}
