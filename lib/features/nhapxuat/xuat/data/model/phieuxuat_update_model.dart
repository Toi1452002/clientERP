import 'package:erp_client_1/features/nhapxuat/xuat/data/model/phieuxuat_ct_model.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/data/model/phieuxuat_save_model.dart';

class PhieuXuatUpdateModel{
  final PhieuXuatSaveModel phieuXuat;
  final List<PhieuXuatCTModel> phieuXuatCT;

  const PhieuXuatUpdateModel({
    required this.phieuXuat,
    required this.phieuXuatCT,
  });
}