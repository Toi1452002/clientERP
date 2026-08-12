import 'dart:async';

import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_view_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/repository/itaikhoan_repository.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/repository/taikhoan_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taiKhoanViewProvider = AsyncNotifierProvider(TaiKhoanViewNotifier.new, retry: (_,_)=>null);

class TaiKhoanViewNotifier extends AsyncNotifier<List<TaiKhoanViewModel>>{
  ITaiKhoanRepository get _repo => ref.read(taiKhoanRepositoryProvider);

  @override
  FutureOr<List<TaiKhoanViewModel>> build()  async{
    // TODO: implement build
    return await _repo.getView();
  }


  Future<int> delete(int id) async{
    return await _repo.delete(id);
  }


}