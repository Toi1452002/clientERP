import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhap_model.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhapct_model.dart';

class PhieuNhapRequestModel {
  final PhieuNhapModel phieuNhap;
  final List<PhieuNhapCTModel> phieuNhapCT;

  const PhieuNhapRequestModel({required this.phieuNhap, required this.phieuNhapCT});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'phieuNhap': phieuNhap,
  //     'phieuNhapCT': phieuNhapCT,
  //   };
  // }

  factory PhieuNhapRequestModel.fromMap(Map<String, dynamic> map) {
    final phieuNhap = map['phieuNhap'] as Map<String, dynamic>;
    final phieuNhapCT = map['phieuNhapCT'] as List;
    return PhieuNhapRequestModel(
      phieuNhap: PhieuNhapModel.fromMap(phieuNhap),
      phieuNhapCT: phieuNhapCT.map((e) => PhieuNhapCTModel.fromMap(e)).toList(),
    );
  }

  PhieuNhapRequestModel copyWith({
    PhieuNhapModel? phieuNhap,
    List<PhieuNhapCTModel>? phieuNhapCT,
  }) {
    return PhieuNhapRequestModel(
      phieuNhap: phieuNhap ?? this.phieuNhap,
      phieuNhapCT: phieuNhapCT ?? this.phieuNhapCT,
    );
  }
}
