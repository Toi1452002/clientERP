import 'dart:async';

import 'package:erp_client_1/features/taisan/tscd/data/model/tscd_update_model.dart';
import 'package:erp_client_1/features/taisan/tscd/data/model/tscd_view_model.dart';
import 'package:erp_client_1/features/taisan/tscd/data/repository/itscd_repository.dart';
import 'package:erp_client_1/features/taisan/tscd/data/repository/tscd_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tscdViewProvider = AsyncNotifierProvider.autoDispose(TSCDViewNotifier.new, retry: (_, _) => null);

class TSCDViewNotifier extends AsyncNotifier<List<TSCDViewModel>> {
  ITSCDRepository get _repo => ref.read(tscdRepositoryProvider);

  @override
  FutureOr<List<TSCDViewModel>> build() async {
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

  Future<TSCDViewModel> addRow() async{
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

  Future<void> updateTSCD(int id, TSCDUpdateModel model, {bool isHH = false}) async {

    final result = await _repo.updateRow(id, model, isHH: isHH);
    _updateRow(result);
  }

  void _updateRow(TSCDViewModel newData) {
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
