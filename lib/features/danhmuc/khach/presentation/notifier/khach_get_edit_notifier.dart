import 'dart:async';

import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_edit_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/ikhach_repository.dart';
import '../../data/repository/khach_repository.dart';

final khachGetEditProvider = AsyncNotifierProvider.autoDispose(KhachGetEditNotifier.new, retry: (_,_)=>null);

class KhachGetEditNotifier extends AsyncNotifier<KhachEditModel?>{
  IKhachRepository get _repo => ref.read(khachRepositoryProvider);

  @override
  FutureOr<KhachEditModel?> build() {
    // TODO: implement build
    return null;
  }
  Future<void> get({int? id}) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (id == null) return null;
      return await _repo.getById(id);
    });
  }
}