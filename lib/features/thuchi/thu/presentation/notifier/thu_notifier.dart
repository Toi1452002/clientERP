import 'dart:async';

import 'package:erp_client_1/features/thuchi/thu/data/model/phieuthu_model.dart';
import 'package:erp_client_1/features/thuchi/thu/data/repository/ithu_repository.dart';
import 'package:erp_client_1/features/thuchi/thu/data/repository/thu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final thuProvider = AsyncNotifierProvider.autoDispose(ThuNotifier.new, retry: (_, _) => null);

class ThuNotifier extends AsyncNotifier<PhieuThuModel?> {
  IThuRepository get _repo => ref.read(thuRepositoryProvider);

  @override
  FutureOr<PhieuThuModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<PhieuThuModel?> getLast() async => await _repo.getLastPhieu();

  Future<void> getFirst() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getFirstPhieu();
    });
  }

  Future<void> getPrevious() async {
    if (state.value != null) {
      state = AsyncLoading();
      state = await AsyncValue.guard(() async {
        final data = await _repo.getPrevious(state.value!.id);
        if(data == null) return state.value;
        return data;
      });
    }
  }

  Future<void> getNext() async {
    if (state.value != null) {
      state = AsyncLoading();
      state = await AsyncValue.guard(() async {
        final data = await _repo.getNext(state.value!.id);
        if(data == null) return await getLast();

        return data;
      });
    }
  }

  Future<void> rebuild() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return getLast();
    });
  }

  Future<void> addPhieu() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = await _repo.add();
      return data;
    });
  }

  Future<void> updateEdit() async {
    state = AsyncData(state.value?.copyWith(khoa: false));
  }

  Future<void> getByPhieu(String phieu) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = await _repo.getByPhieu(phieu);
      return data;
    });
  }
}
