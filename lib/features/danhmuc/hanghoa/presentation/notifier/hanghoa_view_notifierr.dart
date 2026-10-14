
import 'dart:async';

import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/state/hanghoa_lookup_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/hanghoaview_model.dart';
import '../../data/repository/hanghoa_repository.dart';
import '../../data/repository/ihanghoa_repository.dart';

final hangHoaViewProvider = AsyncNotifierProvider.autoDispose(HangHoaViewController.new,retry: (_,_)=>null);

class HangHoaViewController extends AsyncNotifier<List<HangHoaViewModel>>{
  IHangHoaRepository get _repo => ref.read(hangHoaRepositoryProvider);

  @override
  Future<List<HangHoaViewModel>> build() async {
    return await _repo.getView(isActive: true);
  }

  Future<void> getView({bool? isActive}) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getView(isActive: isActive);

    });
  }

  void add(HangHoaViewModel model) {
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



    ref.invalidate(hangHoaLookupProvider);
  }

  void updateRow(HangHoaViewModel model){
    state = AsyncLoading();
    final currentList = state.value ?? [];
    if(currentList.indexWhere((e)=>e.isActive==model.isActive)==-1){
      currentList.removeWhere((e)=>e.id == model.id);
    }
    final newList = currentList.map((item) {
      if (item.id == model.id) {
        return model;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
    ref.invalidate(hangHoaLookupProvider);
  }

  Future<void> delete(int id) async {
    state = AsyncLoading();
    final result = await _repo.delete(id);

    final currentList = state.value ?? [];
    if(result>0){
      currentList.removeWhere((e)=>e.id==id);

      ref.invalidate(hangHoaLookupProvider);
    }
    state = AsyncData(currentList);


  }

}