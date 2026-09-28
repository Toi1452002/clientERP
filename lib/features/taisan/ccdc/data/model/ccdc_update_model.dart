import '../../../../../core/utils/date_helper.dart';

class CCDCUpdateModel{
  final int hangHoaId;
  final String? boPhanSD;
  final num? giaTri;
  final num? soLuong;
  final DateTime? ngayMua;
  final DateTime? ngaySD;
  final int? soThangPB;
  final String? tkChiPhi;
  final String? tkHaoMon;

  const CCDCUpdateModel({
    required this.hangHoaId,
    this.boPhanSD,
    this.giaTri,
    this.soLuong,
    this.ngayMua,
    this.ngaySD,
    this.soThangPB,
    this.tkChiPhi,
    this.tkHaoMon,
  });

  Map<String, dynamic> toMap() {
    return {
      'hangHoaId': hangHoaId,
      'boPhanSD': boPhanSD,
      'giaTri': giaTri,
      'soLuong': soLuong,
      'ngayMua': DateHelper.yMd(ngayMua),
      'ngaySD': DateHelper.yMd(ngaySD),
      'soThangPB': soThangPB,
      'tkChiPhi': tkChiPhi,
      'tkHaoMon': tkHaoMon,
    };
  }

}