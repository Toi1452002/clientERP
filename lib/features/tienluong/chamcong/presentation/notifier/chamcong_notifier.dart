import 'dart:async';

import 'package:erp_client_1/features/tienluong/chamcong/data/model/chamcong_view_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/update_socong_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/repository/chamcong_repository.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/repository/ichamcong_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chamCongProvider = AsyncNotifierProvider.autoDispose(ChamCongNotifier.new, retry: (_, _) => null);

class ChamCongNotifier extends AsyncNotifier<List<ChamCongViewModel>> {
  IChamCongRepository get _repo => ref.read(chamCongRepositoryProvider);

  @override
  FutureOr<List<ChamCongViewModel>> build() async {
    // TODO: implement build
    return await _repo.getView(DateTime.now().month, DateTime.now().year);
  }

  Future<void> get(int month, int year) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getView(month, year);
    });
  }

  Future<void> addRow(int month, int year) async {
    state = AsyncLoading();
    final result = await _repo.addRow(month, year);
    final current = state.value ?? [];
    state = AsyncData([...current, ChamCongViewModel(id: result, ngay: {})]);
  }

  Future<void> updateMaNV(String maNV, int id) async{
    await _repo.updateMaNV(maNV, id);
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

  Future<num> updateSoCong(UpdateSoCongModel model) async {
    return await _repo.updateSoCong(model);
  }
}
