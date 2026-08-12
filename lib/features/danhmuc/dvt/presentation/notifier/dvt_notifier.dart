import 'dart:async';

import 'package:erp_client_1/features/danhmuc/dvt/data/model/dvt_model.dart';
import 'package:erp_client_1/features/danhmuc/dvt/data/repository/dvt_repository.dart';
import 'package:erp_client_1/features/danhmuc/dvt/data/repository/idvt_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dvtProvider = AsyncNotifierProvider(DvtNotifier.new, retry: (_, _) => null);

class DvtNotifier extends AsyncNotifier<List<DvtModel>> {
  IDvtRepository get _repo => ref.read(dvtRepositoryProvider);

  @override
  Future<List<DvtModel>> build() async {
    return await getAll();
  }

  Future<List<DvtModel>> getAll() async {
    return await _repo.getAll();
  }

  Future<void> addDvt(String dvt) async {
    try {
      await _repo.add(dvt);
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        return await _repo.getAll();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDvt(int id, String dvt) async {
    try {
      await _repo.update(id, dvt);
      state = AsyncData(state.value!.map((e) => e.id == id ? e.copyWith(dvt: dvt) : e).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    try {
      await _repo.delete(id);
      state = AsyncData(state.value!.where((e) => e.id != id).toList());

    } catch (e) {
      rethrow;
    }
  }
}
