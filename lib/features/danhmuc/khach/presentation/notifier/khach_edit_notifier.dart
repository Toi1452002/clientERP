import 'dart:async';

import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/khach_edit_model.dart';
import '../../data/model/khach_request_model.dart';
import '../../data/repository/ikhach_repository.dart';
import '../../data/repository/khach_repository.dart';

final khachEditProvider = AsyncNotifierProvider.autoDispose(KhachEditNotifier.new);

class KhachEditNotifier extends AsyncNotifier<KhachViewModel?> {
  IKhachRepository get repo => ref.read(khachRepositoryProvider);

  @override
  FutureOr<KhachViewModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> addKhach(KhachRequestModel khach) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await repo.add(khach);
    });
  }

  Future<void> updateKhach(KhachRequestModel khach, int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await repo.update(khach, id);
    });
  }
}
