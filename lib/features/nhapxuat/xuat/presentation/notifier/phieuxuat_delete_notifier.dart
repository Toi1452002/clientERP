import 'dart:async';

import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/iphieunhap_repository.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/phieunhap_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/iphieuxuat_repository.dart';
import '../../data/repository/phieuxuat_repository.dart';

final phieuXuatDeleteProvider = AsyncNotifierProvider.autoDispose(PhieuXuatDeleteNotifier.new, retry: (_,_)=>null);

class PhieuXuatDeleteNotifier extends AsyncNotifier<void>{

  IPhieuXuatRepository get _repo => ref.read(phieuXuatRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> delete(int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      await _repo.delete(id);
    });
  }

}