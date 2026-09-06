import 'dart:async';

import 'package:erp_client_1/features/ketchuyen/data/model/ketchuyen_view_model.dart';
import 'package:erp_client_1/features/ketchuyen/data/repository/iketchuyen_repository.dart';
import 'package:erp_client_1/features/ketchuyen/data/repository/ketchuyen_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ketChuyenViewProvider = AsyncNotifierProvider.autoDispose(KetChuyenViewNotifier.new, retry: (_,_)=>null);

class KetChuyenViewNotifier extends AsyncNotifier<List<KetChuyenViewModel>>{
  IKetChuyenRepository get _repo => ref.read(ketChuyenRepositoryProvider);

  @override
  FutureOr<List<KetChuyenViewModel>> build() {
    // TODO: implement build
    return [];
  }

  Future<void> get(DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getViewKetChuyen(tuNgay, denNgay);
    });
  }

  Future<void> ketChuyenTrinhTu(DateTime tuNgay, DateTime denNgay, String butToan) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.ketChuyenTrinhTu(tuNgay, denNgay, butToan);
    });
  }

  Future<void> ketChuyenTheoThang(DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.ketChuyenTheoThang(tuNgay, denNgay);
    });
  }

  Future<void> ketChuyenTheoNam(DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.ketChuyenTheoNam(tuNgay, denNgay);
    });
  }

  Future<int> addRow() async{
    return await _repo.add();
  }

  Future<int> delete(int id) async{
    return await _repo.delete(id);
  }

  Future<void> updateKetChuyen(KetChuyenViewModel model, int id) async{
    await _repo.update(model, id);
  }

}