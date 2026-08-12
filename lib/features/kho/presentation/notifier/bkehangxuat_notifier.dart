import 'dart:async';

import 'package:erp_client_1/features/kho/data/model/bke_nhapxuat_model.dart';
import 'package:erp_client_1/features/kho/data/repository/ikhohang_repository.dart';
import 'package:erp_client_1/features/kho/data/repository/khohang_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bKeHangXuatProvider = AsyncNotifierProvider.autoDispose(BKeHangXuatNotifier.new, retry:(_,_)=>null);

class BKeHangXuatNotifier extends AsyncNotifier<List<BKeNhapXuatModel>> {
  IKhoHangRepository get _repo => ref.read(khoHangRepositoryProvider);

  @override
  FutureOr<List<BKeNhapXuatModel>> build() async{
    // TODO: implement build
    return await _repo.getBKeHangXuat(DateTime.now().copyWith(day: 1), DateTime.now());

  }

  Future<void> get(DateTime tuNgay, DateTime denNgay) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getBKeHangXuat(tuNgay, denNgay);
    });
  }
}
