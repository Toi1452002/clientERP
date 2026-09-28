import 'dart:async';

import 'package:erp_client_1/features/taisan/ccdc/data/model/ccdc_view_model.dart';
import 'package:erp_client_1/features/taisan/ccdc/data/repository/ccdc_repository.dart';
import 'package:erp_client_1/features/taisan/ccdc/data/repository/iccdc_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/ccdc_update_model.dart';

final ccdcViewProvider = AsyncNotifierProvider.autoDispose(CCDCViewNotifier.new, retry: (_,_)=>null);

class CCDCViewNotifier extends AsyncNotifier<List<CCDCViewModel>>{
  ICCDCRepository get _repo => ref.read(ccdcRepositoryProvider);
  @override
  FutureOr<List<CCDCViewModel>> build()async {
    // TODO: implement build
    return await _repo.getView();
  }
  DateTime? ngayDau() {
    if (state.value == null) return null;

    final n = state.value?.map((e) {
      if (e.ngayMua != null) return e.ngayMua;
    }).toList();

    if (n != null && n.isNotEmpty) {
      return n.reduce((a, b) => a!.isBefore(b!) ? a : b);
    }
    return null;
  }

  Future<void> tinhToan(DateTime ngay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.tinhToan(ngay);
    });
  }

  Future<CCDCViewModel> addRow() async{
    state = AsyncLoading();
    final result = await _repo.addRow();

    final currentList = state.value??[];
    state = AsyncData([
      ...currentList,
      result
    ]);
    return result;
  }

  Future<int> deleteRow(int id) async{
    await _repo.delete(id);
    return id;
  }

  Future<void> updateCCDC(int id, CCDCUpdateModel model, {bool isHH = false}) async {

    final result = await _repo.updateRow(id, model, isHH: isHH);
    _updateRow(result);
  }

  void _updateRow(CCDCViewModel newData) {
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