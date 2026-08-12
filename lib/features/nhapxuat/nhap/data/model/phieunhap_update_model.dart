import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhap_save_model.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhapct_model.dart';

class PhieuNhapUpdateModel{
  final PhieuNhapSaveModel phieuNhap;
  final List<PhieuNhapCTModel> phieuNhapCT;

  const PhieuNhapUpdateModel({
    required this.phieuNhap,
    required this.phieuNhapCT,
  });
}