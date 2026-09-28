import 'dart:async';
import 'package:erp_client_1/features/system/users/data/model/user_add_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_update_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_view_model.dart';
import 'package:erp_client_1/features/system/users/data/repository/iuser_repository.dart';
import 'package:erp_client_1/features/system/users/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userEditProvider = AsyncNotifierProvider.autoDispose(UserEditNotifier.new, retry: (_, _) => null);

class UserEditNotifier extends AsyncNotifier<UserViewModel?> {
  IUserRepository get _repo => ref.read(userRepositoryProvider);

  @override
  FutureOr<UserViewModel?> build() {
    return null;
  }

  Future<void> add(UserAddModel user) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.add(user);
    });
  }

  Future<void> updateUser(UserUpdateModel user, int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(Duration(seconds: 3));
      return await _repo.update(user, id);
    });
  }
  Future<void> updatePassword(String password, int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.updatePassword(password, id);
    });
  }

}
