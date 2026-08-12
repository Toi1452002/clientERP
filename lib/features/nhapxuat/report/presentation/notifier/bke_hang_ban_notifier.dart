import 'dart:async';

import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hangban_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/date_helper.dart';
import '../../data/repository/ireport_nx_repository.dart';
import '../../data/repository/report_nx_repository.dart';
final bkeHangBanProvider = AsyncNotifierProvider.autoDispose(BKeHangBanNotifier.new, retry:(_,_)=>null);

class BKeHangBanNotifier extends AsyncNotifier<List<BkeHangBanModel>>{
  IReportNxRepository get _repo => ref.read(reportNXProvider);

  @override
  FutureOr<List<BkeHangBanModel>> build() async{
    // TODO: implement build
    return await _repo.getHangBan(
      DateTime.now().copyWith(day: 1),
      DateTime.now().copyWith(month: DateHelper.ngayCuoiThang(DateTime.now().year, DateTime.now().month)),
    );
  }

  Future<void> get({DateTime? tuNgay, DateTime? denNgay}) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getHangBan(
        tuNgay ?? DateTime.now().copyWith(day: 1),
        denNgay ?? DateTime.now().copyWith(month: DateHelper.ngayCuoiThang(DateTime.now().year, DateTime.now().month)),
      );
    });
  }

}