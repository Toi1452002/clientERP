import 'dart:async';

import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/repository/imanghiepvu_repository.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/repository/manghiepvu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/manghiepvu_request_model.dart';

final maNghiepVuEditProvider = AsyncNotifierProvider.autoDispose(MaNghiepVuEditNotifier.new, retry: (_,_)=>null);

class MaNghiepVuEditNotifier extends AsyncNotifier<MaNghiepVuModel?> {

  IMaNghiepVuRepository get _repo => ref.read(maNghiepVuRepositoryProvider);

  @override
  FutureOr<MaNghiepVuModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> add(MaNghiepVuRequestModel model) async{
    if(model.maNV.isEmpty || model.moTa.isEmpty){
      state = AsyncError("Nhập đầy đủ thông tin", StackTrace.current);
      return;
    }

    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.add(model);
    });
  }


  Future<void> updateRow(MaNghiepVuRequestModel model, int id) async{

    if(model.maNV.isEmpty || model.moTa.isEmpty){

      state = AsyncError("Nhập đầy đủ thông tin", StackTrace.current);
      return;
    }

    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.update(model, id);
    });
  }
}