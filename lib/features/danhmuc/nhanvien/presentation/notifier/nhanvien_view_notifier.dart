import 'dart:async';

import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_view_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/inhanvien_repository.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/nhanvien_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nhanVienViewProvider = AsyncNotifierProvider(NhanVienViewNotifier.new, retry: (_,_)=>null);

class NhanVienViewNotifier extends AsyncNotifier<List<NhanVienViewModel>>{

  INhanVienRepository get _repo => ref.read(nhanVienRepositoryProvider);

  @override
  FutureOr<List<NhanVienViewModel>> build() async{
    // TODO: implement build
    return await _repo.getView();
  }


  Future<int> delete(int nhanVienId) async{
    return await _repo.delete(nhanVienId);
  }

}