import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/hanghoa_model.dart';
import '../../data/model/loaihang_model.dart';
import '../../data/repository/hanghoa_repository.dart';
import '../../data/repository/ihanghoa_repository.dart';

final hangHoaEditProvider = AsyncNotifierProvider.autoDispose(HangHoaEditController.new, retry: (_,_)=> null);


final loaiHangProvider = FutureProvider<List<LoaiHangModel>>((ref) async {
  return await ref.read(hangHoaRepositoryProvider).getLoaiHang();
},retry: (_,_)=>null);


class HangHoaEditController extends AsyncNotifier<void>{

  IHangHoaRepository get _repo => ref.read(hangHoaRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> addHangHoa(HangHoaModel hangHoa) async{
    try{
      state = AsyncLoading();
      if (hangHoa.maHH.trim().isEmpty) throw Exception("Mã hàng hóa trống");
      if (hangHoa.tenHH.trim().isEmpty) throw Exception("Tên hàng hóa trống");
      state = await AsyncValue.guard(() async{
        await _repo.add(hangHoa);
      });
    }catch(e,s){
      state = AsyncError(e.toString(), s);
    }
  }

  Future<HangHoaModel?> getById(int id) async{
    try{
      return await _repo.getById(id);
    }catch(e,s){
      state = AsyncError(e.toString(), s);
      return null;
    }
  }
  Future<void> updateHangHoa(HangHoaModel hangHoa, int id) async{
    try{
      state = AsyncLoading();
      if (hangHoa.maHH.trim().isEmpty) throw Exception("Mã hàng hóa trống");
      if (hangHoa.tenHH.trim().isEmpty) throw Exception("Tên hàng hóa trống");
      state = await AsyncValue.guard(() async{
        await _repo.update(hangHoa, id);
      });
    }catch(e,s){
      state = AsyncError(e.toString(), s);
    }
  }
}