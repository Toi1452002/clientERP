import 'dart:async';

import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hoadon_mua_model.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/repository/ireport_nx_repository.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/repository/report_nx_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bkeHoaDonMuaProvider = AsyncNotifierProvider.autoDispose(BKeHoaDonMuaNotifier.new, retry: (_, _) => null);

class BKeHoaDonMuaNotifier extends AsyncNotifier<List<BKeHoaDonMuaModel>> {
  IReportNxRepository get _repo => ref.read(reportNXProvider);

  @override
  FutureOr<List<BKeHoaDonMuaModel>> build() async {
    // TODO: implement build
    return await _repo.getHoaDonMua(
      DateTime.now().copyWith(day: 1),
      DateTime.now().copyWith(month: DateHelper.ngayCuoiThang(DateTime.now().year, DateTime.now().month)),
    );
  }

  Future<void> get({DateTime? tuNgay, DateTime? denNgay}) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getHoaDonMua(
        tuNgay ?? DateTime.now().copyWith(day: 1),
        denNgay ?? DateTime.now().copyWith(month: DateHelper.ngayCuoiThang(DateTime.now().year, DateTime.now().month)),
      );
    });
  }
}
