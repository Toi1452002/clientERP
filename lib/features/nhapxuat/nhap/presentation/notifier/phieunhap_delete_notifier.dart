import 'dart:async';

import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/iphieunhap_repository.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/phieunhap_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phieuNhapDeleteProvider = AsyncNotifierProvider.autoDispose(PhieuNhapDeleteNotifier.new, retry: (_,_)=>null);

class PhieuNhapDeleteNotifier extends AsyncNotifier<void>{

  IPhieuNhapRepository get _repo => ref.read(phieuNhapRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> delete(int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      await _repo.delete(id);
    });
  }

}