import 'dart:async';

import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_edit_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_request_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_view_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/inhanvien_repository.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/nhanvien_repository.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/notifier/pcgt_view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nhanVienEditProvider = AsyncNotifierProvider.autoDispose(NhanVienEditNotifier.new);

class NhanVienEditNotifier extends AsyncNotifier<NhanVienViewModel?>{
  INhanVienRepository get _repo => ref.read(nhanVienRepositoryProvider);

  @override
  FutureOr<NhanVienViewModel?> build() {
    // TODO: implement build
      return null;
  }

  Future<void> add(NhanVienRequestModel nv, List<PCGTRequestModel> lstPC) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.add(nv, lstPC);
    });
  }


  Future<void> updateNV(NhanVienRequestModel nv, List<PCGTRequestModel> lstPC, int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.update(nv, lstPC, id);
    });
  }

}