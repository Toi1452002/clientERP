import '../../../../../core/utils/date_helper.dart';

class PhieuXuatSaveModel{
  final DateTime? ngay;
  final String? maKH;
  final String maNX;
  final String? dienGiai;
  final num? congTien;
  final int? thueSuat;
  final num? tienThue;
  final String? kyHieu;
  final String? soHD;
  final DateTime? ngayCT;
  final String? tkNo;
  final String? tkCo;
  final String? tkVatNo;
  final String? tkVatCo;
  final String pttt;

  const PhieuXuatSaveModel({
    this.ngay,
    this.maKH,
    required this.maNX,
    this.dienGiai,
    this.congTien,
    this.thueSuat,
    this.tienThue,
    this.kyHieu,
    this.soHD,
    this.ngayCT,
    this.tkNo,
    this.tkCo,
    this.tkVatNo,
    this.tkVatCo,
    required this.pttt,
  });

  Map<String, dynamic> toMap() {
    return {
      'ngay': DateHelper.yMd(ngay),
      'maKH': maKH,
      'maNX': maNX,
      'dienGiai': dienGiai,
      'congTien': congTien,
      'thueSuat': thueSuat,
      'tienThue': tienThue,
      'kyHieu': kyHieu,
      'soHD': soHD,
      'ngayCT': DateHelper.yMd(ngayCT),
      'tkNo': tkNo,
      'tkCo': tkCo,
      'tkVatNo': tkVatNo,
      'tkVatCo': tkVatCo,
      'pttt': pttt,
    };
  }

}