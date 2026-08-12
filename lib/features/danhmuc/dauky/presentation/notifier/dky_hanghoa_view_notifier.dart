import 'dart:async';

import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_hanghoa_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/dky_repository.dart';
import '../../data/repository/idky_repository.dart';
final dkyHangHoaViewProvider = AsyncNotifierProvider(DKyHangHoaViewNotifier.new, retry: (_,_)=>null);

class DKyHangHoaViewNotifier extends AsyncNotifier<List<DKyHangHoaViewModel>>{
  IDkyRepository get _repo => ref.read(dkyRepositoryProvider);

  @override
  FutureOr<List<DKyHangHoaViewModel>> build()async {
    // TODO: implement build
    return await _repo.getViewDKyHangHoa();
  }

}