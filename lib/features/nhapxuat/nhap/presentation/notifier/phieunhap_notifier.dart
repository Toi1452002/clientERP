import 'dart:async';

import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhap_response_model.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/iphieunhap_repository.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/phieunhap_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phieuNhapProvider = AsyncNotifierProvider.autoDispose(PhieuNhapNotifier.new, retry: (_, _) => null);

class PhieuNhapNotifier extends AsyncNotifier<PhieuNhapRequestModel?> {
  IPhieuNhapRepository get _repo => ref.read(phieuNhapRepositoryProvider);

  @override
  FutureOr<PhieuNhapRequestModel?> build() {
    // TODO: implement build
    return null;
    // return getLast();
  }

  Future<PhieuNhapRequestModel?> getLast() async => await _repo.getLast();

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

  Future<void> getPrevious(int id) async {
    if (state.value != null) {
      state = AsyncLoading();
      state = await AsyncValue.guard(() async {
        final data = await _repo.getPrevious(id);
        if(data == null) return state.value;
        return data;
      });
    }
  }

  Future<void> getNext(int id) async {
    if (state.value != null) {
      state = AsyncLoading();
      state = await AsyncValue.guard(() async {
        final data = await _repo.getNext(id);
        if(data == null) return await getLast();

        return data;
      });
    }
  }
  Future<void> getByPhieu(String phieu) async {
    // if (state.value != null) {
      state = AsyncLoading();
      state = await AsyncValue.guard(() async {
        final data = await _repo.getByPhieu(phieu);
        return data;
      });
    // }
  }

  Future<void> addPhieu() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      final data = await _repo.add();
      return data;
    });
  }

  // void updateKhoa() {
  //   final khoa = state.value?.phieuNhap.khoa;
  //   state = AsyncData(state.value?.copyWith(phieuNhap: state.value?.phieuNhap.copyWith(khoa: !khoa!)));
  // }
}
