import 'package:erp_client_1/features/thuchi/report/data/model/bke_so_quy_model.dart';

class SoQuyRequestModel{
  final List<BKeSoQuyModel> bkeSoQuy;
  final num dauKy;
  final num cuoiKy;

  const SoQuyRequestModel({
    required this.bkeSoQuy,
    required this.dauKy,
    required this.cuoiKy,
  });


  factory SoQuyRequestModel.fromMap(Map<String, dynamic> map) {
    final lst = map['bKeSoQuy'] as List;
    return SoQuyRequestModel(
      bkeSoQuy: lst.map((e)=>BKeSoQuyModel.fromMap(e)).toList(),
      dauKy: map['dauKy'],
      cuoiKy: map['cuoiKy'],
    );
  }

}