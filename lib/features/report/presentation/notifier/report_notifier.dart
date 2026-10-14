import 'dart:async';
import 'dart:typed_data';

import 'package:erp_client_1/features/report/data/repository/ireport_repository.dart';
import 'package:erp_client_1/features/report/data/repository/report_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportProvider = AsyncNotifierProvider(ReportNotifier.new, retry: (_,_)=>null);

class ReportNotifier extends AsyncNotifier<Uint8List?>{

  IReportRepository get _repo => ref.read(reportRepositoryProvider);

  @override
  FutureOr<Uint8List?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> getPhieuNhap(int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.pdfPhieuNhap(id);
    });
  }
  Future<void> getPhieuXuat(int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.pdfPhieuXuat(id);
    });
  }
  Future<void> getPhieuThu(int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.pdfPhieuThu(id);
    });
  }
  Future<void> getPhieuChi(int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      return await _repo.pdfPhieuChi(id);
    });
  }
}