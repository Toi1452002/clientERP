import 'package:erp_client_1/core/utils/date_helper.dart';

class PhieuThuSaveModel{
  final DateTime ngay;
  final String? maTC;
  final String? maKH;
  final String? tenKH;
  final String? diaChi;
  final String? nguoiNop;
  final String? nguoiThu;
  final String? noiDung;
  final String? soCT;
  final String? tkNo;
  final String? tkCo;
  final String pttt;
  final num soTien;



  Map<String, dynamic> toMap() {
    return {
      'ngay': DateHelper.yMd(ngay),
      'maTC': maTC,
      'maKH': maKH,
      'tenKH': tenKH,
      'diaChi': diaChi,
      'nguoiNop': nguoiNop,
      'nguoiThu': nguoiThu,
      'noiDung': noiDung,
      'soCT': soCT,
      'tkNo': tkNo,
      'tkCo': tkCo,
      'pttt': pttt,
      'soTien': soTien,
    };
  }

  factory PhieuThuSaveModel.fromMap(Map<String, dynamic> map) {
    return PhieuThuSaveModel(
      ngay: map['ngay'] as DateTime,
      maTC: map['maTC'] as String,
      maKH: map['maKH'] as String,
      tenKH: map['tenKH'] as String,
      diaChi: map['diaChi'] as String,
      nguoiNop: map['nguoiNop'] as String,
      nguoiThu: map['nguoiThu'] as String,
      noiDung: map['noiDung'] as String,
      soCT: map['soCT'] as String,
      tkNo: map['tkNo'] as String,
      tkCo: map['tkCo'] as String,
      pttt: map['pttt'] as String,
      soTien: map['soTien'] as num,
    );
  }

  const PhieuThuSaveModel({
    required this.ngay,
    this.maTC,
    this.maKH,
    this.tenKH,
    this.diaChi,
    this.nguoiNop,
    this.nguoiThu,
    this.noiDung,
    this.soCT,
    this.tkNo,
    this.tkCo,
    required this.pttt,
    required this.soTien,
  });
}