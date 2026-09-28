import 'dart:async';

import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/repository/bangluong_repository.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/repository/ibangluong_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final pcgtChiTietNotifier = AsyncNotifierProvider(PCGTChiTietNotifier.new, retry: (_,_)=>null);

class PCGTChiTietNotifier extends AsyncNotifier<List<PCGTViewCTModel>>{

  IBangLuongRepository get _repo => ref.read(bangLuongRepositoryProvider);

  @override
  FutureOr<List<PCGTViewCTModel>> build() {
    // TODO: implement build
    return [];
  }

  Future<void> get(String maNV, String maPC) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getPCGT(maNV, maPC);
    });
  }

}
