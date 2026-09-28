import 'package:erp_client_1/core/utils/date_helper.dart';

class UpdateSoCongModel{
  final int bangCongId;
  final DateTime ngay;
  final String kyHieu;

  const UpdateSoCongModel({
    required this.bangCongId,
    required this.ngay,
    required this.kyHieu,
  });

  Map<String, dynamic> toMap() {
    return {
      'bangCongId': bangCongId,
      'ngay': DateHelper.yMd(ngay),
      'kyHieu': kyHieu,
    };
  }


}