import '../../../../../core/utils/date_helper.dart';

class DKyHangHoaRequestModel{
  final int hangHoaId;
  final DateTime ngay;
  final num soTon;
  final num giaVon;

  const DKyHangHoaRequestModel({
    required this.hangHoaId,
    required this.ngay,
    required this.soTon,
    required this.giaVon,
  });

  Map<String, dynamic> toMap() {
    return {
      'hangHoaId': hangHoaId,
      'ngay': DateHelper.yMd(ngay),
      'soTon': soTon,
      'giaVon': giaVon,
      'thang': DateHelper.yM(DateTime(ngay.year, ngay.month-1)),
    };
  }

}