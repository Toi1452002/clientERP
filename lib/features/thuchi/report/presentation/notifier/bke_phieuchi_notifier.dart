import 'dart:async';

import 'package:erp_client_1/features/thuchi/report/data/model/bke_thu_chi_model.dart';
import 'package:erp_client_1/features/thuchi/report/data/repository/itc_report_repository.dart';
import 'package:erp_client_1/features/thuchi/report/data/repository/tc_report_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bkePhieuChiProvider = AsyncNotifierProvider(BKePhieuChiNotifier.new, retry:(_,_)=> null);

class BKePhieuChiNotifier extends AsyncNotifier<List<BKeThuChiModel>> {


  ITCReportRepository get _repo => ref.read(tcReportProvider);

  @override
  FutureOr<List<BKeThuChiModel>> build() {
    // TODO: implement build
    return [];
  }

  Future<void> get(DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getBkePhieuChi(tuNgay, denNgay);
    });
  }
}
