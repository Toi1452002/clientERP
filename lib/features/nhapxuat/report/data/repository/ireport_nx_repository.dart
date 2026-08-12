import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hangban_model.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hoadon_mua_model.dart';

import '../model/bke_hoadon_ban_model.dart';

abstract interface class IReportNxRepository{
  Future<List<BKeHoaDonMuaModel>> getHoaDonMua(DateTime tuNgay, DateTime denNgay);
  Future<List<BKeHoaDonBanModel>> getHoaDonBan(DateTime tuNgay, DateTime denNgay);
  Future<List<BkeHangBanModel>> getHangBan(DateTime tuNgay, DateTime denNgay);
}