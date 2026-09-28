import 'dart:async';

import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_view_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/repository/itaikhoan_repository.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/repository/taikhoan_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taiKhoanViewProvider = AsyncNotifierProvider(TaiKhoanViewNotifier.new, retry: (_,_)=>null);

class TaiKhoanViewNotifier extends AsyncNotifier<List<TaiKhoanViewModel>>{
  ITaiKhoanRepository get _repo => ref.read(taiKhoanRepositoryProvider);

  @override
  FutureOr<List<TaiKhoanViewModel>> build()  async{
    // TODO: implement build
    return await _repo.getView();
  }

  void add(TaiKhoanViewModel model) {
    state = AsyncLoading();
    final current = state.value ?? [];

    state = AsyncData([...current,model]);


    // ref.invalidate(hangHoaLookupProvider);
  }

  void updateRow(TaiKhoanViewModel model){
    state = AsyncLoading();
    final currentList = state.value ?? [];
    final newList = currentList.map((item) {
      if (item.id == model.id) {
        return model;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
    // ref.invalidate(hangHoaLookupProvider);
  }

  Future<void> delete(int id) async {
    state = AsyncLoading();
    final result = await _repo.delete(id);

    final currentList = state.value ?? [];
    if(result>0){
      currentList.removeWhere((e)=>e.id==id);
    }

    state = AsyncData(currentList);
    // ref.invalidate(hangHoaLookupProvider);
  }


  // Future<int> delete(int id) async{
  //   return await _repo.delete(id);
  // }


}