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


  Future<void> changedRow(DvtModel model) async {
    final current = state.value ?? [];

    if (current.indexWhere((e) => e.id == model.id) == -1) {
      state = AsyncData([...current, model]);
    } else {
      final newList = current.map((e) {
        if (e.id == model.id) {
          return model;
        }

        return e;
      });
      state = AsyncData(newList.toList());
    }
  }

  // Future<void> updateDvt(int id, String dvt) async {
  //   try {
  //     await _repo.update(id, dvt);
  //     state = AsyncData(state.value!.map((e) => e.id == id ? e.copyWith(dvt: dvt) : e).toList());
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> delete(int id) async {
    final result = await _repo.delete(id);
    if (result > 0) {
      state = AsyncData(state.value!.where((e) => e.id != id).toList());
    }
  }
}
