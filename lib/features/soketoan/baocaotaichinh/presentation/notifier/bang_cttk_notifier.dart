import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/baocaotaichinh_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/ibaocaotaichinh_repository.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socttk_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bangCTTKProvider = AsyncNotifierProvider.autoDispose(BangCTTKNotifier.new, retry:(_,_)=>null);

class BangCTTKNotifier extends AsyncNotifier<List<SoCTTKModel>>{

  IBaoCaoTaiChinhRepository get _repo => ref.read(baoCaoTaiChinhRepositoryProvider);

  @override
  FutureOr<List<SoCTTKModel>> build() {
    // TODO: implement build
    return [];
  }

  Future<void> get(String maTK, String year)async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getViewCTTK(maTK, year);
    });
  }

}