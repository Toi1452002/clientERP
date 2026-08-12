import 'dart:async';

import 'package:erp_client_1/features/thuchi/chi/data/repository/chi_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/ichi_repository.dart';
final chiDeleteProvider = AsyncNotifierProvider.autoDispose(ChiDeleteNotifier.new,retry:(_,_)=>null);

class ChiDeleteNotifier extends AsyncNotifier<void> {
  IChiRepository get _repo => ref.read(chiRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> delete(int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.delete(id);
    });
  }
}
