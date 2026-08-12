import 'package:erp_client_1/features/congno/data/model/sobanhang_model.dart';

class SoBanHangViewModel{
  final List<SoBanHangModel> soBanHang;
  final num noDKy;
  final num noCKy;

  const SoBanHangViewModel({
    required this.soBanHang,
    required this.noDKy,
    required this.noCKy,
  });


  factory SoBanHangViewModel.fromMap(Map<String, dynamic> map) {
    final data = map['soBanHang'] as List;
    return SoBanHangViewModel(
      soBanHang: data.map((e)=>SoBanHangModel.fromMap(e)).toList(),
      noDKy: map['noDauKy'],
      noCKy: map['noCuoiKy'],
    );
  }

}