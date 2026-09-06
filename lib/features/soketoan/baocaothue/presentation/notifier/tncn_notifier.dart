import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tncn_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/baocaothue_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/ibaocaothue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tncnProvider = AsyncNotifierProvider.autoDispose(TNCNNotifier.new, retry:(_,_)=>null);

class TNCNNotifier extends AsyncNotifier<List<TNCNModel>>{

  IBaoCaoThueRepository get _repo => ref.read(baoCaoThueRepositoryProvider);

  @override
  FutureOr<List<TNCNModel>> build(){
    // TODO: implement build
    return [];
  }

  Future<void> get(int year, int quy)async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getViewTNCN(year,quy);
    });
  }

}