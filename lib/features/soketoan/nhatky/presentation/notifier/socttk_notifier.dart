import 'dart:async';

import 'package:erp_client_1/features/soketoan/nhatky/data/model/socttk_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/inhatky_repository.dart';
import '../../data/repository/nhatky_repository.dart';


final soCTTKProvider = AsyncNotifierProvider.autoDispose(SoCTTKNotifier.new, retry:(_,_)=>null);

class SoCTTKNotifier extends AsyncNotifier<SoCTTKViewModel?>{
  INhatKyRepository get _repo => ref.read(nhatKyRepositoryProvider);

  @override
  FutureOr<SoCTTKViewModel?> build() {
    // TODO: implement build
    return null;
  }
  Future<void> get(String maTK, DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getSoCTTK(maTK, tuNgay, denNgay);
    });
  }
}