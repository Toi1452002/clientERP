import 'dart:async';

import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/inhanvien_repository.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/nhanvien_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pcgtViewProvider = AsyncNotifierProvider(PCGTViewNotifier.new, retry: (_,_)=>null);

class PCGTViewNotifier extends AsyncNotifier<List<PCGTViewModel>>{

  INhanVienRepository get _repo => ref.read(nhanVienRepositoryProvider);

  @override
  FutureOr<List<PCGTViewModel>> build() {
    // TODO: implement build
    return [];
  }




  Future<void> getView({int? id}) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getPCGTView(id);
    });
  }
}