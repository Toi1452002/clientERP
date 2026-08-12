import 'dart:async';

import 'package:erp_client_1/features/thuchi/thu/data/model/phieuthu_save_model.dart';
import 'package:erp_client_1/features/thuchi/thu/data/repository/ithu_repository.dart';
import 'package:erp_client_1/features/thuchi/thu/data/repository/thu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final thuSaveProvider = AsyncNotifierProvider.autoDispose(ThuSaveNotifier.new, retry: (_,_)=> null);

class ThuSaveNotifier extends AsyncNotifier<void>{
  IThuRepository get _repo => ref.read(thuRepositoryProvider);
  @override
  FutureOr<void> build() {
    // TODO: implement build
    // throw UnimplementedError();
  }


  Future<void> save(PhieuThuSaveModel pt, int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      await _repo.onSave(pt, id);
    });
  }

}