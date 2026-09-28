import 'dart:async';

import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/itaikhoan_repository.dart';
import '../../data/repository/taikhoan_repository.dart';

final taiKhoanEditProvider = AsyncNotifierProvider.autoDispose(TaiKhoanEditNotifier.new, retry:(_,_)=>null);

class TaiKhoanEditNotifier extends AsyncNotifier<TaiKhoanViewModel?>{
  ITaiKhoanRepository get _repo => ref.read(taiKhoanRepositoryProvider);

  @override
  FutureOr<TaiKhoanViewModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> get({int? id}) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      if(id == null) return null;
      return await _repo.getEdit(id);
    });
  }

}