import 'dart:async';

import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_view_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/repository/ikhach_repository.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/repository/khach_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final khachViewProvider = AsyncNotifierProvider.autoDispose(KhachViewNotifier.new, retry: (_, _) => null);

class KhachViewNotifier extends AsyncNotifier<List<KhachViewModel>> {
  IKhachRepository get _repo => ref.read(khachRepositoryProvider);

  @override
  FutureOr<List<KhachViewModel>> build() {
    // TODO: implement build
    return get();
  }

  Future<List<KhachViewModel>> get() async {
    return await _repo.getView();
  }
  Future<void> delete(int id) async {
    await _repo.delete(id);
  }
}
