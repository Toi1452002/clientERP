
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/hanghoaview_model.dart';
import '../../data/repository/hanghoa_repository.dart';
import '../../data/repository/ihanghoa_repository.dart';

final hangHoaViewProvider = AsyncNotifierProvider(HangHoaViewController.new,retry: (_,_)=>null);

class HangHoaViewController extends AsyncNotifier<List<HangHoaViewModel>>{
  IHangHoaRepository get _repo => ref.read(hangHoaRepositoryProvider);

  @override
  Future<List<HangHoaViewModel>> build() async {
    return await getView();
  }

  Future<List<HangHoaViewModel>> getView() async {
    return await _repo.getView();
  }

  Future<void> deleteHangHoa(int id) async{
    try{
      await _repo.delete(id);
    }catch(e){
      rethrow;
    }
  }

}