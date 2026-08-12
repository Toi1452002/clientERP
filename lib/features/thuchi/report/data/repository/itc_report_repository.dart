import 'package:erp_client_1/features/thuchi/report/data/model/bke_so_quy_model.dart';
import 'package:erp_client_1/features/thuchi/report/data/model/bke_thu_chi_model.dart';
import 'package:erp_client_1/features/thuchi/report/data/model/soquy_request_model.dart';

abstract interface class ITCReportRepository {
  Future<List<BKeThuChiModel>> getBkePhieuThu(DateTime tuNgay, DateTime denNgay);

  Future<List<BKeThuChiModel>> getBkePhieuChi(DateTime tuNgay, DateTime denNgay);

  Future<SoQuyRequestModel> getBkeSoQuyTM(DateTime tuNgay, DateTime denNgay);

  Future<SoQuyRequestModel> getBkeSoQuyTG(DateTime tuNgay, DateTime denNgay);
}
