import 'dart:async';

import 'package:erp_client_1/features/soketoan/nhatky/data/model/nhatkychung_model.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/repository/inhatky_repository.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/repository/nhatky_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nhatKyChungProvider = AsyncNotifierProvider.autoDispose(NhatKyChungNotifier.new, retry: (_,_)=>null);

class NhatKyChungNotifier extends AsyncNotifier<List<NhatKyChungModel>>{

  INhatKyRepository get _repo => ref.read(nhatKyRepositoryProvider);

  @override
  FutureOr<List<NhatKyChungModel>> build()  async{
    // TODO: implement build
    return await _repo.getNhatKyChung(DateTime.now().copyWith(day: 1), DateTime.now());
  }

  Future<void>  get(DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getNhatKyChung(tuNgay, denNgay);
    });
  }

}