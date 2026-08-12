import 'dart:async';

import 'package:erp_client_1/features/congno/data/repository/congno_repository.dart';
import 'package:erp_client_1/features/congno/data/repository/icongno_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/sobanhang_view_model.dart';

final soBanHangProvider = AsyncNotifierProvider.autoDispose(SoBanHangNotifier.new, retry:(_,_)=>null);

class SoBanHangNotifier extends AsyncNotifier<SoBanHangViewModel?>{
  ICongNoRepository get _repo => ref.read(congNoRepositoryProvider);

  @override
  FutureOr<SoBanHangViewModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> get(String? maKH, DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getSoBanHang(maKH, tuNgay, denNgay);
    });
  }

}