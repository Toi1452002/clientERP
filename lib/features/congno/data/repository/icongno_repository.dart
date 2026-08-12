import 'package:erp_client_1/features/congno/data/model/somuahang_view_model.dart';
import 'package:erp_client_1/features/congno/data/model/tonghop_congno_model.dart';

import '../model/sobanhang_view_model.dart';

abstract interface class ICongNoRepository {
  Future<SoMuaHangViewModel> getSoMuaHang(String? maKH, DateTime tuNgay, DateTime denNgay);
  Future<SoBanHangViewModel> getSoBanHang(String? maKH, DateTime tuNgay, DateTime denNgay);
  Future<List<TongHopCongNoModel>> getTongHopCongNo(DateTime ngay);
}
