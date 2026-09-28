import 'dart:async';

import 'package:erp_client_1/features/danhmuc/hanghoa/data/model/hanghoaview_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/hanghoa_model.dart';
import '../../data/model/loaihang_model.dart';
import '../../data/repository/hanghoa_repository.dart';
import '../../data/repository/ihanghoa_repository.dart';

final hangHoaEditProvider = AsyncNotifierProvider.autoDispose(HangHoaEditController.new, retry: (_, _) => null);

final loaiHangProvider = FutureProvider<List<LoaiHangModel>>((ref) async {
  return await ref.read(hangHoaRepositoryProvider).getLoaiHang();
}, retry: (_, _) => null);

class HangHoaEditController extends AsyncNotifier<HangHoaViewModel?> {
  IHangHoaRepository get _repo => ref.read(hangHoaRepositoryProvider);

  @override
  FutureOr<HangHoaViewModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> addHangHoa(HangHoaModel hangHoa) async {
    state = AsyncLoading();
    if (hangHoa.maHH.trim().isEmpty) {
      state = AsyncError("Mã hàng hóa trống", StackTrace.current);
      return;
    }
    if (hangHoa.tenHH.trim().isEmpty) {
      state = AsyncError("Tên hàng hóa trống", StackTrace.current);
      return;
    }
    state = await AsyncValue.guard(() async {
      return await _repo.add(hangHoa);
    });
  }

  Future<void> updateHangHoa(HangHoaModel hangHoa, int id) async {
    state = AsyncLoading();
    if (hangHoa.maHH.trim().isEmpty) {
      state = AsyncError("Mã hàng hóa trống", StackTrace.current);
      return;
    }
    if (hangHoa.tenHH.trim().isEmpty) {
      state = AsyncError("Tên hàng hóa trống", StackTrace.current);
      return;
    }
    state = await AsyncValue.guard(() async {
      return await _repo.update(hangHoa, id);
    });
  }
}
