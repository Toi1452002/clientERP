import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_cdps_model.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/baocaotaichinh_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/ibaocaotaichinh_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bangCDPSProvider = AsyncNotifierProvider.autoDispose(BangCDPSNotifier.new, retry: (_,_)=>null);

class BangCDPSNotifier extends AsyncNotifier<List<BangCDPSModel>>{

  IBaoCaoTaiChinhRepository get _repo => ref.read(baoCaoTaiChinhRepositoryProvider);

  @override
  FutureOr<List<BangCDPSModel>> build()  async{
    // TODO: implement build
    return await _repo.getViewCDPS(4);
  }

  Future<void> get(int kieu) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getViewCDPS(kieu);
    });
  }

  Future<void> thucHien(int kieu, DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.tinhToanCDPS(kieu, tuNgay, denNgay);
    });
  }

}