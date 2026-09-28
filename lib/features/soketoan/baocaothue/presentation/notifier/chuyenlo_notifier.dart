import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_ct_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/baocaothue_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/ibaocaothue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final chuyenLoProvider = AsyncNotifierProvider.autoDispose(ChuyenLoNotifier.new, retry:(_,_)=>null);
final chuyenLoCTProvider = AsyncNotifierProvider.autoDispose(ChuyenLoCTNotifier.new, retry:(_,_)=>null);

class ChuyenLoNotifier extends AsyncNotifier<List<ChuyenLoModel>>{

  IBaoCaoThueRepository get _repo =>ref.read(baoCaoThueRepositoryProvider);

  @override
  FutureOr<List<ChuyenLoModel>> build() async{
    // TODO: implement build
    return await _repo.getViewChuyenLo();
  }

  Future<void> get() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getViewChuyenLo();
    });
  }

}

class ChuyenLoCTNotifier extends AsyncNotifier<List<ChuyenLoCTModel>>{
  IBaoCaoThueRepository get _repo =>ref.read(baoCaoThueRepositoryProvider);

  @override
  FutureOr<List<ChuyenLoCTModel>> build() {
    // TODO: implement build
    return [];
  }
  Future<void> get(int chuyenLoId, int year) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getViewChuyenLoCT(chuyenLoId, year);
    });
  }

  Future<void> updateCT(ChuyenLoCTModel model) async{
    await _repo.updateChuyenLoCT(model.toMap(), model.id);
  }
}