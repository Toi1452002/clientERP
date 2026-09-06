import 'package:erp_client_1/core/utils/date_helper.dart';

class KetChuyenViewModel{
  final int id;
  final String? butToan;
  final DateTime? ngay;
  final DateTime? ngayCT;
  final String? soCT;
  final String? dienGiai;
  final String? tkNo;
  final String? tkCo;
  final num? soPS;

  const KetChuyenViewModel({
    required this.id,
    required this.butToan,
    required this.ngay,
    required this.ngayCT,
    required this.soCT,
    this.dienGiai,
    required this.tkNo,
    required this.tkCo,
    required this.soPS,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'butToan': butToan,
      'ngay': DateHelper.yMd(ngay),
      'ngayCT': DateHelper.yMd(ngayCT),
      'soCT': soCT!.isEmpty?null:soCT,
      'dienGiai': dienGiai,
      'tkNo': tkNo,
      'tkCo': tkCo,
      'soPS': soPS,
    };
  }

  factory KetChuyenViewModel.fromMap(Map<String, dynamic> map) {
    return KetChuyenViewModel(
      id: map['id'] ,
      butToan: map['butToan'] ,
      ngay: DateTime.parse(map['ngay']) ,
      ngayCT: DateTime.parse(map['ngayCT']) ,
      soCT: map['soCT'] ,
      dienGiai: map['dienGiai'] ,
      tkNo: map['tkNo'] ,
      tkCo: map['tkCo'] ,
      soPS: map['soPS'] ,
    );
  }
}