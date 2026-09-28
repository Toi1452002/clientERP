import 'dart:async';

import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_update_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_view_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/repository/bangluong_repository.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/repository/ibangluong_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bangLuongViewNotifier = AsyncNotifierProvider.autoDispose(BangLuongViewNotifier.new, retry: (_,_)=>null);

class BangLuongViewNotifier extends AsyncNotifier<List<BangLuongViewModel>>{

  IBangLuongRepository get _repo => ref.read(bangLuongRepositoryProvider);

  @override
  FutureOr<List<BangLuongViewModel>> build()  async{
    // TODO: implement build
    final now = DateTime.now();
    return await _repo.getView(now.month, now.year);
  }

  Future<void> get(int month, int year) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getView(month, year);
    });
  }

  Future<void> addRow(int month, int year) async{
    state = AsyncLoading();
    final current = state.value??[];
    final result = await _repo.addRow(month, year);
    state = AsyncData([
      ...current,result
    ]);
  }

  Future<void> updateCell(BangLuongUpdateModel model, int id, String field) async{
    final result = await _repo.updateCell(model, id, field);
    _updateRow(result);
  }

  Future<int> delete(int id) async{
    final current = state.value??[];
    int indexWhere = current.indexWhere((e)=>e.id == id);
    if(indexWhere!=-1){
      current.removeAt(indexWhere);
      state = AsyncData(current);
    }

    return await _repo.delete(id);
  }

  void _updateRow(BangLuongViewModel newData) {
    state = AsyncLoading();
    final currentList = state.value ?? [];

    final newList = currentList.map((item) {
      if (item.id == newData.id) {
        return newData;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
  }
}