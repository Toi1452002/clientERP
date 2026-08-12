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


  Future<void> add(String value) async {
    try {
      await _repo.add(value);
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        return await _repo.getAll();
      });
    } catch (e) {
      rethrow;
    }
  }


  Future<void> updateNhomHang(int id, String value) async {
    try {
      await _repo.update(id, value);
      state = AsyncData(state.value!.map((e) => e.id == id ? e.copyWith(nhomHang: value) : e).toList());
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
