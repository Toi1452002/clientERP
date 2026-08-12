import 'dart:async';

import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_hanghoa_request_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_khachhang_request_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/dky_repository.dart';
import '../../data/repository/idky_repository.dart';

final dkyUpdateProvider = AsyncNotifierProvider.autoDispose(DKyUpdateNotifier.new, retry: (_, _) => null);

class DKyUpdateNotifier extends AsyncNotifier<void> {
  IDkyRepository get _repo => ref.read(dkyRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
  }

  Future<void> updateDKyKhachHang(List<DKyKhachHangRequestModel> data) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.updateDKyKhachHang(data);
    });
  }
  Future<void> updateDKyHangHoa(List<DKyHangHoaRequestModel> data) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.updateDkyHangHoa(data);
    });
  }

  Future<void> ghiDKTK(int thang, String nam) async{
    final year = int.parse(nam);
    final tmp = DateTime(year,thang);
    final month = DateTime(year,tmp.month-1).month;
    final date = DateTime(int.parse(nam), month, 1);
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.updateDKyTaiKhoan(DateHelper.yM(date));
    });
  }

  Future<void> updateCKNo(num value, String maTK) async{
    await _repo.updateCKNo(value, maTK);
  }
  Future<void> updateCKCo(num value, String maTK) async{
    await _repo.updateCKCo(value, maTK);
  }
}
