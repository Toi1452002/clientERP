import 'dart:async';

import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_taikhoan_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/dky_repository.dart';
import '../../data/repository/idky_repository.dart';

final dkyTaiKhoanViewProvider = AsyncNotifierProvider(DKyTaiKhoanViewNotifier.new, retry:(_,_)=>null);

class DKyTaiKhoanViewNotifier extends AsyncNotifier<List<DKyTaiKhoanViewModel>>{
  IDkyRepository get _repo => ref.read(dkyRepositoryProvider);

  @override
  FutureOr<List<DKyTaiKhoanViewModel>> build() async{
    // TODO: implement build
    return await _repo.getViewDKyTaiKhoan();
  }

}