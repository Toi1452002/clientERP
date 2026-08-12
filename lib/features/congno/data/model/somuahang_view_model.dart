import 'package:erp_client_1/features/congno/data/model/somuahang_model.dart';

class SoMuaHangViewModel{
  final List<SoMuaHangModel> soMuaHang;
  final num noDky;
  final num noCKy;

  const SoMuaHangViewModel({
    required this.soMuaHang,
    required this.noDky,
    required this.noCKy,
  });


  factory SoMuaHangViewModel.fromMap(Map<String, dynamic> map) {
    final data = map['soMuaHang'] as List;
    return SoMuaHangViewModel(
      soMuaHang: data.map((e)=>SoMuaHangModel.fromMap(e)).toList(),
      noDky: map['noDauKy'],
      noCKy: map['noCuoiKy'] ,
    );
  }

}