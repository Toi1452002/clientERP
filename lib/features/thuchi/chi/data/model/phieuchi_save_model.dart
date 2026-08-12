import '../../../../../core/utils/date_helper.dart';

class PhieuChiSaveModel{
  final DateTime ngay;
  final String? maTC;
  final String? maKH;
  final String? maNV;
  final String? tenKH;
  final String? diaChi;
  final String? nguoiChi;
  final String? nguoiNhan;
  final String? noiDung;
  final String? soCT;
  final String? tkNo;
  final String? tkCo;
  final String pttt;
  final num soTien;

  const PhieuChiSaveModel({
    required this.ngay,
    this.maTC,
    this.maKH,
    this.maNV,
    this.tenKH,
    this.diaChi,
    this.nguoiChi,
    this.nguoiNhan,
    this.noiDung,
    this.soCT,
    this.tkNo,
    this.tkCo,
    required this.pttt,
    required this.soTien,
  });

  Map<String, dynamic> toMap() {
    return {
      'ngay': DateHelper.yMd(ngay),
      'maTC': maTC,
      'maKH': maKH,
      'maNV': maNV,
      'tenKH': tenKH,
      'diaChi': diaChi,
      'nguoiChi': nguoiChi,
      'nguoiNhan': nguoiNhan,
      'noiDung': noiDung,
      'soCT': soCT,
      'tkNo': tkNo,
      'tkCo': tkCo,
      'pttt': pttt,
      'soTien': soTien,
    };
  }

  // factory PhieuChiSaveModel.fromMap(Map<String, dynamic> map) {
  //   return PhieuChiSaveModel(
  //     ngay: map['ngay'] as DateTime,
  //     maTC: map['maTC'] as String,
  //     maKH: map['maKH'] as String,
  //     maNV: map['maNV'] as String,
  //     tenKH: map['tenKH'] as String,
  //     diaChi: map['diaChi'] as String,
  //     nguoiChi: map['nguoiChi'] as String,
  //     nguoiNhan: map['nguoiNhan'] as String,
  //     noiDung: map['noiDung'] as String,
  //     soCT: map['soCT'] as String,
  //     tkNo: map['tkNo'] as String,
  //     tkCo: map['tkCo'] as String,
  //     pttt: map['pttt'] as String,
  //     soTien: map['soTien'] as num,
  //   );
  // }
}