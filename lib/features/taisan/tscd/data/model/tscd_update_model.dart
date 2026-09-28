import 'package:erp_client_1/core/utils/date_helper.dart';

class TSCDUpdateModel{
  final int hangHoaId;
  final String? boPhanSD;
  final num? nguyenGia;
  final DateTime? ngayMua;
  final DateTime? ngaySD;
  final int? soNamPB;
  final String? tkChiPhi;
  final String? tkHaoMon;

  const TSCDUpdateModel({
    required this.hangHoaId,
    this.boPhanSD,
    this.nguyenGia,
    this.ngayMua,
    this.ngaySD,
    this.soNamPB,
    this.tkChiPhi,
    this.tkHaoMon,
  });

  Map<String, dynamic> toMap() {
    return {
      'hangHoaId': hangHoaId,
      'boPhanSD': boPhanSD,
      'nguyenGia': nguyenGia,
      'ngayMua': DateHelper.yMd(ngayMua),
      'ngaySD': DateHelper.yMd(ngaySD),
      'soNamPB': soNamPB,
      'tkChiPhi': tkChiPhi,
      'tkHaoMon': tkHaoMon,
    };
  }

}