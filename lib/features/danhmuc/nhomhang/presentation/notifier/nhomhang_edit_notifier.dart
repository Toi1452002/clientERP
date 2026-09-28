import 'dart:async';

import 'package:erp_client_1/features/danhmuc/nhomhang/data/repository/inhomhang_repository.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/data/repository/nhomhang_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/nhomhang_model.dart';

final nhomHangEditProvider = AsyncNotifierProvider.autoDispose(NhomHangEditNotifier.new,retry: (_,_)=>null);

class NhomHangEditNotifier extends AsyncNotifier<NhomHangModel?>{
  INhomHangRepository get _repo => ref.read(nhomHangRepositoryProvider);
  @override
  FutureOr<NhomHangModel?> build() {
    // TODO: implement build
    return null;
  }
  Future<void> add(String nhomHang) async {
    if (nhomHang.isEmpty) {
      state = AsyncError("Nhóm hàng trống!", StackTrace.current);
      return;
    }
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.add(nhomHang);
    });
  }

  Future<void> updateNhomHang(String nhomHang, int id) async {
    if (nhomHang.isEmpty) {
      state = AsyncError("Nhóm hàng trống!", StackTrace.current);
      return;
    }
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.update(id, nhomHang);
    });
  }
}