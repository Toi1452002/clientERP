import 'dart:async';

import 'package:erp_client_1/features/soketoan/nhatky/data/model/socaitk_model.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/repository/inhatky_repository.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/repository/nhatky_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final soCaiTKProvider = AsyncNotifierProvider.autoDispose(SoCaiTKNotifier.new, retry: (_,_)=>null);

class SoCaiTKNotifier extends AsyncNotifier<SoCaiTKViewModel?>{

  INhatKyRepository get _repo => ref.read(nhatKyRepositoryProvider);

  @override
  FutureOr<SoCaiTKViewModel?> build() {
    // TODO: implement build
    return null;
  }


    Future<void> get(String maTK, DateTime tuNgay, DateTime denNgay) async{
      state = AsyncLoading();
      state = await AsyncValue.guard(() async{
        return await _repo.getSoCaiTK(maTK, tuNgay, denNgay);
      });
    }
}