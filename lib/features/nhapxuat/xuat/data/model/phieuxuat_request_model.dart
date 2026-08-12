import 'package:erp_client_1/features/nhapxuat/xuat/data/model/phieuxuat_ct_model.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/data/model/phieuxuat_model.dart';

class PhieuXuatRequestModel {
  final PhieuXuatModel phieuXuat;
  final List<PhieuXuatCTModel> phieuXuatCT;

  const PhieuXuatRequestModel({required this.phieuXuat, required this.phieuXuatCT});

  factory PhieuXuatRequestModel.fromMap(Map<String, dynamic> map) {
    final phieuXuat = map['phieuXuat'] as Map<String, dynamic>;
    final phieuXuatCT = map['phieuXuatCT'] as List;
    return PhieuXuatRequestModel(
      phieuXuat: PhieuXuatModel.fromMap(phieuXuat),
      phieuXuatCT: phieuXuatCT.map((e) => PhieuXuatCTModel.fromMap(e)).toList(),
    );
  }
}
