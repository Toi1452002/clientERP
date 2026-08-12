import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/bke_so_quy_model.dart';
import '../../data/model/soquy_request_model.dart';
import '../../data/repository/itc_report_repository.dart';
import '../../data/repository/tc_report_repository.dart';

final bkeSoQuyTGProvider = AsyncNotifierProvider(BKeSoQuyTGNotifier.new, retry: (_,_)=>null);

class BKeSoQuyTGNotifier extends AsyncNotifier<SoQuyRequestModel?>{
  ITCReportRepository get _repo => ref.read(tcReportProvider);

  @override
  FutureOr<SoQuyRequestModel?> build() {
    // TODO: implement build
    return null;
  }
  Future<void> get(DateTime tuNgay, DateTime denNgay) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.getBkeSoQuyTG(tuNgay, denNgay);
    });
  }
}