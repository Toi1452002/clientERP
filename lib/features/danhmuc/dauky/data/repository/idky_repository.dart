import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_hanghoa_request_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_hanghoa_view_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_khachhang_request_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_khachhang_view_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_taikhoan_view_model.dart';

abstract interface class IDkyRepository{
  Future<List<DKyKhachHangViewModel>> getViewDKyKhachHang();
  Future<List<DKyHangHoaViewModel>> getViewDKyHangHoa();
  Future<List<DKyTaiKhoanViewModel>> getViewDKyTaiKhoan();


  Future<int> updateDKyKhachHang(List<DKyKhachHangRequestModel> data);
  Future<int> updateDkyHangHoa(List<DKyHangHoaRequestModel> data);
  Future<bool> updateDKyTaiKhoan(String thang);

  Future<int> updateCKNo(num value, String maTK);
  Future<int> updateCKCo(num value, String maTK);

}