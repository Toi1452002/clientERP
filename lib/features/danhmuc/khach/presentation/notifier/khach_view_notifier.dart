import 'dart:async';

import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_view_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/repository/ikhach_repository.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/repository/khach_repository.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/state/khach_lookup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final khachViewProvider = AsyncNotifierProvider.autoDispose(KhachViewNotifier.new, retry: (_, _) => null);

class KhachViewNotifier extends AsyncNotifier<List<KhachViewModel>> {
  IKhachRepository get _repo => ref.read(khachRepositoryProvider);

  @override
  FutureOr<List<KhachViewModel>> build() async {
    // TODO: implement build
    return await _repo.getView(isActive: true);
  }

  Future<void> get({bool? isActive}) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getView(isActive: isActive);
    });
  }

  Future<void> delete(int id) async {
    state = AsyncLoading();
    final result = await _repo.delete(id);

    final currentList = state.value ?? [];
    if (result > 0) {
      currentList.removeWhere((e) => e.id == id);
    }

    state = AsyncData(currentList);
    ref.invalidate(khachLookupProvider);
  }

  void add(KhachViewModel model) {
    state = AsyncLoading();
    final current = state.value ?? [];

    if(current.isEmpty){
      state = AsyncData([model]);
    }else{
      if(current.indexWhere((e)=>e.isActive==model.isActive)!=-1){
        state = AsyncData([...current, model]);
      }else{
        state = AsyncData(current);
      }
    }

    ref.invalidate(khachLookupProvider);
  }

  void updateRow(KhachViewModel model) {
    state = AsyncLoading();
    final currentList = state.value ?? [];
    if (currentList.indexWhere((e) => e.isActive == model.isActive) == -1) {
      currentList.removeWhere((e) => e.id == model.id);
    }
    final newList = currentList.map((item) {
      if (item.id == model.id) {
        return model;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
    ref.invalidate(khachLookupProvider);
  }
}
