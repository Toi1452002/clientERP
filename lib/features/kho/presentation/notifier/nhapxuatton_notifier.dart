import 'dart:async';

import 'package:erp_client_1/features/kho/data/model/nhapxuatton_model.dart';
import 'package:erp_client_1/features/kho/data/repository/ikhohang_repository.dart';
import 'package:erp_client_1/features/kho/data/repository/khohang_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nhapXuatTonProvider = AsyncNotifierProvider(NhapXuatTonNotifier.new, retry: (_,_)=>null);

class NhapXuatTonNotifier extends AsyncNotifier<List<NhapXuatTonModel>>{
  IKhoHangRepository get _repo => ref.read(khoHangRepositoryProvider);

  @override
  FutureOr<List<NhapXuatTonModel>> build() {
    // TODO: implement build
    return [];
  }


  Future<void> get(DateTime tuNgay, DateTime denNgay, String maTK) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getNhapXuatTon(tuNgay, denNgay, maTK);
    });
  }
}