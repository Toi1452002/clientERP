import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_edit_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_lookup_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_request_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_view_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';

abstract interface class INhanVienRepository{
  Future<List<NhanVienViewModel>> getView();

  Future<List<PCGTViewModel>> getPCGTView(int? nhanVienId);

  Future<NhanVienViewModel> add(NhanVienRequestModel nv, List<PCGTRequestModel> lstPC);

  Future<NhanVienEditModel> getById(int id);

  Future<NhanVienViewModel> update(NhanVienRequestModel nv, List<PCGTRequestModel> lstPC, int nhanVienId);

  Future<int> delete(int nhanVienId);

  Future<List<NhanVienLookupModel>> getLookup();

}