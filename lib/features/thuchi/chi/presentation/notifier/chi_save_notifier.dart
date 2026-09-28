
import 'dart:async';

import 'package:erp_client_1/features/thuchi/chi/data/model/phieuchi_save_model.dart';
import 'package:erp_client_1/features/thuchi/chi/data/repository/chi_repository.dart';
import 'package:erp_client_1/features/thuchi/chi/data/repository/ichi_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chiSaveProvider = AsyncNotifierProvider.autoDispose(ChiSaveNotifier.new, retry: (_,_)=> null);

class ChiSaveNotifier extends AsyncNotifier<void>{
  IChiRepository get _repo => ref.read(chiRepositoryProvider);
  @override
  FutureOr<void> build() {
    // TODO: implement build
    // throw UnimplementedError();
  }


  Future<void> save(PhieuChiSaveModel pt, int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      await _repo.onSave(pt, id);
    });
  }

  Future<void> updateEdit(int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.updateEdit(id);
    });
  }

}