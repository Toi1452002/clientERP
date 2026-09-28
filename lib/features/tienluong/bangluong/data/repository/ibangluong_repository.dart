import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_update_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_view_model.dart';

abstract interface class IBangLuongRepository {
  Future<List<BangLuongViewModel>> getView(int month, int year);

  Future<int> delete(int id);

  Future<BangLuongViewModel> updateCell(BangLuongUpdateModel model, int id, String field);

  Future<BangLuongViewModel> addRow(int month, int year);

  Future<List<PCGTViewCTModel>> getPCGT(String maNV, String maPC);
}
