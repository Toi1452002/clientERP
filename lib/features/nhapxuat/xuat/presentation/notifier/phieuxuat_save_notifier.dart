import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/phieuxuat_update_model.dart';
import '../../data/repository/iphieuxuat_repository.dart';
import '../../data/repository/phieuxuat_repository.dart';

final phieuXuatSaveProvider = AsyncNotifierProvider(PhieuXuatSaveNotifier.new, retry: (_,_)=>null);
class PhieuXuatSaveNotifier extends AsyncNotifier<void>{

  IPhieuXuatRepository get _repo => ref.read(phieuXuatRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> save(PhieuXuatUpdateModel x, int id) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await _repo.update(x, id);
    });
  }

  Future<void> updateKhoa(int phieuXuatId) async{
    state = AsyncLoading();
    state = await AsyncValue.guard(()async{
      await _repo.updateKhoa(phieuXuatId);
    });
  }
}