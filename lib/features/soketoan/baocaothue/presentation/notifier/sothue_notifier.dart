import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaothue/data/model/sothue_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/baocaothue_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/ibaocaothue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stGTGTProvider = AsyncNotifierProvider.autoDispose(GTGTNotifier.new, retry: (_,_)=>null);
final stTNDNProvider = AsyncNotifierProvider.autoDispose(StTNDNNotifier.new, retry: (_,_)=>null);
final stTNCNProvider = AsyncNotifierProvider.autoDispose(StTNCNNotifier.new, retry: (_,_)=>null);

class GTGTNotifier extends AsyncNotifier<List<SoThueModel>>{
  IBaoCaoThueRepository get _repo => ref.read(baoCaoThueRepositoryProvider);
  @override
  FutureOr<List<SoThueModel>> build() async{
    // TODO: implement build
    return await _repo.getViewSoThue("GTGT");
  }

  Future<void> tinhGTGT(int year, int soThueId) async{
    state = AsyncLoading();
    final result = await _repo.tinhGTGT(year, soThueId);
    updateRow(result);
  }

  void updateRow(SoThueModel newData) {

    final currentList = state.value ?? [];

    final newList = currentList.map((item) {
      if (item.id == newData.id) {
        return newData;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
  }


  Future<void> updateGTGT(UpdateGTGTModel model, int id) async{
    await _repo.updateGTGT(model, id);
  }

}

class StTNDNNotifier extends AsyncNotifier<List<SoThueModel>>{
  IBaoCaoThueRepository get _repo => ref.read(baoCaoThueRepositoryProvider);
  @override
  FutureOr<List<SoThueModel>> build() async{
    // TODO: implement build
    return await _repo.getViewSoThue("TNDN");
  }
  Future<void> tinhTNDN(int year, int id) async{
    state = AsyncLoading();
    final result = await _repo.tinhTNDN(year, id);
    updateRow(result);
  }

  void updateRow(SoThueModel newData) {

    final currentList = state.value ?? [];

    final newList = currentList.map((item) {
      if (item.id == newData.id) {
        return newData;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
  }


  Future<void> updateTNDN(UpdateTNDNModel model, int id) async{
    await _repo.updateTNDN(model, id);
  }
}

class StTNCNNotifier extends AsyncNotifier<List<SoThueModel>>{
  IBaoCaoThueRepository get _repo => ref.read(baoCaoThueRepositoryProvider);
  @override
  FutureOr<List<SoThueModel>> build() async{
    // TODO: implement build
    return await _repo.getViewSoThue("TNCN");
  }

  Future<void> tinhTNCN(int year, int id) async{
    state = AsyncLoading();
    final result = await _repo.tinhTNCN(year, id);
    updateRow(result);
  }

  void updateRow(SoThueModel newData) {

    final currentList = state.value ?? [];

    final newList = currentList.map((item) {
      if (item.id == newData.id) {
        return newData;
      }
      return item;
    }).toList();

    state = AsyncData(newList);
  }


  Future<void> updateTNCN(UpdateTNCNModel model, int id) async{
    await _repo.updateTNCN(model, id);
  }
}
