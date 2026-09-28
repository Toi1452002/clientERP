import 'dart:async';

import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_edit_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/inhanvien_repository.dart';
import '../../data/repository/nhanvien_repository.dart';

final nhanVienGetEditProvider = AsyncNotifierProvider.autoDispose(NhanVienGetEditNotifier.new, retry: (_,_)=>null);

class NhanVienGetEditNotifier extends AsyncNotifier<NhanVienEditModel?>{
  INhanVienRepository get _repo => ref.read(nhanVienRepositoryProvider);

  @override
  FutureOr<NhanVienEditModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> get({int? id}) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      if(id==null)return null;
      return await _repo.getById(id);
    });
  }

}