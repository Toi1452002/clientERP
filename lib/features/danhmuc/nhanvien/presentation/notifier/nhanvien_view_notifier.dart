import 'dart:async';

import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_view_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/inhanvien_repository.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/nhanvien_repository.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/state/nhanvien_lookup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nhanVienViewProvider = AsyncNotifierProvider.autoDispose(NhanVienViewNotifier.new, retry: (_,_)=>null);

class NhanVienViewNotifier extends AsyncNotifier<List<NhanVienViewModel>>{

  INhanVienRepository get _repo => ref.read(nhanVienRepositoryProvider);

  @override
  FutureOr<List<NhanVienViewModel>> build() async{
    // TODO: implement build
    return await _repo.getView();
  }


  void add(NhanVienViewModel model) {
    state = AsyncLoading();
    final current = state.value ?? [];

    state = AsyncData([...current, model]);

    ref.invalidate(nhanVienLookupProvider);

  }

  void updateRow(NhanVienViewModel model){
    state = AsyncLoading();
    final currentList = state.value ?? [];
    final newList = currentList.map((item) {
      if (item.id == model.id) {
        return model;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
    ref.invalidate(nhanVienLookupProvider);
  }

  Future<void> delete(int id) async {
    state = AsyncLoading();
    final result = await _repo.delete(id);

    final currentList = state.value ?? [];
    if(result>0){
      currentList.removeWhere((e)=>e.id==id);
    }

    state = AsyncData(currentList);
    ref.invalidate(nhanVienLookupProvider);
  }

}