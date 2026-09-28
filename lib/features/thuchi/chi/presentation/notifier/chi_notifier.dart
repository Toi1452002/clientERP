import 'dart:async';

import 'package:erp_client_1/features/thuchi/chi/data/model/phieuchi_model.dart';
import 'package:erp_client_1/features/thuchi/chi/data/repository/chi_repository.dart';
import 'package:erp_client_1/features/thuchi/chi/data/repository/ichi_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final chiProvider = AsyncNotifierProvider.autoDispose(ChiNotifier.new, retry: (_, _) => null);

class ChiNotifier extends AsyncNotifier<PhieuChiModel?> {
  IChiRepository get _repo => ref.read(chiRepositoryProvider);

  @override
  FutureOr<PhieuChiModel?> build() {
    // TODO: implement build
    return null;
  }

  Future<PhieuChiModel?> getLast() async => await _repo.getLastPhieu();

  Future<void> getFirst() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getFirstPhieu();
    });
  }

  Future<void> getPrevious() async {
    if (state.value != null && state.value?.idTruoc!=null) {
      final  id = state.value!.idTruoc;
      state = AsyncLoading();
      state = await AsyncValue.guard(() async {
        final data = await _repo.getById(id!);
        if (data == null) return state.value;
        return data;
      });
    }
  }

  Future<void> getNext() async {
    if (state.value != null) {
      final  id = state.value!.idSau;
      state = AsyncLoading();
      state = await AsyncValue.guard(() async {
        if(id==null){
          return await getLast();
        }else{
          final data = await _repo.getById(id);
          return data;
        }
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

  // Future<void> updateEdit() async {
  //   state = AsyncData(state.value?.copyWith(khoa: false));
  // }

  Future<void> getByPhieu(String phieu) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = await _repo.getByPhieu(phieu);
      return data;
    });
  }
}
