import 'package:erp_client_1/core/utils/date_helper.dart';

class PhieuNhapSaveModel{
  final DateTime? ngay;
  final String? maKH;
  final String maNX;
  final String? dienGiai;
  final num? congTien;
  final num? thueSuat;
  final num? tienThue;
  final String? kyHieu;
  final String? soCT;
  final DateTime? ngayCT;
  final String? tkNo;
  final String? tkCo;
  final String? tkVatNo;
  final String? tkVatCo;
  final String pttt;

  const PhieuNhapSaveModel({
    this.ngay,
    this.maKH,
    required this.maNX,
    this.dienGiai,
    this.congTien,
    this.thueSuat,
    this.tienThue,
    this.kyHieu,
    this.soCT,
    this.ngayCT,
    required this.tkNo,
    required this.tkCo,
    required this.tkVatNo,
    required this.tkVatCo,
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
      'soCT': soCT,
      'ngayCT': DateHelper.yMd(ngayCT),
      'tkNo': tkNo,
      'tkCo': tkCo,
      'tkVatNo': tkVatNo,
      'tkVatCo': tkVatCo,
      'pttt': pttt,
    };
  }

  // factory PhieuNhapSaveModel.fromMap(Map<String, dynamic> map) {
  //   return PhieuNhapSaveModel(
  //     ngay: map['ngay'] as DateTime,
  //     maKH: map['maKH'] as String,
  //     maNX: map['maNX'] as String,
  //     dienGiai: map['dienGiai'] as String,
  //     congTien: map['congTien'] as num,
  //     thueSuat: map['thueSuat'] as int,
  //     tienThue: map['tienThue'] as num,
  //     kyHieu: map['kyHieu'] as String,
  //     soCT: map['soCT'] as String,
  //     ngayCT: map['ngayCT'] as DateTime,
  //     tkNo: map['tkNo'] as String,
  //     tkCo: map['tkCo'] as String,
  //     tkVatNo: map['tkVatNo'] as String,
  //     tkVatCo: map['tkVatCo'] as String,
  //     pttt: map['pttt'] as String,
  //   );
  // }
}