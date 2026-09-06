import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_tt_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/baocaothue_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/ibaocaothue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tndnttProvider = AsyncNotifierProvider.autoDispose(TNDNttNotifier.new, retry:(_,_)=>null);

class TNDNttNotifier extends AsyncNotifier<List<TNDNttModel>>{

  IBaoCaoThueRepository get _repo => ref.read(baoCaoThueRepositoryProvider);

  @override
  FutureOr<List<TNDNttModel>> build() {
    // TODO: implement build
    return [];
  }

  Future<void> get(int year, int quy) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getViewTNDNtt(year, quy);
    });
  }

}