import 'dart:async';

import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_request_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/repository/imanghiepvu_repository.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/repository/manghiepvu_repository.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/ui/state/manghiepvu_lookup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final maNghiepVuProvider = AsyncNotifierProvider(ManghiepVuNotifier.new, retry: (_, _) => null);

class ManghiepVuNotifier extends AsyncNotifier<List<MaNghiepVuModel>> {
  IMaNghiepVuRepository get _repo => ref.read(maNghiepVuRepositoryProvider);

  @override
  Future<List<MaNghiepVuModel>> build() async {
    // TODO: implement build
    return await _repo.getView();
  }

  Future<void> changedRow(MaNghiepVuModel model) async {
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
    //
    // if (model.maNV.startsWith("N")) {
    //   ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.nhap));
    // } else if (model.maNV.startsWith("X")) {
    //   ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.xuat));
    // } else if (model.maNV.startsWith("T")) {
    //   ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.thu));
    // } else if (model.maNV.startsWith("C")) {
    //   ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.chi));
    // }
  }

  // Future<void> add(MaNghiepVuModel model) async {
  //
  //   state = AsyncLoading();
  //
  //
  //   // try {
  //   //   final result = await _repo.add(model);
  //   //   if (result > 0) {
  //   //     state = const AsyncLoading();
  //   //     state = await AsyncValue.guard(() async {
  //   //       return await _repo.getView();
  //   //     });
  //   //
  //   //     if (model.maNV.startsWith("N")) {
  //   //       ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.nhap));
  //   //     } else if (model.maNV.startsWith("X")) {
  //   //       ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.xuat));
  //   //     } else if (model.maNV.startsWith("T")) {
  //   //       ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.thu));
  //   //     } else if (model.maNV.startsWith("C")) {
  //   //       ref.invalidate(maNghiepVuLookupProvider(KieuNghiepVu.chi));
  //   //     }
  //   //   }
  //   // } catch (e) {
  //   //   rethrow;
  //   // }
  // }
  //
  // Future<void> updateMaNV(String ma, int id) async {
  //   try {
  //     await _repo.updateMaNV(ma, id);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // Future<void> updateMoTa(String moTa, int id) async {
  //   try {
  //     await _repo.updateMoTa(moTa, id);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> delete(int id) async {
    // state = AsyncLoading();
    final result = await _repo.delete(id);
    if(result>0){
      state = AsyncData(state.value!.where((e) => e.id != id).toList());
    }
  }
}
