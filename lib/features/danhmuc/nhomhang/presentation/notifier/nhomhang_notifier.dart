import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/nhomhang_model.dart';
import '../../data/repository/inhomhang_repository.dart';
import '../../data/repository/nhomhang_repository.dart';

final nhomhangProvider = AsyncNotifierProvider(NhomHangNotifier.new, retry: (_, _)=>null,);

class NhomHangNotifier extends AsyncNotifier<List<NhomHangModel>> {
  INhomHangRepository get _repo => ref.read(nhomHangRepositoryProvider);

  @override
  FutureOr<List<NhomHangModel>> build() async {
    return await _repo.getAll();
  }

  Future<List<NhomHangModel>> getAll() async {
    return await _repo.getAll();
  }

  Future<void> changedRow(NhomHangModel model) async {
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

  Future<void> delete(int id) async {
    final result = await _repo.delete(id);
    if (result > 0) {
      state = AsyncData(state.value!.where((e) => e.id != id).toList());
    }
  }
}
