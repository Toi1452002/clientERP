import 'dart:async';

import 'package:erp_client_1/features/system/users/data/model/user_view_model.dart';
import 'package:erp_client_1/features/system/users/data/repository/iuser_repository.dart';
import 'package:erp_client_1/features/system/users/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userViewProvider = AsyncNotifierProvider.autoDispose<UserViewNotifier, List<UserViewModel>>(
  UserViewNotifier.new,
  retry: (_, _) => null,
);

class UserViewNotifier extends AsyncNotifier<List<UserViewModel>> {
  IUserRepository get _repo => ref.read(userRepositoryProvider);

  @override
  FutureOr<List<UserViewModel>> build() async {
    // TODO: implement build
    return await loadView();
  }

  Future<List<UserViewModel>> loadView() async {
    return await _repo.getView();
  }

  Future<bool> delete(int id) async {
    final result = await _repo.delete(id);
    return result > 0;
  }
}
