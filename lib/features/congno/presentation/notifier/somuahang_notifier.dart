import 'dart:async';

import 'package:erp_client_1/features/congno/data/model/somuahang_view_model.dart';
import 'package:erp_client_1/features/congno/data/repository/congno_repository.dart';
import 'package:erp_client_1/features/congno/data/repository/icongno_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final soMuaHangProvider = AsyncNotifierProvider.autoDispose(SoMuaHangNotifier.new, retry:(_,_)=>null);

class SoMuaHangNotifier extends AsyncNotifier<SoMuaHangViewModel?>{
  ICongNoRepository get _repo => ref.read(congNoRepositoryProvider);

  @override
  FutureOr<SoMuaHangViewModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> get(String? maKH, DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getSoMuaHang(maKH, tuNgay, denNgay);
    });
  }

}