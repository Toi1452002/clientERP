import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_tmp_model.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/baocaotaichinh_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/ibaocaotaichinh_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final bangTmpCBTCProvider = AsyncNotifierProvider.autoDispose(BangTmpBCTCNotifier.new, retry: (_,_)=>null);

class BangTmpBCTCNotifier extends AsyncNotifier<List<BangTmpModel>> {
  IBaoCaoTaiChinhRepository get _repo => ref.read(baoCaoTaiChinhRepositoryProvider);

  @override
  FutureOr<List<BangTmpModel>> build() {
    // TODO: implement build
    return [];
  }

  Future<void> get(String form, int year) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getBCTC(form, year);
    });
  }
}
