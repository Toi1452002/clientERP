import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/phieuxuat_request_model.dart';
import '../../data/repository/iphieuxuat_repository.dart';
import '../../data/repository/phieuxuat_repository.dart';

final phieuXuatProvider = AsyncNotifierProvider.autoDispose(PhieuXuatNotifier.new, retry: (_, _) => null);

class PhieuXuatNotifier extends AsyncNotifier<PhieuXuatRequestModel?> {
  IPhieuXuatRepository get _repo => ref.read(phieuXuatRepositoryProvider);

  @override
  FutureOr<PhieuXuatRequestModel?> build() {
    // TODO: implement build
    return null;
    // return getLast();
  }

  Future<PhieuXuatRequestModel?> getLast() async => await _repo.getLast();

  Future<void> getFirst() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.getFirst();
    });
  }

  Future<void> rebuild() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return getLast();
    });
  }

  Future<void> getPrevious() async {
    if (state.value != null && state.value?.phieuXuat.idTruoc!=null) {
      final  id = state.value!.phieuXuat.idTruoc;

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
      final  id = state.value!.phieuXuat.idSau;
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

  Future<void> getByPhieu(String phieu) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = await _repo.getByPhieu(phieu);
      return data;
    });
  }

  Future<void> addPhieu() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = await _repo.add();
      return data;
    });
  }

  // void updateKhoa() {
  //   final khoa = state.value?.phieuXuat.khoa;
  //   state = AsyncData(state.value?.copyWith(phieuXuat: state.value?.phieuXuat.copyWith(khoa: !khoa!)));
  // }
}
