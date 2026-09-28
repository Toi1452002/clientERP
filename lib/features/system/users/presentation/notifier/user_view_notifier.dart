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

  Future<void> delete(int id) async {
    state = AsyncLoading();
    final result = await _repo.delete(id);

    final currentList = state.value ?? [];
    if(result>0){
      currentList.removeWhere((e)=>e.id==id);
    }

    state = AsyncData(currentList);

  }

  void add(UserViewModel model) {
    state = AsyncLoading();
    final current = state.value ?? [];
    state = AsyncData([...current, model]);
  }

  void updateRow(UserViewModel model){
    state = AsyncLoading();
    final currentList = state.value ?? [];

    final newList = currentList.map((item) {
      if (item.id == model.id) {
        return model;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
  }
}
