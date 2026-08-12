import 'dart:async';

import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhap_update_model.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/iphieunhap_repository.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/phieunhap_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phieuNhapSaveProvider = AsyncNotifierProvider(PhieuNhapSaveNotifier.new, retry: (_,_)=>null);
class PhieuNhapSaveNotifier extends AsyncNotifier<void>{

  IPhieuNhapRepository get _repo => ref.read(phieuNhapRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> save(PhieuNhapUpdateModel x, int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await _repo.update(x, id);
    });
  }

  Future<void> updateKhoa(int phieuNhapId) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await _repo.updateKhoa(phieuNhapId);
    });
  }
}