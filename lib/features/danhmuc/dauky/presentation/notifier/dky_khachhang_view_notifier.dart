import 'dart:async';

import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_khachhang_view_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/repository/dky_repository.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/repository/idky_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dkyKhachHangViewProvider = AsyncNotifierProvider(DKyKhachHangViewNotifier.new, retry: (_,_)=>null);

class DKyKhachHangViewNotifier extends AsyncNotifier<List<DKyKhachHangViewModel>>{


    IDkyRepository get _repo => ref.read(dkyRepositoryProvider);

  @override
  FutureOr<List<DKyKhachHangViewModel>> build() async{
    // TODO: implement build
    return await _repo.getViewDKyKhachHang();
  }
}