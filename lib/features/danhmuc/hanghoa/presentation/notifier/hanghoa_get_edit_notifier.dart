import 'dart:async';

import 'package:erp_client_1/features/danhmuc/hanghoa/data/model/hanghoa_model.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/data/repository/hanghoa_repository.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/data/repository/ihanghoa_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hangHoaGetEditProvider = AsyncNotifierProvider.autoDispose(HangHoaGetEditNotifier.new,retry: (_,_)=>null);

class HangHoaGetEditNotifier extends AsyncNotifier<HangHoaModel?> {
  IHangHoaRepository get _repo => ref.read(hangHoaRepositoryProvider);

  @override
  FutureOr<HangHoaModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> get({int? id}) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (id == null) return null;
      return await _repo.getById(id);
    });
  }
}
