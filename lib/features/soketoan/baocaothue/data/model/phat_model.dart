import 'package:erp_client_1/core/utils/date_helper.dart';

class PhatModel{
  final int id;
  final String? nam;
  final DateTime? ngay;
  final String? noiDung;
  final num? soKiemTra;
  final num? soDaNop;
  final num? conPhaiNop;

  const PhatModel({
    required this.id,
    this.nam,
    this.ngay,
    this.noiDung,
    this.soKiemTra,
    this.soDaNop,
    this.conPhaiNop,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nam': nam,
      'ngay': DateHelper.yMd(ngay),
      'noiDung': noiDung,
      'soKiemTra': soKiemTra,
      'soDaNop': soDaNop,
      'conPhaiNop': (soKiemTra??0)-(soDaNop??0),
    };
  }

  factory PhatModel.fromMap(Map<String, dynamic> map) {
    return PhatModel(
      id: map['id'] ,
      nam: map['nam'] ,
      ngay: map['ngay'] ==null?null:DateTime.tryParse(map['ngay']) ,
      noiDung: map['noiDung'] ??"",
      soKiemTra: map['soKiemTra'] ,
      soDaNop: map['soDaNop'] ,
      conPhaiNop: map['conPhaiNop'] ,
    );
  }
  factory PhatModel.fromJson(Map<String, dynamic> map) {
    return PhatModel(
      id: map['Id'] ,
      nam: map['Nam'] ,
      ngay: DateHelper.stringToDate(map['Ngay']) ,
      noiDung: map['NoiDung'] ,
      soKiemTra: map['SoKiemTra'] ,
      soDaNop: map['SoDaNop'] ,
      conPhaiNop: map['ConPhaiNop'] ,
    );
  }
}