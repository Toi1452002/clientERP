import 'dart:async';

import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/baocaotaichinh_repository.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/ibaocaotaichinh_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final luuSoDuNotifier = AsyncNotifierProvider.autoDispose(LuuSoDuNotifier.new, retry:(_,_)=>null);
final luuNamTruocNotifier = AsyncNotifierProvider.autoDispose(LuuNamTruoc.new, retry:(_,_)=>null);

class LuuSoDuNotifier extends AsyncNotifier<bool>{

  IBaoCaoTaiChinhRepository get _repo => ref.read(baoCaoTaiChinhRepositoryProvider);

  @override
  FutureOr<bool> build() {
    // TODO: implement build
    return false;
  }

  Future<void> save(DateTime denNgay, int kieu) async{
    String thang = '';
    state = AsyncLoading();
    if(kieu == 2){ // Nam
      thang = DateHelper.yM(denNgay);
    }else{
      thang = "${denNgay.year}";
    }
    state = await AsyncValue.guard(() async{
     return await _repo.luuSoDuCDPS(thang,nam: kieu == 2);
    });
  }
}

class LuuNamTruoc extends AsyncNotifier<void> {
  IBaoCaoTaiChinhRepository get _repo => ref.read(baoCaoTaiChinhRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build

  }


  Future<void> save(String form, int year)async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async{
      await _repo.luuBaoCao(form, year);
    });
  }

}