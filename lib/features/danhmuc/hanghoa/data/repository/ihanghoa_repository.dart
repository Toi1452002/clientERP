import 'dart:async';
import 'dart:typed_data';

import 'package:erp_client_1/features/danhmuc/hanghoa/data/model/hanghoa_lookup_model.dart';

import '../model/hanghoa_model.dart';
import '../model/hanghoaview_model.dart';
import '../model/loaihang_model.dart';


abstract interface class IHangHoaRepository{
  Future<List<HangHoaViewModel>> getView();

  Future<List<LoaiHangModel>> getLoaiHang();

  Future<int> add(HangHoaModel hangHoa);
  Future<HangHoaModel> getById(int id);
  Future<void> update(HangHoaModel hangHoa, int id);
  Future<void> delete(int id);
  Future<List<HangHoaLookupModel>> getLookup();
}