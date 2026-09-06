import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/baocaothue_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/ibaocaothue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final tndnProvider = AsyncNotifierProvider.autoDispose(TNDNNotifier.new, retry:(_,_)=>null);

class TNDNNotifier extends AsyncNotifier<List<TNDNModel>>{

  IBaoCaoThueRepository get _repo => ref.read(baoCaoThueRepositoryProvider);

  @override
  FutureOr<List<TNDNModel>> build() async{
    // TODO: implement build
    return await _repo.getViewTNDN(DateTime.now().year-1);
  }


  Future<void> get(int year)async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getViewTNDN(year);
    });
  }

}