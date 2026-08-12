import 'package:erp_client_1/core/utils/date_helper.dart';

class DKyKhachHangRequestModel{
  final DateTime ngay;
  final String maKH;
  final num? soDuNo;
  // final String thang;

  const DKyKhachHangRequestModel({
    required this.ngay,
    required this.maKH,
    this.soDuNo,
    // required this.thang,
  });

  Map<String, dynamic> toMap() {
    return {
      'ngay': DateHelper.yMd(ngay),
      'maKH': maKH,
      'soDuNo': soDuNo,
      'thang': DateHelper.yM(DateTime(ngay.year, ngay.month-1)),
    };
  }


}