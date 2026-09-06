
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_request_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_view_model.dart';

import '../model/taikhoan_lookup_model.dart';

abstract interface class ITaiKhoanRepository{
  Future<List<TaiKhoanLookupModel>> getKhoND();
  Future<List<TaiKhoanLookupModel>> getMaXL0();
  Future<List<TaiKhoanLookupModel>> getTKNoPx();
  Future<List<TaiKhoanLookupModel>> getTKCoPx();
  Future<List<TaiKhoanLookupModel>> getTKSoCai();
  Future<List<TaiKhoanViewModel>> getView();
  Future<int> add(TaiKhoanRequestModel model);
  Future<int> update(TaiKhoanRequestModel model, int id);
  Future<int> delete(int id);
  Future<TaiKhoanViewModel?> getEdit(int id);
}