import 'dart:async';

import 'package:erp_client_1/features/danhmuc/dvt/data/model/dvt_model.dart';
import 'package:erp_client_1/features/danhmuc/dvt/data/repository/dvt_repository.dart';
import 'package:erp_client_1/features/danhmuc/dvt/data/repository/idvt_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dvtEditProvider = AsyncNotifierProvider.autoDispose(DvtEditNotifier.new, retry: (_, _) => null);

class DvtEditNotifier extends AsyncNotifier<DvtModel?> {
  IDvtRepository get _repo => ref.read(dvtRepositoryProvider);

  @override
  FutureOr<DvtModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> add(String dvt) async {
    if (dvt.isEmpty) {
      state = AsyncError("Đơn vị tính trống!", StackTrace.current);
      return;
    }
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.add(dvt);
    });
  }

  Future<void> updateDvt(String dvt, int id) async {
    if (dvt.isEmpty) {
      state = AsyncError("Đơn vị tính trống!", StackTrace.current);
      return;
    }
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.update(id, dvt);
    });
  }
}
