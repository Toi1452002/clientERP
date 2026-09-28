import 'dart:async';

import 'package:erp_client_1/features/soketoan/baocaothue/data/model/phat_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/baocaothue_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/ibaocaothue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phatProvider = AsyncNotifierProvider.autoDispose(PhatNotifier.new, retry: (_,_)=>null);

class PhatNotifier extends AsyncNotifier<List<PhatModel>>{
  IBaoCaoThueRepository get _repo => ref.read(baoCaoThueRepositoryProvider);
  @override
  FutureOr<List<PhatModel>> build() async{
    // TODO: implement build
    return await _repo.getViewPhat();
  }

  Future<void> addRow() async{
    final result = await _repo.addRowPhat();
    state = AsyncLoading();
    final currentList = state.value ?? [];

    state = AsyncData([
      ...currentList,
      result,
    ]);
  }

  Future<void> updatePhat(PhatModel model) async{
    await _repo.updatePhat(model);
  }

}