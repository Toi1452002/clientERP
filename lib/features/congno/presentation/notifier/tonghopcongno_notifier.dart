import 'dart:async';

import 'package:erp_client_1/features/congno/data/model/tonghop_congno_model.dart';
import 'package:erp_client_1/features/congno/data/repository/congno_repository.dart';
import 'package:erp_client_1/features/congno/data/repository/icongno_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tongHopCongNoProvider = AsyncNotifierProvider(TongHopCongNoNotifier.new, retry: (_,_)=>null);

class TongHopCongNoNotifier extends AsyncNotifier<List<TongHopCongNoModel>>{
  ICongNoRepository get _repo => ref.read(congNoRepositoryProvider);
  @override
  Future<List<TongHopCongNoModel>> build() async {
    // TODO: implement build
    return await _repo.getTongHopCongNo(DateTime.now());
  }

  Future<void> get(DateTime date)async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return _repo.getTongHopCongNo(date);
    });
  }
}