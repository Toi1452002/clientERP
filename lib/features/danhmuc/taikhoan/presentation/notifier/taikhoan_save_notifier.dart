import 'dart:async';

import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_request_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_view_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/repository/itaikhoan_repository.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/repository/taikhoan_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taiKhoanSaveProvider = AsyncNotifierProvider.autoDispose(TaiKhoanSaveNotifier.new, retry: (_,_)=> null);

class TaiKhoanSaveNotifier extends AsyncNotifier<TaiKhoanViewModel?> {
  ITaiKhoanRepository get _repo => ref.read(taiKhoanRepositoryProvider);
  @override
  FutureOr<TaiKhoanViewModel?> build() {
    // TODO: implement build
    return null;
  }


  Future<void> add(TaiKhoanRequestModel model) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.add(model);
    });
  }
  Future<void> updateTK(TaiKhoanRequestModel model, int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.update(model, id);
    });
  }
}